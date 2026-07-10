import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import '../../db_helper/db_helper.dart';
import '../../models/empresa_model/empresa_model.dart';
import 'package:assistencia_os/sync/firebase/firebase_storage.dart' as firebase_storage;
import '../core/sync_listener.dart';
import '../core/sync_utils.dart';
import '../firebase/firebase_writer.dart';
import 'delete_module.dart';

class EmpresaSync {

  final listener = SyncListener();
  final writer = FirebaseWriter();
  final deleteDados = DeleteDados();
  final isar = DatabaseHelper.isar;

  Future<void> push(Empresa e) async {

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    final uid = user.uid;

    // 🔹 Upload da Logo
    String? logoUrl = e.logoUrl;

    // CORREÇÃO: Verificamos se logoUrl É NULO ou VAZIO.
    // Isso confirma que é uma imagem nova que ainda não foi para a nuvem.
    if (e.logoBytes != null && (logoUrl == null || logoUrl.isEmpty)) {

      // DICA DE SEGURANÇA: Use o caminho users/$uid para evitar erro de permissão no Firebase
      final storagePath = 'users/$uid/empresas/${e.id}/logo.png';

      final uploadedUrl  = await firebase_storage.uploadImageToStorage(
        Uint8List.fromList(e.logoBytes!),
        storagePath,
      );

      // Atualiza o objeto local com a nova URL
      if (uploadedUrl != null && uploadedUrl.isNotEmpty) {
        e.logoUrl = uploadedUrl;
        logoUrl = uploadedUrl;
      }
    }

    // 🔹 Upload da Assinatura (Mesma correção)
    String? assinaturaUrl = e.assinaturaUrl;

    // CORREÇÃO: Verifica se a URL é nula/vazia
    if (e.assinatura != null && (assinaturaUrl == null || assinaturaUrl.isEmpty)) {

      final storagePath = 'users/$uid/empresas/${e.id}/assinatura.png';

      final uploadedUrl = await firebase_storage.uploadImageToStorage(
        Uint8List.fromList(e.assinatura!),
        storagePath,
      );

      if (uploadedUrl != null && uploadedUrl.isNotEmpty) {
        e.assinaturaUrl = uploadedUrl;
        assinaturaUrl = uploadedUrl;
      }
    }

    // 🔹 Sincronizar com Firestore
    // Certifique-se que o caminho aqui bate com o listener ('empresas' ou 'users/$uid/empresas')

    await writer.write('empresas', e.id, {
      'nome': e.nome,
      'cnpj': e.cnpj,
      'telefone1': e.telefone1,
      'telefone2': e.telefone2,
      'endereco': e.endereco,
      'email': e.email,
      'slogan': e.slogan,
      'politicaGarantia': e.politicaGarantia,
      'politicaPrivacidade': e.politicaPrivacidade,
      'horaAbertura': e.horaAbertura,
      'horaFechamento': e.horaFechamento,

      // URLs (já resolvidas antes do sync)
      'logoUrl': e.logoUrl,
      'assinaturaUrl': e.assinaturaUrl,

      // Datas padronizadas
      'createdAt': FirestoreDates.created(e.createdAt),
      'updatedAt': FirestoreDates.updated(),
    });

    // Salvar no Isar novamente para persistir as URLs geradas localmente

    await isar.writeTxn(() async => await isar.empresas.put(e));
  }

  void listen() {

    if (listener.uid == null) return;

    listener.listen<Empresa>(
      collection: 'empresas',

      // 1. Busca Local
      getLocal: (id) => isar.empresas.get(1),

      // 2. Salva Local (Com lógica inteligente de download)
      putLocal: (empresaVindaDoFirebase) async {

        // Busca o que já temos no banco local para comparar
        final empresaLocal = await isar.empresas.get(empresaVindaDoFirebase.id);

        // --- TRATAMENTO INTELIGENTE DA LOGO ---
        bool precisaBaixarLogo = true;

        // Se já temos a empresa localmente E a URL é idêntica...
        if (empresaLocal != null &&
            empresaLocal.logoUrl == empresaVindaDoFirebase.logoUrl) {

          // ...reutilizamos os bytes locais (se existirem) para não gastar internet
          if (empresaLocal.logoBytes != null && empresaLocal.logoBytes!.isNotEmpty) {
            empresaVindaDoFirebase.logoBytes = empresaLocal.logoBytes;
            precisaBaixarLogo = false;
          }
        }

        // Se a URL mudou ou não temos bytes locais, baixamos agora
        if (precisaBaixarLogo && empresaVindaDoFirebase.logoUrl != null) {
          final bytes = await firebase_storage.downloadImageBytes(empresaVindaDoFirebase.logoUrl!);
          if (bytes != null) {
            empresaVindaDoFirebase.logoBytes = bytes;
          }
        }

        // --- TRATAMENTO INTELIGENTE DA ASSINATURA ---
        bool precisaBaixarAssinatura = true;

        if (empresaLocal != null &&
            empresaLocal.assinaturaUrl == empresaVindaDoFirebase.assinaturaUrl) {

          if (empresaLocal.assinatura != null && empresaLocal.assinatura!.isNotEmpty) {
            empresaVindaDoFirebase.assinatura = empresaLocal.assinatura;
            precisaBaixarAssinatura = false;
          }
        }

        if (precisaBaixarAssinatura && empresaVindaDoFirebase.assinaturaUrl != null) {
          final bytes = await firebase_storage.downloadImageBytes(empresaVindaDoFirebase.assinaturaUrl!);
          if (bytes != null) {
            empresaVindaDoFirebase.assinatura = bytes;
          }
        }

        // Grava no Isar a versão final (Dados novos + Bytes corretos)
        await isar.writeTxn(() async {
          await isar.empresas.put(empresaVindaDoFirebase);
        });
      },

      // 3. Deleta Local
      deleteLocal: (id) async {
        await isar.writeTxn(() async {
          await isar.empresas.delete(id);
        });
      },

      // 4. Converte Firestore -> Objeto Isar
      // 4. Converte Firestore -> Objeto Isar
      fromFirestore: (data, id) => Empresa()
          ..id = id
          ..nome = data['nome'] ?? ''
          ..cnpj = data['cnpj'] ?? ''
          ..telefone1 = data['telefone1'] ?? ''
          ..telefone2 = data['telefone2'] ?? ''
          ..endereco = data['endereco'] ?? ''
          ..politicaGarantia = data['politicaGarantia'] ?? ''
          ..politicaPrivacidade = data['politicaPrivacidade'] ?? ''
          ..logoUrl = data['logoUrl']
          ..assinaturaUrl = data['assinaturaUrl']
          ..slogan = data['slogan'] ?? ''
          ..email = data['email'] ?? ''
          ..horaAbertura = data['horaAbertura']
          ..horaFechamento = data['horaFechamento']
          ..createdAt = parseDate(data['createdAt'])
          ..updatedAt = parseDate(data['updatedAt']),

      // 5. Comparador de Versão (para evitar loops infinitos de update)
      getUpdatedAtLocal: (e) => e.updatedAt ?? DateTime.fromMillisecondsSinceEpoch(0),
    );
  }

  Future<void> deleteEmpresa () async {
    await DatabaseHelper.deleteEmpresa();
    await deleteDados.deleteItemFirebase(1, 'empresas');
  }

}