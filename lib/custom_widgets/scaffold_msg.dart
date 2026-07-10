import 'package:flutter/material.dart';
import 'dart:ui';

class CustomScaffoldMessenger {
  static void showSnackbar(
      BuildContext context, {
        required String message,
        IconData? icon,
        Duration duration = const Duration(seconds: 4),
        String? labelAction,
        VoidCallback? onPressedAction,
      }) {
    ScaffoldMessenger.of(context).clearSnackBars();

    final snackBar = SnackBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      duration: duration,
      behavior: SnackBarBehavior.floating,
      content: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.4),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.white.withOpacity(0.2),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                if (icon != null) ...[
                  Icon(icon, color: Colors.white),
                  const SizedBox(width: 12),
                ],
                Expanded(
                  child: Text(
                    message,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
                if (labelAction != null && onPressedAction != null)
                  TextButton(
                    onPressed: onPressedAction,
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      textStyle: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    child: Text(labelAction),
                  ),
              ],
            ),
          ),
        ),
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
