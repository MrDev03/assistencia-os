import '../models/empresa_model/empresa_model.dart';
import 'db_helper.dart';

class EmpresaHelper {
  static const _id = 1;

  static Future<void> salvarNomeEmpresa(String nome) async {
    await DatabaseHelper.isar.writeTxn(() async {
      var empresa = await DatabaseHelper.isar.empresas.get(_id);

      empresa ??= Empresa()..id = _id;

      empresa.nome = nome;

      await DatabaseHelper.isar.empresas.put(empresa);
    });
  }
}