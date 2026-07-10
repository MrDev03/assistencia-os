
import 'package:assistencia_os/sync/modules/servico_sync.dart';
import 'package:brasil_fields/brasil_fields.dart';
import '../../../db_helper/db_helper.dart';
import '../../../db_helper/pecas_helper.dart';
import '../../../models/cliente_model/cliente_model.dart';
import '../../../models/servico_model/servico_model.dart';
import '../../../sync/modules/cliente_sync.dart';
import 'data_cadastro.dart';

class ServicoRepository {

  Future<Servico> salvar(DataCadastro dataSevico, DataCliente dataCliente) async {

    final dataHora =
        "${UtilData.obterDataDDMMAAAA(DateTime.now())} • ${UtilData.obterHoraHHMM(DateTime.now())}";

    Cliente? cliente;
    final servicoSync = ServicoSync();
    final clienteSync = ClienteSync();


    // 1️⃣ Tenta buscar cliente existente
    if (dataCliente.clienteId != null) {
      cliente = await DatabaseHelper.isar.clientes.get(dataCliente.clienteId!);
    }

    // 2️⃣ Se não existir → cria cliente
    if (cliente == null) {
      final novoCliente = Cliente()
        ..nome = dataCliente.nome
        ..telefone = dataCliente.telefone
        ..dataCadastro = dataHora
        ..cpf = dataCliente.cpf ?? ""
        ..email = dataCliente.email ?? ""
        ..rua = dataCliente.rua ?? ""
        ..numero = dataCliente.numero ?? ""
        ..bairro = dataCliente.bairro ?? ""
        ..cidade = dataCliente.cidade ?? ""
        ..estado = dataCliente.estado ?? ""
        ..cep = dataCliente.cep ?? "";

      // salva cliente e obtém ID
      final novoClienteId = await DatabaseHelper.insertCliente(novoCliente);

      novoCliente.id = novoClienteId;
      dataCliente.clienteId = novoClienteId;

      cliente = novoCliente;
    }

    // 3️⃣ Cria serviço
    final servico = Servico()
      ..id = DateTime.now().microsecondsSinceEpoch
      ..clienteId = cliente.id
      ..nomeCliente = cliente.nome
      ..modelo = dataSevico.modelo
      ..marca = dataSevico.marca
      ..problema = dataSevico.problema
      ..data = dataHora
      ..servicos = dataSevico.servicos
      ..garantia = dataSevico.garantia
      ..senha = dataSevico.senha.isEmpty ? null : dataSevico.senha
      ..valorTotalCustoPecasDouble = dataSevico.valorTotalCustoPecasConvertido
      ..fornecedor = dataSevico.fornecedor
      ..qualidadeFrontal = dataSevico.qualidadeFrontal
      ..tipoDeFrontal = dataSevico.tipoFrontal
      ..pecasUtilizadas = dataSevico.pecasUtilizadas
      ..parcelas1 = dataSevico.qtdParcelas1 ?? ''
      ..parcelas2 = dataSevico.qtdParcelas2 ?? ''
      ..formaPgto1 = dataSevico.formaPgto1
      ..formaPgto2 = dataSevico.formaPgto2
      //..modeFornecedor = data.valueFornecedor
      ..obs = dataSevico.obs
      ..valor2 = dataSevico.valor2
      ..valor1Double = dataSevico.valor1
      ..valorOriginalServicoDouble = dataSevico.valorServico
      ..status = dataSevico.checkAssinatura ? "em andamento" : "entregue"
      ..tecnico = dataSevico.tecnico
      ..dataEntrega = dataSevico.dataEntrega
      ..acessorios = dataSevico.acessorios
      ..valorTotalAcessoriosDouble = dataSevico.valorAcessorios
      ..atendente = dataSevico.atendimento
      ..senhaPadrao = dataSevico.senhaPadrao
      ..tipoDeAparelho = dataSevico.tipoAparelho
      ..itensBons = dataSevico.itensBons
      ..itensRuins = dataSevico.itensRuins
      ..createdAt = DateTime.now();

    await PecasHelper.baixarEstoque(DatabaseHelper.isar, dataSevico.pecasUtilizadasRetorno); // Baixa estoque

    // Salva cliente e serviço
    await DatabaseHelper.isar.writeTxn(() async {
      cliente!.id = await DatabaseHelper.isar.clientes.put(cliente);
      servico.clienteId = cliente.id;

      servico.id = await DatabaseHelper.isar.servicos.put(servico);
      servico.clienteLink.value = cliente;
      await servico.clienteLink.save();
    });

    // await DatabaseHelper.isar.writeTxn(() async {
    //
    //   // salva cliente e obtém ID
    //   final clienteId = await DatabaseHelper.isar.clientes.put(cliente!);
    //   cliente.id = clienteId;
    //
    //   // salva serviço
    //   servico.id = await DatabaseHelper.isar.servicos.put(servico);
    //   servico.clienteLink.value = cliente;
    //   await servico.clienteLink.save();
    // });

    dataSevico.dadosOsFinalizados = servico;
    dataSevico.dadosClienteFinalizados = cliente;

    await clienteSync.push(cliente);
    await servicoSync.push(servico);

    return servico;
  }
}
