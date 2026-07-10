import '../db_helper/cargo_helper.dart';

class PermissionService {
  static const _rolesPermitidos = ['admin', 'Visitante'];

  static Future<bool> admPermission() async {
    final options = await CargoHelper.lerCargo();
    final cargo = options ?? 'Visitante';

    return _rolesPermitidos.contains(cargo);
  }

  static Future<bool> atendentePermission() async {
    final options = await CargoHelper.lerCargo();
    final cargo = options ?? 'Visitante';

    return cargo != 'atendente';
  }

}

