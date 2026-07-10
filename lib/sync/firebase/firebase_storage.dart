// upload / download imagens

import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;

Future<String?> uploadImageToStorage(Uint8List bytes, String path) async {
  try {
    final ref = FirebaseStorage.instance.ref().child(path);

    // CORREÇÃO: Adicionamos o SettableMetadata para definir o tipo
    final metadata = SettableMetadata(contentType: 'image/png');

    // Passamos o metadata junto com os bytes
    await ref.putData(bytes, metadata);

    return await ref.getDownloadURL();
  } catch (e) {
    Exception("Erro ao enviar para Storage: $e");
    return null;
  }
}

Future<Uint8List?> downloadImageBytes(String url) async {
  try {
    final response = await http
        .get(Uri.parse(url))
        .timeout(const Duration(seconds: 10));
    if (response.statusCode == 200) {
      return response.bodyBytes;
    }
  } catch (e) {
    Exception("Erro ao baixar imagem: $e");
  }
  return null;
}