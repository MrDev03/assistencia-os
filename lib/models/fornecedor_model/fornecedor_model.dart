import 'package:isar_community/isar.dart';

part 'fornecedor_model.g.dart';

@Collection()
class Fornecedor {
  Id id = Isar.autoIncrement;

  late String nome;
  String? numero;
  late String dateTimeCadastro;
  bool isDirty = false;
  DateTime? createdAt;
  DateTime? updatedAt;
}