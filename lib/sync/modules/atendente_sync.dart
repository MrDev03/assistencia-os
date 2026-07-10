import '../../db_helper/db_helper.dart';
import '../../models/atendente_model/atendente_model.dart';
import '../core/sync_listener.dart';
import '../core/sync_utils.dart';
import '../firebase/firebase_writer.dart';
import 'delete_module.dart';

class AtendenteSync {

  final isar = DatabaseHelper.isar;
  final listener = SyncListener();
  final writer = FirebaseWriter();
  final deleteDados = DeleteDados();

   Future<void> push(Atendente a) async {

     try {
       await writer.write('atendentes', a.id, {
         'nome': a.nome,
         'numero': a.numero ?? '',
         'dateTimeCadastro': a.dateTimeCadastro,
         'salario': a.salario,
         'comissao': a.comissao,
         'metaMensal': a.metaMensal,
         'tempoExperiencia': a.tempoExperiencia,
         'observacoes': a.observacoes,
         'createdAt': FirestoreDates.created(a.createdAt),
         'updatedAt': FirestoreDates.updated(),
       });
     } catch (e) {
       throw Exception("Erro ao enviar dados para o Firebase: $e");
     }

   }

   void listen() {

     if (listener.uid == null) return;

     listener.listen<Atendente>(
       collection: 'atendentes',
       getLocal: (id) => isar.atendentes.get(id),
       putLocal: (a) async => await isar.writeTxn(() async => await isar.atendentes.put(a)),
       deleteLocal: (id) async => await isar.writeTxn(() async => await isar.atendentes.delete(id)),
       fromFirestore: (data, id) => Atendente()
         ..id = id
         ..nome = data['nome'] ?? ''
         ..numero = data['numero'] ?? ''
         ..dateTimeCadastro = data['dateTimeCadastro'] ?? ''
         ..salario = data['salario']?.toDouble()
         ..comissao = data['comissao']?.toDouble()
         ..metaMensal = data['metaMensal']?.toDouble()
         ..tempoExperiencia = data['tempoExperiencia']
         ..observacoes = data['observacoes']
         ..updatedAt = parseDate(data['updatedAt'])
         ..createdAt = parseDate(data['createdAt']),

       getUpdatedAtLocal: (a) =>
       a.updatedAt ?? DateTime.fromMillisecondsSinceEpoch(0),
     );
   }

   Future<void> deleteAtendente (int id) async {
     await DatabaseHelper.deleteAtendente(id);
     await deleteDados.deleteItemFirebase(id, 'atendentes');
   }

 }