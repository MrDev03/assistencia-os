import 'package:isar_community/isar.dart';
import '../../db_helper/db_helper.dart';
import '../../models/cliente_model/cliente_model.dart';
import '../../models/servico_model/servico_model.dart';
import '../core/sync_listener.dart';
import '../core/sync_utils.dart';
import '../firebase/firebase_writer.dart';
import 'delete_module.dart';

class ClienteSync {

  final isar = DatabaseHelper.isar;
  final listener = SyncListener();
  final writer = FirebaseWriter();
  final deleteDados = DeleteDados();

  Future<void> push(Cliente c) async {
    await writer.write('clientes', c.id, {
      'nome': c.nome,
      'telefone': c.telefone,
      'cpf': c.cpf ?? '',
      'email': c.email ?? '',
      'rua': c.rua ?? '',
      'numero': c.numero ?? '',
      'bairro': c.bairro ?? '',
      'cidade': c.cidade ?? '',
      'estado': c.estado ?? '',
      'cep': c.cep ?? '',
      'dataCadastro': c.dataCadastro,
      'createdAt': FirestoreDates.created(c.createdAt),
      'updatedAt': FirestoreDates.updated(),
    });
  }

  void listen() {

    if (listener.uid == null) return;

    listener.listen<Cliente>(
      collection: 'clientes',
      getLocal: (id) => isar.clientes.get(id),

      // 🔥 CORREÇÃO AQUI
      putLocal: (c) async {

        // 1️⃣ Busca serviços FORA da transação
        final servicos = await isar.servicos
            .filter()
            .clienteIdEqualTo(c.id)
            .findAll();

        // 2️⃣ Grava tudo DENTRO da transação
        await isar.writeTxn(() async {
          // salva cliente
          await isar.clientes.put(c);

          // refaz vínculos SEM acessar .value
          for (final s in servicos) {
            s.clienteLink.value = c;
            await s.clienteLink.save();
          }
        });
      },

      deleteLocal: (id) async =>
          isar.writeTxn(() async => isar.clientes.delete(id)),

      fromFirestore: (data, id) => Cliente()
        ..id = id
        ..nome = data['nome']
        ..telefone = data['telefone']
        ..cpf = data['cpf']
        ..email = data['email']
        ..rua = data['rua']
        ..numero = data['numero']
        ..bairro = data['bairro']
        ..cidade = data['cidade']
        ..estado = data['estado']
        ..cep = data['cep']
        ..dataCadastro = data['dataCadastro'] ?? ''
        ..createdAt = parseDate(data['createdAt'])
        ..updatedAt = parseDate(data['updatedAt']),
      getUpdatedAtLocal: (c) => c.updatedAt ?? DateTime.fromMillisecondsSinceEpoch(0),
    );
  }

  Future<void> deleteCliente (int id) async {
    // 1️⃣ Apaga TUDO no Firebase (cliente + serviços)
    await deleteDados.deleteClienteComServicosFirebase(id);

    // 2️⃣ Depois apaga local
    await DatabaseHelper.deleteClienteComServicos(id);
  }

}
