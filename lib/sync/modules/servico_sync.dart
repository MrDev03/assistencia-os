import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:isar_community/isar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../db_helper/db_helper.dart';
import '../../models/cliente_model/cliente_model.dart';
import '../../models/servico_model/servico_model.dart';
import '../core/sync_listener.dart';
import '../core/sync_utils.dart';
import '../firebase/firebase_writer.dart';
import 'delete_module.dart';

class ServicoSync {

  final isar = DatabaseHelper.isar;
  final FirebaseWriter writer = FirebaseWriter();
  final SyncListener listener = SyncListener();
  final deleteDados = DeleteDados();

  // =================== PUSH (LOCAL → FIREBASE) ===================

  Future<void> push(Servico servico) async {

    await writer.write('servicos', servico.id, {
      //'id': servico.id,
      'clienteId': servico.clienteId,
      'data': servico.data,
      'problema': servico.problema ?? '',
      'modelo': servico.modelo ?? '',
      'marca': servico.marca ?? '',
      'status': servico.status ?? 'pendente',
      'dataSenha': FirestoreDates.optional(servico.dataSenha),
      'dataEntrega': servico.dataEntrega ?? '',
      'motivo' : servico.motivo,
      'itensRuins': servico.itensRuins,
      'itensBons': servico.itensBons,

      // Dados de pagamento
      'valorOriginalServico': servico.valorOriginalServicoDouble,
      'valorTotalAcessorios': servico.valorTotalAcessoriosDouble,
      'valorTotalCustoPecas': servico.valorTotalCustoPecasDouble,
      'formaPgto': servico.formaPgto1 ?? '',
      'formaPgto2': servico.formaPgto2 ?? '',
      'valor1': servico.valor1Double,
      'valor2': servico.valor2,
      'qtdParcelas': servico.parcelas1 ?? '',
      'parcelas2': servico.parcelas2 ?? '',

      //'debitoCredito': servico.debitoCredito ?? '',
      'tecnico': servico.tecnico ?? '',
      'obs': servico.obs ?? '',
      'garantia': servico.garantia ?? '',
      'acessorios': servico.acessorios ?? '',
      'senha': servico.senha,
      'senhaPadrao': servico.senhaPadrao,
      'tipoDeAparelho': servico.tipoDeAparelho ?? '',
      'fornecedor': servico.fornecedor ?? '',
      'qualidade': servico.qualidadeFrontal ?? '',
      'selectedTFrontal': servico.tipoDeFrontal ?? '',
      'selectedTPeca': servico.pecasUtilizadas ?? '',
      //'modeFornecedor': servico.modeFornecedor ?? '',
      'servicos': servico.servicos ?? '',
      'nomeCliente': servico.nomeCliente ?? '',
      'atendenteResponsavel': servico.atendente ?? '',
      'createdAt': FirestoreDates.created(servico.createdAt),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  // =================== LISTEN (FIREBASE → LOCAL) ===================

  Future<void> listen() async {

    if (listener.uid == null) return;

    return await listener.listen<Servico>(

      collection: 'servicos',

      getLocal: (id) => isar.servicos.get(id),

      putLocal: (s) async {
        await isar.writeTxn(() async {
          await isar.servicos.put(s);
        });
      },

      deleteLocal: (id) async =>
          isar.writeTxn(() async => isar.servicos.delete(id)),

      fromFirestore: (data, id) {

        final servico = Servico()
          ..id = id
          ..clienteId = data['clienteId'] ?? 0
          ..data = data['data'] ?? ''
          ..problema = data['problema'] ?? ''
          ..modelo = data['modelo'] ?? ''
          ..marca = data['marca'] ?? ''
          ..status = data['status'] ?? ''
          ..dataSenha = parseDate(data['dataSenha'])
          ..dataEntrega = data['dataEntrega'] ?? ''
          //..debitoCredito = data['debitoCredito']
          ..tecnico = data['tecnico'] ?? ''
          ..obs = data['obs'] ?? ''
          ..garantia = data['garantia'] ?? ''
          ..motivo = data['motivo'] ?? ''

          // Dados de pagamento
          ..valorOriginalServicoDouble = parseBR(data['valorOriginalServico'] ?? '0')
          ..valorTotalAcessoriosDouble = parseBR(data['valorTotalAcessorios'] ?? '0')
          ..valorTotalCustoPecasDouble = parseBR(data['valorTotalCustoPecas'] ?? '0')
          ..valor1Double = parseBR(data['valor1'] ?? '0')
          ..valor2 = parseBR(data['valor2'] ?? '0')
          ..formaPgto1 = data['formaPgto'] ?? ''
          ..formaPgto2 = data['formaPgto2'] ?? ''
          ..parcelas1 = data['qtdParcelas'] ?? ''
          ..parcelas2 = data['parcelas2'] ?? ''

          ..acessorios = data['acessorios'] ?? ''
          ..senha = data['senha'] ?? ''
          ..senhaPadrao = data['senhaPadrao'] ?? ''
          ..tipoDeAparelho = data['tipoDeAparelho'] ?? ''
          ..fornecedor = data['fornecedor'] ?? ''
          ..qualidadeFrontal = data['qualidade'] ?? ''
          ..tipoDeFrontal = data['selectedTFrontal'] ?? ''
          ..pecasUtilizadas = data['selectedTPeca'] ?? ''
          //..modeFornecedor = data['modeFornecedor'] ?? ''
          ..servicos = data['servicos'] ?? ''
          ..nomeCliente = data['nomeCliente'] ?? ''
          ..atendente = data['atendenteResponsavel'] ?? ''
          ..itensBons = List<String>.from(data['itensBons'] ?? [])
          ..itensRuins = List<String>.from(data['itensRuins'] ?? [])
          ..createdAt = parseDate(data['createdAt'])
          ..updatedAt = parseDate(data['updatedAt']);

        // 🔗 Relink seguro
        // final cliente =
        // servico.clienteId != null
        //     ? isar.clientes.getSync(servico.clienteId!)
        //     : null;
        //
        // if (cliente != null) {
        //   servico.clienteLink.value = cliente;
        // }


        return servico;
      },
      getUpdatedAtLocal: (s) => s.updatedAt ?? DateTime.fromMillisecondsSinceEpoch(0),
    );
  }

  void migrarValor({
    required Map data,
    required Map updates,
    required String campoAntigo,
    required String campoNovo,
  }) {
    final valorBruto = data[campoAntigo];

    if (data[campoNovo] == null &&
        valorBruto != null &&
        valorBruto.toString().isNotEmpty) {

      final valor = parseBR(valorBruto.toString());

      data[campoNovo] = valor;
      data.remove(campoAntigo);

      updates[campoNovo] = valor;
      updates[campoAntigo] = FieldValue.delete();
    }
  }

  double parseBR(dynamic value) {
    if (value == null) return 0;

    // já é número
    if (value is num) return value.toDouble();

    // string brasileira
    if (value is String) {
      if (value.trim().isEmpty) return 0;

      return double.parse(
        value
            .replaceAll('.', '')   // remove milhar
            .replaceAll(',', '.'), // decimal
      );
    }

    return 0;
  }

  Future<void> deleteServico (int id) async {
    await DatabaseHelper.deleteServico(id);
    await deleteDados.deleteItemFirebase(id, 'servicos');
  }

}
