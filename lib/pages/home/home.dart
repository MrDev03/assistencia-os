import 'dart:async';
import 'dart:typed_data';
import 'package:assistencia_os/custom_widgets/dialog.dart';
import 'package:assistencia_os/custom_widgets/top_msg.dart';
import 'package:assistencia_os/db_helper/cargo_helper.dart';
import 'package:assistencia_os/db_helper/premium_helper.dart';
import 'package:assistencia_os/pages/auth/auth_gate.dart';
import 'package:assistencia_os/pages/clientes/cadastro_ou_editar_cliente.dart';
import 'package:assistencia_os/pages/service_registration/base_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:assistencia_os/pages/empresa/empresa_info_page.dart';
import 'package:flutter/services.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:isar_community/isar.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../custom_widgets/card_servico_status/card_servico.dart';
import '../../db_helper/db_helper.dart';
import '../../models/cliente_model/cliente_model.dart';
import '../../models/empresa_model/empresa_model.dart';
import '../../models/servico_model/servico_model.dart';
import '../../sync/core/sync_service.dart';
import '../../sync/modules/servico_sync.dart';
import '../../sync/modules/status_sync.dart';
import '../estoque_peças/nova_peca.dart';
import 'components/body_superior.dart';
import 'conteudo_body.dart';
import 'services/dashboard_data.dart';

/// Extensão utilitária para detectar tamanhos de tela (usada para responsividade)
extension ScreenSize on BuildContext {
  bool get isDesktop => MediaQuery.of(this).size.width >= 900;
  bool get isTablet => MediaQuery.of(this).size.width >= 600 && MediaQuery.of(this).size.width < 900;
  bool get isMobile => MediaQuery.of(this).size.width < 600;
}

class Home extends StatefulWidget {
  const Home({
    super.key,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Empresa? empresaLogo;
  String? cargoAtual;
  final statusSync = StatusSync();

  final clientesStreamSafe =
  DatabaseHelper.watchClientes()
      .onErrorReturnWith((e, s) {
    debugPrint('Erro clientes: $e');
    return [];
  });

  final servicosStreamSafe =
  DatabaseHelper.watchServicos()
      .onErrorReturn([]);

  final empresaStreamSafe =
  DatabaseHelper.watchEmpresa()
      .onErrorReturn(null);

  final subscriptionStreamSafe =
  DatabaseHelper.watchIsPremium()
      .onErrorReturn(false);

  final servicosPendentesStreamSafe =
  DatabaseHelper.watchServicosPendentes()
      .onErrorReturn([]);


  late final Stream<DashboardData> combinedStream =
  Rx.combineLatest5<
      List<Cliente>,
      List<Servico>,
      Empresa?,
      bool,
      List<Servico>,
      DashboardData>(
    clientesStreamSafe,
    servicosStreamSafe,
    empresaStreamSafe,
    subscriptionStreamSafe,
    servicosPendentesStreamSafe,
        (clientes, servicos, empresa, subscription, pendentes) {
      return DashboardData(
        clientes: clientes,
        servicos: servicos,
        servicosPendentes: pendentes,
        empresa: empresa,
        subscription: subscription,
      );
    },
  );

  late Stream<DashboardData> _minhaStream;

  final servicoSync = ServicoSync();
  Timer? _timerVerificacao; // <--- Adicione isto

  @override
  void initState() {
    super.initState();
    carregarDados();

    // Configura para rodar novamente a cada 60 segundos
    _timerVerificacao = Timer.periodic(const Duration(seconds: 60), (timer) {
      _verificarEAtualizarAtrasados();
    });

    _minhaStream = combinedStream
        .distinct((prev, next) =>
    prev.clientes.length == next.clientes.length &&
        prev.servicos.length == next.servicos.length &&
        prev.aguardandoCliente == next.aguardandoCliente &&
        prev.emAndamento == next.emAndamento &&
        prev.atrasados == next.atrasados &&
        prev.semSolucao == next.semSolucao &&
        prev.servicosPendentes.length == next.servicosPendentes.length &&
        prev.subscription == next.subscription &&
        prev.empresa?.nome == next.empresa?.nome
    ).shareReplay(maxSize: 1);

  }

  @override
  void dispose() {
    _timerVerificacao?.cancel();
    disposeListener();
    super.dispose();
  }

  Future<void> salvarVisibilidade(bool visible) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('valor_visivel', visible);
  }

  Future<bool> carregarVisibilidade() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('valor_visivel') ?? true;
  }


  Future<void> carregarDados() async {
    var cargoSalvo = await CargoHelper.lerCargo();
    visibleMoney = await carregarVisibilidade();

    if (cargoSalvo == null) {
      await CargoHelper.salvarCargo('admin');
      cargoSalvo = 'admin';
    }

    if (!mounted) return;

    setState(() {
      switch (cargoSalvo) {
        case 'admin':
          cargoAtual = 'Administrador';
          break;
        case 'tecnico':
          cargoAtual = 'Técnico';
          break;
        case 'atendente':
          cargoAtual = 'Atendente';
          break;
        default:
          cargoAtual = 'Administrador';
      }
    });
  }

  Future<void> limparBanco() async {
    final isar = DatabaseHelper.isar; // ou await Isar.open([...]);

    await isar.writeTxn(() async {
      await isar.clear(); // limpa todas as coleções
    });
  }
  //bool visible = true;
  bool visibleMoney = true;

  Widget _buildLoading() {
    return Scaffold(
      body: Center(
        child: LoadingAnimationWidget.staggeredDotsWave(
          color: Theme.of(context).colorScheme.primary,
          size: 50,
        ),
      ),
    );
  }

  Widget _buildErro(
      BuildContext context, {
        required String mensagem,
        String? detalhe,
      }) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.cloud_off, size: 64, color: Colors.redAccent),
              const SizedBox(height: 16),
              Text(
                mensagem,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (detalhe != null) ...[
                const SizedBox(height: 8),
                Text(
                  detalhe,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
              const SizedBox(height: 24),
              ElevatedButton.icon(
                icon: const Icon(Icons.refresh),
                label: const Text('Tentar novamente'),
                onPressed: () {
                  // força rebuild do StreamBuilder
                  (context as Element).markNeedsBuild();
                },
              )
            ],
          ),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    //final isar = DatabaseHelper.isar;
    final theme = Theme.of(context).colorScheme;

    return Stack(
      children: [
        StreamBuilder(
          stream: _minhaStream,
          initialData: lastData,
          builder: (context, asyncSnapshot) {

            final empresa = asyncSnapshot.data?.empresa;

            return Scaffold(

                backgroundColor: Theme.of(context).colorScheme.primary,

                appBar: _buildAppBar(empresa, asyncSnapshot),

                body: _buildBody(asyncSnapshot),

                floatingActionButton: context.isDesktop || context.isTablet ? null : _buildFloatingActionButton(theme)

            );
          }
        ),
        const SyncOverlay(),
      ],
    );
  }

  PreferredSizeWidget _buildAppBar(Empresa? empresa, AsyncSnapshot<DashboardData> snapshot) {
    return AppBar(
      titleSpacing: 0,
      centerTitle: false,
      backgroundColor: Colors.transparent,

      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Theme.of(context).colorScheme.primary,
        statusBarIconBrightness: Brightness.light,
      ),

      title: context.isMobile ? Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            empresa?.nome?.isEmpty ?? true
                ? "Bem-vindo!"
                : !context.isMobile
                ? "    Assistencia OS"
                : "Olá, ${empresa!.nome}",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(FirebaseAuth.instance.currentUser?.email ?? "não logado. Faça login para salvar e sincronizar seus dados em nuvem",
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.7),
              fontSize: 14,
            ),
          )
        ],
      ) : null,

      leading: !context.isMobile
          ? null
          : Padding(
        padding: const EdgeInsets.all(8.0),
        child: buildLogo(
          empresa ?? Empresa(),
          size: 25,
        ),
      ),

      actions: [
        // IconButton(
        //   style: IconButton.styleFrom(
        //     backgroundColor: Colors.white.withValues(alpha: 0.2),
        //     foregroundColor: Colors.white,
        //     splashFactory: NoSplash.splashFactory,
        //     iconSize: 20,
        //   ),
        //   onPressed: () {
        //     visibleMoney = !visibleMoney;
        //     salvarVisibilidade(visibleMoney);
        //     setState(() {});
        //   },
        //   icon: Icon(visibleMoney ? Icons.visibility_off : Icons.visibility, color: Colors.white.withValues(alpha: 0.7), size: 18),
        // ),
        btnAuth(context),
        const SizedBox(width: 16),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(150),
        child: BodySuperior(
          servicos: snapshot.data?.servicos ?? [],
          cargoAtual: cargoAtual ?? '',
          visibilidade: visibleMoney,
          onTap: () {
            visibleMoney = !visibleMoney;
            salvarVisibilidade(visibleMoney);
          },
        ),
      ),
    );
  }


  Widget _buildFloatingActionButton(ColorScheme theme) {
    return SpeedDial(
        activeIcon: Icons.close,
        icon: Icons.add,
        animatedIconTheme: const IconThemeData(size: 22.0),
        backgroundColor: theme.primary,
        activeBackgroundColor: Colors.redAccent,
        foregroundColor: Colors.white,
        //visible: visible,
        spacing: 6,
        spaceBetweenChildren: 6,
        curve: Curves.easeInOutCubicEmphasized,
        children: [

          SpeedDialChild(
            labelWidget: _botoesSpeedDial(
              label: 'Cadastrar cliente',
              icon: Icons.person_add_alt_1_rounded,
            ),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CadastroEditarCliente())),
          ),
          SpeedDialChild(
            labelWidget: _botoesSpeedDial(
              label: 'Nova Ordem de Serviço',
              icon: Icons.description_outlined,
            ),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const BaseScreen())),
          ),
        ]
    );
  }

  DashboardData? lastData;

  Widget _buildBody(AsyncSnapshot<DashboardData> snapshot) {

    // ❌ erro sempre tem prioridade
    if (snapshot.hasError) {
      return _buildErro(
        context,
        mensagem: 'Erro ao carregar os dados.',
        detalhe: snapshot.error.toString(),
      );
    }

    // ✅ atualiza cache sempre que chega dado novo
    if (snapshot.hasData) {
      lastData = snapshot.data;
    }

    // ✅ se estiver carregando MAS já tem cache → NÃO mostra loading
    if (snapshot.connectionState == ConnectionState.waiting && lastData != null) {
      return DashboardContent(
        data: lastData!,
        cargoAtual: cargoAtual ?? '',
      );
    }

    // ✅ usa dados (cache ou novo)
    if (lastData != null) {
      return DashboardContent(
        data: lastData!,
        cargoAtual: cargoAtual ?? '',
      );
    }

    // ⏳ só mostra loading se não tiver nada mesmo
    return _buildLoading();
  }

  // Widget _buildBody(AsyncSnapshot<DashboardData> snapshot) {
  //
  //   if (snapshot.hasError) {
  //     return _buildErro(context,
  //       mensagem: 'Erro ao carregar os dados.',
  //       detalhe: snapshot.error.toString(),
  //     );
  //   }
  //
  //   if (snapshot.connectionState == ConnectionState.waiting) {
  //     return _buildLoading();
  //   }
  //
  //   if (!snapshot.hasData) {
  //     return _buildErro(context,
  //       mensagem: 'Nenhum dado disponível.',
  //     );
  //   }
  //
  //   return DashboardContent(data: snapshot.data!, cargoAtual: cargoAtual ?? '');
  // }

  Widget _botoesSpeedDial ({required String label, required IconData icon}) {
    final theme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 25),
      decoration: BoxDecoration(
          color: theme.primary,
          borderRadius: BorderRadius.circular(35),
          boxShadow: [
            BoxShadow(
              color: theme.primary.withValues(alpha: 0.5),
              blurRadius: 5,
              offset: const Offset(0, 0),
            ),
          ]
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(width: 8),
          Text(label, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }

  Widget buildLogo (Empresa empresa, {double size = 50}) {

    ImageProvider? image;

    // 1️⃣ Prioridade: imagem local (offline)
    if (empresa.logoBytes != null && empresa.logoBytes!.isNotEmpty) {
      image = MemoryImage(Uint8List.fromList(empresa.logoBytes!));
    }
    // 2️⃣ Fallback: imagem remota
    else if (empresa.logoUrl != null && empresa.logoUrl!.isNotEmpty) {
      image = NetworkImage(empresa.logoUrl!);
    }

    return RepaintBoundary(
      child: Hero(
        tag: empresa.id,
        child: GestureDetector(
          onTap: () {
            if (!context.mounted) return;
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => const DadosEmpresaPage()));
          },
          child: CircleAvatar(
            radius: size,
            backgroundColor: Colors.grey[200],
            backgroundImage: image,
            child: image == null
                ? const Icon(Icons.store,)
                : null,
          ),
        ),
      ),
    );
  }

  Widget btnAuth(BuildContext context) {
    final autenticacao = FirebaseAuth.instance.currentUser;
    return IconButton(
        //label: null,//autenticacao == null ? "Entrar" : "Sair",
        icon: autenticacao == null ? const Icon(Icons.login) : const Icon(Icons.logout),
        style: IconButton.styleFrom(
          backgroundColor: Colors.white.withValues(alpha: 0.2),
          foregroundColor: Colors.white,
          splashFactory: NoSplash.splashFactory,
          iconSize: 20,
        ),
        onPressed: () {
          autenticacao == null ?
          Navigator.push(context,
            MaterialPageRoute(
                builder: (context) => const AuthGate()
            ),
          ) :
          CustomDialog2.show(
            context: context,
            title: 'Sair',
            description: 'Deseja realmente sair da sua conta?',
            confirmText: 'Sim',
            cancelText: 'Cancelar',
            onConfirm: () async {
              await _logOut();
              if (!context.mounted) return;
              Navigator.pop(context);
            },
          );
        }
    );
  }

  StreamSubscription? _subscriptionListener;

  Future<void> disposeListener() async {
    await _subscriptionListener?.cancel();
    _subscriptionListener = null;
  }

  Future<void> _logOut() async {
    final prefs = await SharedPreferences.getInstance();

    try {

      await prefs.setBool('banco_migrado', false);

      // 1️⃣ Para sincronização primeiro
      final syncService = SyncService();
      await syncService.stop();

      // 2️⃣ Limpa banco local
      await limparBanco();

      // 3️⃣ Reseta premium local
      await PremiumHelper.salvarPremium(false);

      // 4️⃣ Agora pode deslogar
      await FirebaseAuth.instance.signOut();

    } catch (e) {
      debugPrint('Erro ao fazer logout: $e');
    }
  }

  // Função que roda em background
  Future<void> _verificarEAtualizarAtrasados() async {
    final db = DatabaseHelper.isar;
    final agora = DateTime.now();

    // 1. Busca apenas os que estão marcados como 'pendente'
    final servicosPendentes = await db.servicos
        .filter()
        .statusEqualTo("em andamento")
        .findAll();

    bool houveAlteracao = false;

    // 2. Abre transação para atualizar (Write Transaction)
    await db.writeTxn(() async {
      for (var servico in servicosPendentes) {
        final dataEntrega = parseDataHora(servico.dataEntrega ?? "");

        // Se a data existe E agora já passou da data de entrega
        if (dataEntrega != null && agora.isAfter(dataEntrega)) {
          servico.status = "atrasado"; // Muda o status real
          await db.servicos.put(servico); // Salva no banco
          houveAlteracao = true;

          // Opcional: Se precisar avisar o Firebase imediatamente
          await statusSync.atualizarStatusAtrasado();
        }
      }
    });

    if (houveAlteracao) {
      AppFlushbar.error("Você tem serviços atrasados!");
      // Não precisa chamar setState, pois o StreamBuilder da tela vai detectar a mudança no banco sozinho!
    }
  }
}
