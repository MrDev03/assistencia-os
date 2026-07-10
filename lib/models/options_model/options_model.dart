import 'package:isar_community/isar.dart';

part 'options_model.g.dart';

@Collection()
class CargoSettings {
  Id id = 0;
  String? cargo;
}

@Collection()
class SubscriptionSettings {
  Id id = 0;
  bool isPremium = false;
}

