import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseWriter {

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  User? get user => FirebaseAuth.instance.currentUser;
  String? get uid => user?.uid;

  // Envia apenas os dados que não são nulos ou vazios

  Map<String, dynamic> _cleanData(Map<String, dynamic> data) {
    final cleaned = <String, dynamic>{};

    data.forEach((key, value) {
      if (value == null) return;

      if (value is String && value.trim().isEmpty) return;

      if (value is Iterable && value.isEmpty) return;

      if (value is Map && value.isEmpty) return;

      cleaned[key] = value;
    });

    return cleaned;
  }

  Future<void> write(
      String collection,
      int id,
      Map<String, dynamic> data,
      ) async {
    final cleanedData = _cleanData(data);

    await firestore
        .collection('users')
        .doc(uid)
        .collection(collection)
        .doc(id.toString())
        .set({
      ...cleanedData,
      'updatedAt': FieldValue.serverTimestamp(),
    },SetOptions(merge: true)); // 🔥 importante
  }

  Future<void> update(
      String collection,
      int id,
      Map<String, dynamic> data,
      ) async {
    final cleanedData = _cleanData(data);

    await firestore
        .collection('users')
        .doc(uid)
        .collection(collection)
        .doc(id.toString())
        .update({
      ...cleanedData,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }
}
