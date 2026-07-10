import '../../db_helper/db_helper.dart';
import '../../models/fornecedor_model/fornecedor_model.dart';
import '../core/sync_listener.dart';
import '../core/sync_utils.dart';
import '../firebase/firebase_writer.dart';
import 'delete_module.dart';

class FornecedorSync {

  final isar = DatabaseHelper.isar;
  final listener = SyncListener();
  final writer = FirebaseWriter();
  final deleteDados = DeleteDados();

  Future<void> push(Fornecedor f) async {

    await writer.write('fornecedores', f.id, {
      'nome': f.nome,
      'numero': f.numero ?? '',
      'dateTimeCadastro': f.dateTimeCadastro,
      'createdAt': FirestoreDates.created(f.createdAt),
      'updatedAt': FirestoreDates.updated(),
    });
  }

  void listen() {

    if (listener.uid == null) return;

    listener.listen<Fornecedor>(
      collection: 'fornecedores',
      getLocal: (id) => isar.fornecedors.get(id),
      putLocal: (f) async => await isar.writeTxn(() async => await isar.fornecedors.put(f)),
      deleteLocal: (id) async => await isar.writeTxn(() async => await isar.fornecedors.delete(id)),
      fromFirestore: (data, id) => Fornecedor()
        ..id = id
        ..nome = data['nome']
        ..numero = data['numero']
        ..dateTimeCadastro = data['dateTimeCadastro']
        ..updatedAt = parseDate(data['updatedAt'])
        ..createdAt = parseDate(data['createdAt']),

      getUpdatedAtLocal: (f) => f.updatedAt ?? DateTime.fromMillisecondsSinceEpoch(0),
    );
  }

  Future<void> deleteFornecedor (int id) async {
    await DatabaseHelper.deleteFornecedor(id);
    await deleteDados.deleteItemFirebase(id, 'fornecedores');
  }

}