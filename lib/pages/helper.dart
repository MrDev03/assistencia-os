import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class NetworkHelper {
  static Stream<List<ConnectivityResult>> networkStream() {
    return Connectivity().onConnectivityChanged;
  }

  static Future<bool> hasConnection() async {
    final result = await Connectivity().checkConnectivity();
    return result != ConnectivityResult.none;
  }
}


class ResponsiveHelper {
  static bool isTablet(BuildContext context) {
    return MediaQuery.of(context).size.width > 600;
  }

  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width > 900;
  }
}


