import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../../db_helper/db_helper.dart';
import '../../models/estoque_pecas_model/estoque_pecas_model.dart';
import '../core/sync_listener.dart';
import '../core/sync_utils.dart';
import '../firebase/firebase_writer.dart';
import 'delete_module.dart';

class EstoquePecasSync {

  static const collection = 'estoque_pecas';

  final user = FirebaseAuth.instance.currentUser;

  final isar = DatabaseHelper.isar;
  final listener = SyncListener();
  final writer = FirebaseWriter();
  final storage = FirebaseStorageService();
  final deleteDados = DeleteDados();


  /// =========================
  /// 🔼 PUSH PARA FIREBASE
  /// =========================
  Future<void> push(EstoquePecas peca) async {
    if (user == null) return;
    final uid = user?.uid;

    /// Upload das imagens e obtenção das URLs
    List<String> fotosUrls = List.from(peca.fotosUrl);

    try {
      if (peca.fotosLocal.isNotEmpty) {
        fotosUrls = await storage.uploadListaImagens(
          arquivos: peca.fotosLocal,
          pasta: 'users/$uid/estoque_pecas/${peca.id}',
        );

        // 🔥 IMPORTANTE: salvar URLs no objeto
        peca.fotosUrl = fotosUrls;

        // 🔥 atualizar no Isar com URLs
        await isar.writeTxn(() async {
          await isar.estoquePecas.put(peca);
        });
      }
    } catch (e) {
      throw Exception('Erro ao fazer upload das imagens: $e');
    }

    print('URLs enviadas: $fotosUrls');
    print('Fotos locais: ${peca.fotosLocal}');


    await writer.write('estoque_pecas', peca.id, {
      'barCode': peca.barCode,
      'modelo': peca.modelo,
      'marca': peca.marca,
      'tipo': peca.tipo,
      'cor': peca.cor,
      'qualidadeTela': peca.qualidadeTela,
      'descricao': peca.descricao,
      'modelosCompativeis': peca.modelosCompativeis,
      'fotos': fotosUrls,
      'quantidade': peca.quantidade,
      'valorCusto': peca.valorCusto,
      'valorVenda': peca.valorVenda,
      'usada': peca.usada,
      'aro': peca.aro,
      'dataCadastro': peca.dataCadastro,
      'dataUltimaAtualizacao': FirestoreDates.updated(),
    });
  }

  /// =========================
  /// 🔽 LISTEN (SYNC DOWN)
  /// =========================
  void listen() {

    if (listener.uid == null) return;

    listener.listen<EstoquePecas>(
      collection: 'estoque_pecas',

      getLocal: (id) => isar.estoquePecas.get(id),

      putLocal: (peca) async {
        // 🔽 baixa imagens em background
        await cacheImagensSeNecessario(peca);

        await isar.writeTxn(() async {
          await isar.estoquePecas.put(peca);
        });
      },

      deleteLocal: (id) async =>
      await isar.writeTxn(() async => await isar.estoquePecas.delete(id)),

      fromFirestore: (data, id) => EstoquePecas()
        ..id = id
        ..barCode = data['barCode']
        ..modelo = data['modelo']
        ..marca = data['marca']
        ..tipo = data['tipo']
        ..cor = data['cor']
        ..qualidadeTela = data['qualidadeTela']
        ..descricao = data['descricao']
        ..modelosCompativeis = List<String>.from(data['modelosCompativeis'] ?? [])
        ..fotosUrl = List<String>.from(data['fotos'] ?? [])
        ..quantidade = data['quantidade'] ?? 0
        ..valorCusto = (data['valorCusto'] as num?)?.toDouble()
        ..valorVenda = (data['valorVenda'] as num?)?.toDouble()
        ..usada = data['usada'] ?? false
        ..aro = data['aro'] ?? false
        ..dataCadastro = parseDate(data['dataCadastro'] ?? DateTime.now())!
        ..dataUltimaAtualizacao = parseDate(data['dataUltimaAtualizacao'] ?? DateTime.now())!,

      getUpdatedAtLocal: (p) => p.dataUltimaAtualizacao,
    );
  }



  // Future<String> salvarLocalSeNecessario(String url) async {
  //   final dir = await getApplicationDocumentsDirectory();
  //   final nome = url.hashCode.toString();
  //   final file = File('${dir.path}/$nome.jpg');
  //
  //   if (await file.exists()) return file.path;
  //
  //   final response = await http.get(Uri.parse(url));
  //   await file.writeAsBytes(response.bodyBytes);
  //
  //   return file.path;
  // }

  Future<void> cacheImagensSeNecessario(EstoquePecas peca) async {
    if (peca.fotosUrl.isEmpty) return;

    final dir = await getApplicationDocumentsDirectory();

    // 📁 subpasta para organização
    final pasta = Directory(
      p.join(dir.path, 'AssistenciaOS', 'imagens'),
    );

    await pasta.create(recursive: true);

    for (final url in peca.fotosUrl) {
      try {
        final nome = url.hashCode.toString();
        final file = File(p.join(pasta.path, '$nome.jpg'));

        // ✔ já existe localmente
        if (await file.exists()) {
          if (!peca.fotosLocal.contains(file.path)) {
            peca.fotosLocal.add(file.path);
          }
          continue;
        }

        final response = await http.get(Uri.parse(url));

        // ✔ verifica sucesso
        if (response.statusCode != 200) {
          print('Erro ao baixar imagem: ${response.statusCode}');
          continue;
        }

        await file.writeAsBytes(response.bodyBytes, flush: true);

        peca.fotosLocal.add(file.path);

      } catch (e) {
        print('Erro ao baixar imagem: $e');
      }
    }
  }


  /// =========================
  /// 🗑 DELETE
  /// =========================
  Future<void> deletePeca(int id) async {
    if (user == null) return;
    final uid = user?.uid;

    await isar.writeTxn(() async {
      await isar.estoquePecas.delete(id);
    });

    await deleteDados.deleteItemFirebase(id, 'estoque_pecas');
    await storage.deletePastaPecaStorage('users/$uid/estoque_pecas/$id');
  }
}
