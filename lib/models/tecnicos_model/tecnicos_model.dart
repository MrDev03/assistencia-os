import 'package:isar_community/isar.dart';

part 'tecnicos_model.g.dart';

@Collection()
class Tecnicos {
  Id id = Isar.autoIncrement;

  late String nome;
  String? numero;
  late String dateTimeCadastro;
  bool isDirty = false;

  // Adicione estes campos ao seu Atendente (e Tecnicos, se for unificar)
  double? salario;
  double? comissao; // Em porcentagem
  double? metaMensal;
  String? tempoExperiencia;
  String? observacoes;

  DateTime? createdAt;
  DateTime? updatedAt;
}