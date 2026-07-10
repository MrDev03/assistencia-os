import 'package:isar_community/isar.dart';

part 'empresa_model.g.dart';

@Collection()
class Empresa {
  Id id = 1;

  String? nome;
  String? cnpj;
  String? telefone1;
  String? telefone2;
  String? endereco;
  String? politicaGarantia;
  String? politicaPrivacidade;
  String? logoUrl;
  List<int>? logoBytes;
  String? slogan;
  String? email;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<int>? assinatura;
  String? assinaturaUrl;
  bool isDirty = false;

  // NOVOS CAMPOS SIMPLIFICADOS
  int? horaAbertura;
  int? horaFechamento;
}