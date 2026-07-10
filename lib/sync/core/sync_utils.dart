import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

// parseDate, helpers

/// Converte valores vindos do Firestore para DateTime
/// Aceita:
/// - Timestamp (Firestore)
/// - String ISO8601
/// - null
DateTime? parseDate(dynamic value) {
  if (value == null) return null;

  if (value is Timestamp) {
    return value.toDate();
  }

  if (value is String && value.isNotEmpty) {
    return DateTime.tryParse(value);
  }

  return null;
}

// Converte para Timestamp e envia pra o Firestore
class FirestoreDates {
  FirestoreDates._(); // impede instância

  /// - Se já existir localmente → mantém
  /// - Se não existir → usa serverTimestamp
  static dynamic created (DateTime? localDate) {
    if (localDate != null) {
      return Timestamp.fromDate(localDate);
    }
    return FieldValue.serverTimestamp();
  }

  static Timestamp? optional (DateTime? localDate) {
    if (localDate == null) return null;
    return Timestamp.fromDate(localDate);
  }

  /// Usado para updatedAt
  /// - Sempre serverTimestamp
  static FieldValue updated () {
    return FieldValue.serverTimestamp();
  }
}

class FirebaseStorageService {

  final storage = FirebaseStorage.instance;

  /// Upload de múltiplas imagens para o Firebase Storage
  Future<List<String>> uploadListaImagens({
    required List<String> arquivos,
    required String pasta,
  }) async {
    List<String> urls = [];

    for (int i = 0; i < arquivos.length; i++) {
      final path = arquivos[i];

      // ✔ se já for URL → manter
      if (path.startsWith('http')) {
        urls.add(path);
        continue;
      }

      final file = File(path);

      if (!await file.exists()) {
        print('Arquivo não encontrado: $path');
        continue;
      }

      final ref = storage.ref().child('$pasta/img_$i.jpg');

      await ref.putFile(
        file,
        SettableMetadata(contentType: 'image/jpeg'),
      );

      final url = await ref.getDownloadURL();
      urls.add(url);
    }

    return urls;
  }


  Future<void> deletePastaPecaStorage(String path) async {
    try {
      final ref = storage.ref().child(path);
      final result = await ref.listAll();

      // 🔹 deleta arquivos
      for (final file in result.items) {
        try {
          await file.delete();
        } catch (e) {
          print('Erro ao deletar arquivo: $e');
        }
      }

      // 🔹 deleta subpastas recursivamente
      for (final folder in result.prefixes) {
        await deletePastaPecaStorage(folder.fullPath);
      }

    } catch (e) {
      print('Erro ao deletar pasta: $e');
    }
  }

}

// class ImageService {
//   final FirebaseStorage _storage = FirebaseStorage.instance;
//
//   // --- 1. UPLOAD (Mantido igual, pois o Cloud precisa ser único) ---
//   Future<String> uploadImagem(File arquivo, String userId, String pecaUid) async {
//     try {
//       String nomeOriginal = path.basename(arquivo.path);
//       String nomeArquivo = '${DateTime.now().millisecondsSinceEpoch}_$nomeOriginal';
//
//       Reference ref = _storage.ref()
//           .child('users')
//           .child(userId)
//           .child('pecas')
//           .child(pecaUid)
//           .child(nomeArquivo);
//
//       await ref.putFile(arquivo, SettableMetadata(contentType: 'image/jpeg'));
//       return await ref.getDownloadURL();
//     } catch (e) {
//       print("Erro no upload: $e");
//       return "";
//     }
//   }
//
//   // --- 2. DOWNLOAD (Agora baseado puramente no ID do Isar) ---
//   // Parâmetros novos: idIsar (int) e index (int)
//   Future<String> downloadESalvarLocalmente(String url, int idIsar, int index) async {
//     if (url.isEmpty) return "";
//
//     try {
//       final directory = await getApplicationDocumentsDirectory();
//       final pastaImagens = Directory('${directory.path}/imagens_pecas');
//
//       if (!await pastaImagens.exists()) {
//         await pastaImagens.create(recursive: true);
//       }
//
//       // --- NOMENCLATURA BASEADA NO ID ---
//       // Exemplo de resultado: "peca_998877_img_0.jpg"
//       // Isso garante que sabemos exatamente a quem pertence a foto.
//       final nomeArquivo = 'peca_${idIsar}_img_${index}.jpg';
//       final file = File('${pastaImagens.path}/$nomeArquivo');
//
//       // Se o arquivo já existe, retornamos ele.
//       // (Como removemos o Hash, assumimos que ID+Index é imutável localmente para ganhar performance)
//       if (await file.exists() && await file.length() > 0) {
//         return file.path;
//       }
//
//       // Baixa os bytes da internet
//       final response = await http.get(Uri.parse(url));
//
//       if (response.statusCode == 200) {
//         await file.writeAsBytes(response.bodyBytes);
//         return file.path;
//       } else {
//         return url; // Falha no download, usa online
//       }
//     } catch (e) {
//       print("Erro no download: $e");
//       return url;
//     }
//   }
// }
