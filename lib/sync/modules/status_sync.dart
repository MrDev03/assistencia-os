import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../custom_widgets/top_msg.dart';
import '../../db_helper/db_helper.dart';
import '../firebase/firebase_writer.dart';

class StatusSync {

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final writer = FirebaseWriter();

  Future<void> updateStatusFirebase(
      int servicoId,
      String status,
      String motivo,
      ) async {

    final Map<String, dynamic> data = {
      'status': status,
    };

    // 🔹 Regra do motivo
    if (status == "sem solução") {
      data['motivo'] = motivo.isEmpty
          ? FieldValue.delete()
          : motivo;
    } else {
      data['motivo'] = FieldValue.delete();
    }

    // 🔹 Limpar campos sensíveis dependendo do status
    if (["entregue", "sem solução", "aguardando cliente"].contains(status)) {
      data.addAll({
        'senha': FieldValue.delete(),
        'senhaPadrao': FieldValue.delete(),
        'dataSenha': FieldValue.delete(),
        'dataEntrega': FieldValue.delete(),
      });
    }

    // 🔹 Atualiza no Firebase usando seu writer
    await writer.update(
      'servicos',
      servicoId,
      data,
    );
  }

  Future<void> falhaServicoToFirebase(int servicoId) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    try {
      final docRef = firestore
          .collection('users')
          .doc(user.uid)
          .collection('servicos')
          .doc(servicoId.toString());

      await docRef.update({
        'status': 'falhou',
        'senha': null,
        'senhaPadrao': null,
        'dataSenha': null,
      });
    } catch (e) {
      print('Erro ao marcar falha no serviço: $e');
    }
  }

  Future<void> atualizarStatusAtrasado() async {

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final agora = DateTime.now();

    try {
      final querySnapshot = await firestore
          .collection('users')
          .doc(user.uid)
          .collection('servicos')
          .where('status', isEqualTo: 'em andamento')
          .get();

      for (final doc in querySnapshot.docs) {
        final data = doc.data();

        final Timestamp? dataEntregaTs = data['dataEntrega'];
        if (dataEntregaTs == null) continue;

        final DateTime dataEntrega = dataEntregaTs.toDate();

        if (agora.isAfter(dataEntrega)) {
          await writer.update(
            'servicos',
            int.parse(doc.id), // 🔥 importante
            {
              'status': 'atrasado',
            },
          );
        }
      }
    } catch (e) {
      print('Erro ao atualizar serviços atrasados: $e');
    }
  }
}
