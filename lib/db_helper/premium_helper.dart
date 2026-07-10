
import '../models/options_model/options_model.dart';
import 'db_helper.dart';

class PremiumHelper {
  static const _id = 0;

  static Future<bool> lerPremium() async {
    final data = await DatabaseHelper.isar.subscriptionSettings.get(_id);
    return data?.isPremium ?? false;
  }

  static Future<void> salvarPremium(bool value) async {
    await DatabaseHelper.isar.writeTxn(() async {
      var data = await DatabaseHelper.isar.subscriptionSettings.get(_id);

      data ??= SubscriptionSettings()..id = _id;

      if (data.isPremium == value) return; // evita escrita

      data.isPremium = value;

      await DatabaseHelper.isar.subscriptionSettings.put(data);
    });
  }
}