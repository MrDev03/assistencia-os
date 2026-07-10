import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DeleteDados {

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final _db = FirebaseFirestore.instance;

  Future<void> deleteClienteComServicosFirebase(int clienteId) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    final servicosRef = _db
        .collection('users')
        .doc(uid)
        .collection('servicos');

    final clientesRef = _db
        .collection('users')
        .doc(uid)
        .collection('clientes')
        .doc(clienteId.toString());

    // 🔎 1. Busca serviços pelo clienteId
    final servicosSnap = await servicosRef
        .where('clienteId', isEqualTo: clienteId)
        .get();

    final batch = _db.batch();

    // 🔥 2. Deleta todos os serviços do cliente
    for (final doc in servicosSnap.docs) {
      batch.delete(doc.reference);
    }

    // 🔥 3. Deleta o cliente
    batch.delete(clientesRef);

    await batch.commit();
  }

  Future<void> deleteItemFirebase(int id, String collection) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    await _db
        .collection('users')
        .doc(uid)
        .collection(collection)
        .doc(id.toString())
        .delete();
  }
}
