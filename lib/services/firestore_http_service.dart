import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class FirestoreHttpService {
  // ⚠️ COLOQUE AQUI O SEU PROJECT ID DO FIREBASE
  final String projectId = 'assistenciaos';

  /// Busca a coleção de um usuário ignorando o plugin nativo.
  /// Exemplo de uso: await getCollection('servicos');
  Future<List<Map<String, dynamic>>> getCollection(String collectionName) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      debugPrint("❌ Usuário não logado.");
      return [];
    }

    // 1. Pegamos o token de segurança para provar ao Firebase quem somos
    final token = await user.getIdToken();
    if (token == null) return [];

    // 2. Montamos a URL da API REST do Firestore
    // Estrutura: /projects/{projectId}/databases/(default)/documents/users/{uid}/{collection}
    final url = Uri.parse(
        'https://firestore.googleapis.com/v1/projects/$projectId/databases/(default)/documents/users/${user.uid}/$collectionName');

    try {
      // 3. Fazemos a chamada HTTP passando o Token no cabeçalho (Header)
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token', // A chave mágica para passar nas Regras do Firestore
        },
      );

      // 4. Verificamos se deu sucesso
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // Se a coleção estiver vazia, a API nem retorna a chave 'documents'
        if (data['documents'] == null) return [];

        List<Map<String, dynamic>> listaFormatada = [];

        // 5. O Firebase REST retorna um JSON bem feio, precisamos limpar
        for (var doc in data['documents']) {
          final fields = doc['fields'];
          if (fields != null) {
            // Pegamos também o ID do documento da URL que ele retorna
            String docId = doc['name'].toString().split('/').last;

            Map<String, dynamic> itemLimpo = _limparJsonFirestore(fields);
            itemLimpo['id'] = docId; // Injetamos o ID no mapa

            listaFormatada.add(itemLimpo);
          }
        }
        return listaFormatada;
      } else {
        debugPrint('❌ Erro HTTP: ${response.statusCode} - ${response.body}');
        return [];
      }
    } catch (e) {
      debugPrint('❌ Erro de conexão: $e');
      return [];
    }
  }

  // =======================================================
  // 🧹 O "Pulo do Gato": Limpador de JSON do Firestore
  // =======================================================
  // A API HTTP do Firestore retorna os dados assim: {"nome": {"stringValue": "João"}}
  // Essa função transforma isso em um mapa normal: {"nome": "João"}
  Map<String, dynamic> _limparJsonFirestore(Map<String, dynamic> fields) {
    Map<String, dynamic> result = {};

    fields.forEach((key, value) {
      if (value.containsKey('stringValue')) {
        result[key] = value['stringValue'];
      } else if (value.containsKey('integerValue')) {
        result[key] = int.tryParse(value['integerValue'].toString());
      } else if (value.containsKey('booleanValue')) {
        result[key] = value['booleanValue'];
      } else if (value.containsKey('doubleValue')) {
        result[key] = double.tryParse(value['doubleValue'].toString());
      } else if (value.containsKey('timestampValue')) {
        result[key] = value['timestampValue']; // Retorna string (ex: "2024-05-05T14:30:00Z")
      } else if (value.containsKey('arrayValue')) {
        // Se for uma lista vazia, o 'values' não vem
        var valores = value['arrayValue']['values'] ?? [];
        // Simplificação: pega os valores de dentro da lista
        result[key] = valores.map((item) => item.values.first).toList();
      }
      // Se você tiver sub-mapas, pode adicionar a verificação de 'mapValue' aqui
    });

    return result;
  }
}