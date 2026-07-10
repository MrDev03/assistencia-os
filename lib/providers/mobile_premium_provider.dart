
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../db_helper/premium_helper.dart';
import '../sync/core/sync_service.dart';
import 'package:cloud_functions/cloud_functions.dart';

// TODO: Importe aqui as dependências do seu projeto (PremiumHelper, AppFlushbar, etc)

class PremiumProvider extends ChangeNotifier with WidgetsBindingObserver {

  StreamSubscription<DocumentSnapshot>? _subscriptionStream;

  // =========================================================
  // 🔑 SUAS CHAVES
  // =========================================================
  final _publicApiKeyAndroid = 'goog_OJaWiICDEYUtAopROSdOTdqmDJG';

  static const String entitlementId = 'pro_plan';

  // 👈 ADICIONE ESTE CONSTRUTOR AQUI
  PremiumProvider() {
    // Avisa ao Flutter que este Provider quer saber quando o app minimiza ou maximiza
    WidgetsBinding.instance.addObserver(this);
  }

  final SyncService _syncService = SyncService();

  // =========================================================
  // 🔗 LINKS DO STRIPE
  // =========================================================
  final String _stripeMonthlyUrl = "https://buy.stripe.com/eVq6oJdATgFk7kpgEM5wI00";
  final String _stripeAnnualUrl = "https://buy.stripe.com/7sYeVfbsLexc3493S05wI01";

  // =========================================================
  // 📦 VARIÁVEIS DE ESTADO
  // =========================================================
  bool isLoading = false;
  bool isPro = false;
  String txtErro = "";

  Package? monthlyPackage;
  Package? annualPackage;

  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  // =========================================================
  // 🚀 INICIALIZAÇÃO HÍBRIDA (Dupla Verificação)
  // =========================================================
  Future<void> init() async {
    isLoading = true;

    // 1. CARREGUE O STATUS LOCAL IMEDIATAMENTE
    try {
      // Substitua pelo método correto do seu PremiumHelper que lê o valor salvo
      isPro = await PremiumHelper.lerPremium();
    } catch (e) {
      debugPrint("Erro ao ler status local: $e");
    }

    notifyListeners(); // Atualiza a tela para Pro na hora (se for o caso)

    try {
      final user = _auth.currentUser;


      // 🔥 ADICIONE AQUI: O app agora ouve as mudanças do Firebase em tempo real!
      listenToFirebaseChanges(user?.uid);

      if (Platform.isWindows) {
        // 💻 ROTA WINDOWS
        bool hasStripe = await _checkStripeStatus(user);

        if (isPro) {
          saveSubscriptionStatusLocally(true);
        }

        if (!hasStripe && user != null) {
          await _checkRevenueCatREST(user.uid);
        }

      } else if (Platform.isAndroid) {
        // 📱 ROTA ANDROID
        await Purchases.setLogLevel(LogLevel.debug);
        PurchasesConfiguration configuration = PurchasesConfiguration(_publicApiKeyAndroid);
        if (user == null) return;
        configuration.appUserID = user.uid;
        await Purchases.configure(configuration);

        Purchases.addCustomerInfoUpdateListener((customerInfo) {
          _handleCustomerInfo(customerInfo);
        });

        await fetchOfferings();

        final customerInfo = await Purchases.getCustomerInfo();
        final bool hasRevenueCat = customerInfo.entitlements.all[entitlementId]?.isActive ?? false;

        if (hasRevenueCat) {
          await _handleCustomerInfo(customerInfo);
        } else {
          // Se não achou na Play Store, confere no Stripe e ele mesmo atualiza o status final
          await _checkStripeStatus(user);
        }
      }
    } catch (e) {
      debugPrint("Erro ao iniciar assinaturas: $e");
      txtErro = "Erro ao conectar com as lojas.";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Chame esta função dentro do seu init(), logo após verificar se o usuário está logado
  void listenToFirebaseChanges(String? uid) {
    // Cancela o stream anterior se houver
    _subscriptionStream?.cancel();

    if (uid == null) return;

    if (Platform.isWindows) {
      // 💻 WINDOWS: Usa .get() para evitar o bug fatal de C++ com Streams
      _checkFirebaseStatusOnceSafe(uid);
    } else {
      // 📱 ANDROID/iOS: Continua usando tempo real (Streams nativos funcionam bem)
      _subscriptionStream = _db
          .collection('users')
          .doc(uid)
          .collection('subscription')
          .doc('info')
          .snapshots()
          .listen((snapshot) {
        if (!snapshot.exists) return;
        _updatePremiumStateFromData(snapshot.data());
      });
    }
  }

  // Função auxiliar exclusiva para o Windows ler os dados sem crashar
  Future<void> _checkFirebaseStatusOnceSafe(String uid) async {
    try {
      final snapshot = await _db
          .collection('users')
          .doc(uid)
          .collection('subscription')
          .doc('info')
          .get(const GetOptions(source: Source.server));

      if (snapshot.exists) {
        _updatePremiumStateFromData(snapshot.data());
        debugPrint("✅ Firebase Windows: Status lido com segurança via GET.");
      }
    } catch (e) {
      debugPrint("❌ Erro ao ler dados no Windows: $e");
    }
  }

  // Função centralizada para não repetir código
  Future<void> _updatePremiumStateFromData(Map<String, dynamic>? data) async {
    final bool isNowActive = data?['active'] ?? false;

    if (isPro != isNowActive) {
      isPro = isNowActive;
      await saveSubscriptionStatusLocally(isPro);
      notifyListeners();
    }
  }

  // =========================================================
  // 💻 CONSULTA STRIPE (Com Sincronização Forçada)
  // =========================================================
  // Certifique-se de ter essas importações no topo:
// import 'dart:convert';
// import 'package:http/http.dart' as http;

  Future<bool> _checkStripeStatus(User? user) async {
    try {
      if (user == null) return false;

      if (user.email == null || user.email!.isEmpty) {
        await _syncStatusFailure(user.uid, 'windows_stripe');
        return false;
      }

      // 1. Pegamos o token nativo do Firebase do usuário logado.
      // É ISSO que faz o "request.auth" funcionar lá na Cloud Function!
      final idToken = await user.getIdToken();

      if (idToken == null) return false;

      // 2. Cole aqui a URL exata que você copiou do painel do Firebase
      // ATENÇÃO: Substitua pelo seu link real!
      const String functionUrl = 'https://verifysubscriptionstatus-6qfz47gvna-uc.a.run.app';

      // 3. Chamamos a Cloud Function manualmente via POST
      final response = await http.post(
        Uri.parse(functionUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $idToken', // Injeta a segurança aqui
        },
        // A especificação "onCall" do Firebase exige que enviemos os dados dentro da chave "data"
        body: jsonEncode({
          "data": {
            "email": user.email,
          }
        }),
      );

      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);

        // A resposta do "onCall" também volta embrulhada em "result" ou "data"
        final responseData = decodedResponse['result'] ?? decodedResponse['data'] ?? {};

        bool foundActive = responseData['isPro'] == true;

        isPro = foundActive;

        // 🟢 CORREÇÃO: Só altera o estado global e salva localmente se encontrar a assinatura.
        // Se não encontrar, mantemos o status atual intacto e retornamos false.
        if (foundActive) {
          isPro = true;
          await saveSubscriptionStatusLocally(true);
        }

        return isPro;
      } else {
        debugPrint("Erro no servidor da Cloud Function: ${response.body}");
        return isPro;
      }

    } catch (e) {
      debugPrint("Erro ao verificar Stripe via HTTP Post: $e");

      // Em caso de falha de rede, mantemos o status que o usuário já tinha
      return isPro;
    }
  }

  // =========================================================
  // 💻 CONSULTA REVENUECAT VIA HTTP
  // =========================================================
  Future<bool> _checkRevenueCatREST(String uid) async {
    try {
      final response = await http.get(
        Uri.parse('https://api.revenuecat.com/v1/subscribers/$uid'),
        headers: {
          'Authorization': 'Bearer $_publicApiKeyAndroid',
          'Content-Type': 'application/json',
        },
      );

      bool foundActive = false;

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final entitlements = data['subscriber']?['entitlements'];

        if (entitlements != null && entitlements[entitlementId] != null) {
          final expiresDateStr = entitlements[entitlementId]['expires_date'];

          if (expiresDateStr == null) {
            foundActive = true;
          } else {
            foundActive = DateTime.parse(expiresDateStr).isAfter(DateTime.now());
          }
        }
      }

      isPro = foundActive;

      // Atualiza local e cloud SEMPRE
      await saveSubscriptionStatusLocally(isPro);
      await _saveSubscriptionStatusToFirebase(
          isActive: isPro,
          uid: uid,
          platform: 'via_windows'
      );

      return isPro;

    } catch (e) {
      debugPrint("Erro ao verificar RevenueCat no Windows: $e");
      return false;
    }
  }

  // =========================================================
  // 💰 FUNÇÕES DE COMPRA E STRIPE CHECKOUT
  // =========================================================
  Future<void> buyMonthly() async {

    if (isPro) {
      txtErro = "Você já possui uma assinatura ativa. Caso tenha problemas, clique em restaurar compra ou contate o suporte nas configurações.";
      notifyListeners();
      return;
    }

    if (Platform.isWindows) {
      await _launchStripeCheckout(_stripeMonthlyUrl);
      return;
    }
    if (monthlyPackage == null) return;
    await _makePurchase(monthlyPackage!);
  }

  Future<void> buyYearly() async {

    if (isPro) {
      txtErro = "Você já possui uma assinatura ativa. Caso tenha problemas, clique em restaurar compra ou contate o suporte nas configurações.";
      notifyListeners();
      return;
    }

    if (Platform.isWindows) {
      await _launchStripeCheckout(_stripeAnnualUrl);
      return;
    }
    if (annualPackage == null) return;
    await _makePurchase(annualPackage!);
  }

  Future<void> _makePurchase(Package package) async {
    isLoading = true;
    notifyListeners();

    try {
      final purchaseParams = PurchaseParams.package(package);
      final result = await Purchases.purchase(purchaseParams);
      final CustomerInfo customerInfo = (result as dynamic).customerInfo;

      await _handleCustomerInfo(customerInfo);

    } on PlatformException catch (e) {
      var errorCode = PurchasesErrorHelper.getErrorCode(e);
      if (errorCode != PurchasesErrorCode.purchaseCancelledError) {
        txtErro = "Erro na compra: ${e.message}";
      }
    } catch (e) {
      debugPrint("Erro debug: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _launchStripeCheckout(String url) async {
    final user = _auth.currentUser;
    if (user == null) return;

    final emailQuery = user.email != null ? "&prefilled_email=${user.email}" : "";
    final uri = Uri.parse("$url?client_reference_id=${user.uid}$emailQuery");

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  // =========================================================
  // 🔄 RESTAURAR COMPRAS (Reforçado para False)
  // =========================================================
  Future<void> restorePurchases() async {
    isLoading = true;
    txtErro = "";
    notifyListeners();

    try {
      final user = _auth.currentUser;
      if (user == null) {
        txtErro = "Faça login para restaurar compras.";
        isLoading = false;
        notifyListeners();
        return;
      }

      if (Platform.isWindows) {
        bool hasStripe = await _checkStripeStatus(user);
        if (!hasStripe) {
          bool hasRc = await _checkRevenueCatREST(user.uid);
          if (hasRc) {
            // Sucesso Play Store
          } else {
            // Garante que se não tem em lugar nenhum, é forçado a ser falso
            await _syncStatusFailure(user.uid, 'none');
          }
        }
        return;
      }

      // Android
      CustomerInfo customerInfo = await Purchases.restorePurchases();
      final hasRevenueCat = customerInfo.entitlements.all[entitlementId]?.isActive ?? false;

      if (hasRevenueCat) {
        await _handleCustomerInfo(customerInfo);
      } else {
        bool hasStripe = await _checkStripeStatus(user);
        if (!hasStripe) {
          // Se chegou aqui, não tem RC nem Stripe
          await _syncStatusFailure(user.uid, 'none');
          txtErro = "Você não possui nenhuma assinatura ativa.";
        }
      }
    } on PlatformException catch (e) {
      txtErro = "Erro na loja: ${e.message}";
    } catch (e) {
      txtErro = "Erro ao restaurar: $e";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // =========================================================
  // ⚙️ GERENCIADORES INTERNOS E BANCO DE DADOS
  // =========================================================
  Future<void> fetchOfferings() async {
    try {
      Offerings offerings = await Purchases.getOfferings();
      if (offerings.current != null) {
        final available = offerings.current!.availablePackages;
        monthlyPackage = offerings.current!.monthly ?? available.firstWhere((p) => p.identifier == 'rc_monthly', orElse: () => available.first);
        annualPackage = offerings.current!.annual ?? available.firstWhere((p) => p.identifier == 'rc_annual', orElse: () => available.last);
      }
    } catch (e) {
      debugPrint("Erro ao buscar ofertas: $e");
    }
  }

  // =========================================================
  // ⚙️ GERENCIADOR DE STATUS DO REVENUECAT (CORRIGIDO)
  // =========================================================
  Future<void> _handleCustomerInfo(CustomerInfo customerInfo) async {
    final EntitlementInfo? entitlement = customerInfo.entitlements.all[entitlementId];
    final bool isRcActive = entitlement?.isActive ?? false;

    // 1. Variáveis para armazenar os Timestamps convertidos
    Timestamp? expirationTimestamp;
    Timestamp? latestPurchaseTimestamp;
    Timestamp? primeiraCompraTimestamp;

    // 2. Conversão segura de String (RevenueCat) -> DateTime -> Timestamp
    if (entitlement?.expirationDate != null) {
      final parsedDate = DateTime.tryParse(entitlement!.expirationDate!);
      if (parsedDate != null) {
        expirationTimestamp = Timestamp.fromDate(parsedDate);
      }
    }

    if (entitlement?.latestPurchaseDate != null) {
      final parsedDate = DateTime.tryParse(entitlement!.latestPurchaseDate);
      if (parsedDate != null) {
        latestPurchaseTimestamp = Timestamp.fromDate(parsedDate);
      }
    }

    if (entitlement?.originalPurchaseDate != null) {
      final parsedDate = DateTime.tryParse(entitlement!.originalPurchaseDate);
      if (parsedDate != null) {
        primeiraCompraTimestamp = Timestamp.fromDate(parsedDate);
      }
    }

    // 3. A NOVA LÓGICA DE DECISÃO
    if (isRcActive) {
      // ✅ TEM REVENUECAT! Libera o Pro e salva no Firebase como True.
      isPro = true;
      await saveSubscriptionStatusLocally(true);

      final uid = _auth.currentUser?.uid;
      if (uid != null) {
        await _saveSubscriptionStatusToFirebase(
            isActive: true, // Salva positivo com segurança
            uid: uid,
            expirationDate: expirationTimestamp,
            latestPurchaseDate: latestPurchaseTimestamp,
            primeiraCompra: primeiraCompraTimestamp,
            plano: entitlement?.productIdentifier,
            platform: 'android_revenuecat'
        );
      }
    } else {
      // ❌ NÃO TEM REVENUECAT!
      // AQUI ESTAVA O ERRO: Não podemos salvar 'false' no Firebase ainda.
      // O usuário pode ser Pro pelo Windows (Stripe).
      final user = _auth.currentUser;
      if (user != null) {
        // Pedimos para o Stripe verificar.
        // Se a Cloud Function ver que também não tem Stripe, ela mesma salva 'false' lá no Firebase.
        await _checkStripeStatus(user);
      }
    }

    notifyListeners();
  }

  // MÉTODO AUXILIAR PARA FORÇAR O CANCELAMENTO EM TUDO
  Future<void> _syncStatusFailure(String uid, String platform) async {
    isPro = false;
    await saveSubscriptionStatusLocally(false);
    await _saveSubscriptionStatusToFirebase(isActive: false, uid: uid, platform: platform);
  }

  Future<void> saveSubscriptionStatusLocally(bool isPremium) async {
    try {
      // ✅ AQUI ESTÁ A CORREÇÃO: Retirei o comentário que impedia o salvamento
      PremiumHelper.salvarPremium(isPremium);
    } catch (e) {
      debugPrint("Erro armazenamento local: $e");
    }
  }

  Future<void> _saveSubscriptionStatusToFirebase({
    required bool isActive,
    required String uid,
    Timestamp? latestPurchaseDate,
    Timestamp? expirationDate,
    Timestamp? primeiraCompra,
    bool? renovacao,
    String? plano,
    required String platform,
  }) async {
    try {
      final docRef = _db.collection('users').doc(uid).collection('subscription').doc('info');

      // Agora ele vai salvar "active: false" no Firebase caso o plano acabe
      await docRef.set({
        'active': isActive,
        'updatedAt': FieldValue.serverTimestamp(),
        'expirationDate': expirationDate,
        'lastPurchaseDate': latestPurchaseDate,
        'primeiraCompra': primeiraCompra,
        'renovacao': renovacao,
        'plano': plano,
        'platform': platform,
      }, SetOptions(merge: true));

    } catch (e) {
      debugPrint("Erro Firestore: $e");
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    // Se o aplicativo voltou a ficar ativo (O usuário fechou o navegador e clicou no app)
    if (state == AppLifecycleState.resumed) {
      _silentSync();

      // Adicione isso se quiser forçar a leitura do Firebase ao focar na janela:
      final user = _auth.currentUser;
      if (user != null && Platform.isWindows) {
        _checkFirebaseStatusOnceSafe(user.uid);
      }
    }
  }

  // =========================================================
  // 🤫 SINCRONIZAÇÃO SILENCIOSA DE FOCO DE JANELA
  // =========================================================
  Future<void> _silentSync() async {
    final user = _auth.currentUser;
    if (user == null) return;

    if (Platform.isWindows) {
      debugPrint("🔄 Janela do Windows ganhou foco. Verificando Stripe silenciosamente...");
      bool hasStripe = await _checkStripeStatus(user);

      if (!hasStripe) {
        await _checkRevenueCatREST(user.uid);
      }
      if (!isPro) {
        _syncService.start();
      }
    }
    // No Android não precisamos fazer nada aqui, pois o SDK do RevenueCat já é nativamente reativo
  }

  // Não se esqueça de fechar o stream quando o usuário fizer logout
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this); // 👈 ADICIONE ISTO AQUI
    _subscriptionStream?.cancel();
    _syncService.stop();
    super.dispose();
  }

}