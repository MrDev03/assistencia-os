import 'package:assistencia_os/db_helper/premium_helper.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../providers/mobile_premium_provider.dart';

// canSync, internet, premium
class SyncGuard {

  Future<bool> canSync() async {

    PremiumProvider? premium;

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return false;

    final connectivity = await Connectivity().checkConnectivity();

    if (connectivity.isEmpty || connectivity.contains(ConnectivityResult.none)) {
      return false;
    }

    final options = await PremiumHelper.lerPremium();
    if (premium?.isPro != null && premium?.isPro == true ) {
      return true;
    }
    return options;
  }
}
