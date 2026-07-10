
import '../../../custom_widgets/acrescimos.dart';
import '../../../models/cliente_model/cliente_model.dart';
import '../../../models/estoque_pecas_model/estoque_pecas_model.dart';
import '../../../models/servico_model/servico_model.dart';

class DataCadastro {

  // ===== LISTAS =====

  List<String> fornecedoresList = [];
  List<String> tecnicosList = [];
  List<String> atendentesList = [];
  List<EstoquePecas> pecasUtilizadasRetorno = [];
  List<String> itensBons = [];
  List<String> itensRuins = [];

  // ===== CAMPOS TEXTO =====

  String modelo = '';
  String marca = '';
  String problema = '';
  String servicos = '';
  String garantia = '';
  String senha = '';
  String valorTotalCustoPecas = '';
  String fornecedor = '';
  String obs = '';
  //String entrada = '';
  String tecnico = '';
  String dataEntrega = '';
  String acessorios = '';
  String atendimento = '';
  String pecasUtilizadas = '';

  // ===== VALORES E OPÇÕES =====

  String valorOriginalServico = '';
  String valorTotalAcessorios = '';
  //String debitoCredito = '';
  String qualidadeFrontal = '';
  String tipoFrontal = '';
  String tipoAparelho = 'Celular';
  String? cargoAtual;
  String? tipoSenha;
  //String? valueFornecedor = 'oculto';

  double valor2 = 0;
  String formaPgto1 = '';
  String formaPgto2 = '';
  String? qtdParcelas1;
  String? qtdParcelas2;

  bool pagamento = false;
  bool obsAtiva = false;
  bool checkAssinatura = false;
  bool colorErrors = false;
  //bool mode = false;
  bool isEstoque = false;
  bool loading = false;
  List<AcessorioItem> meusAcessorios = [];

  String? senhaPadrao;
  Servico? dadosOsFinalizados;
  Cliente? dadosClienteFinalizados;

  // ===== FUNÇÕES =====


  double get valorTotalCustoPecasConvertido => double.tryParse(valorTotalCustoPecas.replaceAll('.', '').replaceAll(',', '.')) ?? 0;


  double get valorServico =>
      double.tryParse(valorOriginalServico.replaceAll('.', '').replaceAll(',', '.')) ?? 0;

  double get valorAcessorios =>
      double.tryParse(valorTotalAcessorios.replaceAll('.', '').replaceAll(',', '.')) ?? 0;

  double get valor1 {
    double total = (valorServico + valorAcessorios) - valor2;
    if (total < 0) total = 0;
    return total;
  }

}

class DataCliente {

  String nome = '';
  String telefone = '';
  int? clienteId;
  String? cpf;
  String? email;
  String? rua;
  String? numero;
  String? bairro;
  String? cidade;
  String? estado;
  String? cep;

}