import 'package:isar_community/isar.dart';
import '../servico_model/servico_model.dart';

part 'cliente_model.g.dart';

@Collection()
class Cliente {

  Id id = Isar.autoIncrement; // chave primária

  String? nome;
  String? telefone;
  String? cpf;
  String? email;
  String? rua;
  String? numero;
  String? bairro;
  String? cidade;
  String? estado;
  String? cep;
  late String dataCadastro;
  bool isDirty = false;
  DateTime? createdAt;
  DateTime? updatedAt;

  final servicosLink = IsarLinks<Servico>(); // relação 1:N
}