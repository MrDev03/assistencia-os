import 'package:isar_community/isar.dart';
import '../cliente_model/cliente_model.dart';

part 'servico_model.g.dart';

@Collection()
class Servico {
  late Id id;

  @Index()
  int? clienteId;

  String? data;
  DateTime? dataSenha;
  String? modelo;
  String? marca;
  String? problema;
  String? servicos;
  String? garantia;

  // Valores
  String? valor;
  String? valorAcessorios;
  String? valorPeca;
  String? valorSomado;
  String? entrada;

  double? valorOriginalServicoDouble;
  double? valorTotalAcessoriosDouble;
  double? valorTotalCustoPecasDouble;
  double? valor1Double;
  double? valor2;

  String formaPgto1 = '';
  String formaPgto2 = '';
  String parcelas1 = '';
  String parcelas2 = '';

  String? acessorios;
  String? senha;
  String? senhaPadrao;
  String? fornecedor;
  String? qualidadeFrontal;
  String? tipoDeFrontal;
  String? pecasUtilizadas;
  String? debitoCredito;
  //String? modeFornecedor;
  String? obs;
  String? status;
  String? motivo;
  String? tecnico;
  String? atendente;
  String? dataEntrega;
  String? nomeCliente;
  String? tipoDeAparelho;
  List<String> itensBons = [];
  List<String> itensRuins = [];
  DateTime? createdAt;
  DateTime? updatedAt;

  final clienteLink = IsarLink<Cliente>(); // vinculo com cliente
}