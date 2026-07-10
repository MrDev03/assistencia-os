import 'package:flutter/material.dart';
import 'package:flashy_flushbar/flashy_flushbar.dart';

class AppFlushbar {

  static void show({
    required String message,
    IconData icon = Icons.info_outline,
    Color iconColor = Colors.black,
    Color backgroundColor = Colors.white,
    bool dismissible = true,
  }) {
    FlashyFlushbar(
      message: message,
      messageStyle: TextStyle(
        color: iconColor,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      duration: const Duration(seconds: 5),
      animationDuration: const Duration(milliseconds: 300),
      isDismissible: dismissible,
      dismissDirection: DismissDirection.up,
      borderRadius: BorderRadius.circular(35),
      backgroundColor: backgroundColor,
      //horizontalPadding: const EdgeInsets.all(10),
      leadingWidget: Icon(
        icon,
        color: iconColor,
        size: 24,
      ),
      trailingWidget: IconButton(
        icon: const Icon(Icons.close, size: 22),
        color: iconColor,
        onPressed: () => FlashyFlushbar.cancel(),
      ),
    ).show();
  }

  /// Sucesso
  static void success(String message) {
    show(
      message: message,
      icon: Icons.check_circle_outline,
      iconColor: Colors.green[700]!,
      backgroundColor: Colors.green[100]!,
    );
  }

  /// Erro
  static void error(String message) {
    show(
      message: message,
      icon: Icons.error_outline,
      iconColor: Colors.red[700]!,
      backgroundColor: Colors.red[100]!,
    );
  }

  /// Aviso
  static void warning(String message) {
    show(
      message: message,
      icon: Icons.warning_amber_outlined,
      iconColor: Colors.orange[700]!,
      backgroundColor: Colors.orange[100]!,
    );
  }

  /// Informação
  static void info(String message) {
    show(
      message: message,
      icon: Icons.info_outline,
      iconColor: Colors.blue[700]!,
      backgroundColor: Colors.blue[100]!,
    );
  }
}

