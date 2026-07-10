import '../models/options_model/options_model.dart';
import 'db_helper.dart';

class CargoHelper {
  static const _id = 0;

  static Future<String?> lerCargo() async {
    final data = await DatabaseHelper.isar.cargoSettings.get(_id);
    return data?.cargo;
  }

  static Future<void> salvarCargo(String cargo) async {
    await DatabaseHelper.isar.writeTxn(() async {
      var data = await DatabaseHelper.isar.cargoSettings.get(_id);

      data ??= CargoSettings()..id = _id;

      data.cargo = cargo;

      await DatabaseHelper.isar.cargoSettings.put(data);
    });
  }
  static Future<void> deletarCargo() async {
    await DatabaseHelper.isar.writeTxn(() async {
      await DatabaseHelper.isar.cargoSettings.delete(_id);
    });
  }
}