import '../../db_helper/db_helper.dart';
import '../../models/tecnicos_model/tecnicos_model.dart';
import '../core/sync_listener.dart';
import '../core/sync_utils.dart';
import '../firebase/firebase_writer.dart';
import 'delete_module.dart';

class TecnicoSync {

  final isar = DatabaseHelper.isar;
  final listener = SyncListener();
  final writer = FirebaseWriter();
  final deleteDados = DeleteDados();

  // =================== PUSH (LOCAL → FIREBASE) ===================


  Future<void> push(Tecnicos t) async {

    await writer.write('tecnicos', t.id, {
      'nome': t.nome,
      'numero': t.numero ?? '',
      'dateTimeCadastro': t.dateTimeCadastro,
      'salario': t.salario,
      'comissao': t.comissao,
      'metaMensal': t.metaMensal,
      'tempoExperiencia': t.tempoExperiencia,
      'observacoes': t.observacoes,
      'createdAt': FirestoreDates.created(t.createdAt),
      'updatedAt': FirestoreDates.updated(),
    });
  }

  void listen() {

    if (listener.uid == null) return;

    listener.listen<Tecnicos>(
      collection: 'tecnicos',
      getLocal: (id) => isar.tecnicos.get(id),
      putLocal: (t) async => await isar.writeTxn(() async => await isar.tecnicos.put(t)),
      deleteLocal: (id) async => await isar.writeTxn(() async => await isar.tecnicos.delete(id)),
      fromFirestore: (data, id) => Tecnicos()
        ..id = id
        ..nome = data['nome']
        ..numero = data['numero']
        ..dateTimeCadastro = data['dateTimeCadastro']
        ..salario = (data['salario'] as num?)?.toDouble()
        ..comissao = (data['comissao'] as num?)?.toDouble()
        ..metaMensal = (data['metaMensal'] as num?)?.toDouble()
        ..tempoExperiencia = data['tempoExperiencia']
        ..observacoes = data['observacoes']
        ..updatedAt = parseDate(data['updatedAt'])
        ..createdAt = parseDate(data['createdAt']),

      getUpdatedAtLocal: (t) => t.updatedAt ?? DateTime.fromMillisecondsSinceEpoch(0),
    );
  }

  Future<void> deleteTecnico (int id) async {
    await DatabaseHelper.deleteTecnico(id);
    await deleteDados.deleteItemFirebase(id, 'tecnicos');
  }

}