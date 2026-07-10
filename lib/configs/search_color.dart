import 'package:flutter/material.dart';

extension AppColors on BuildContext {

  Color get appbarButtonColor {
    return Theme.of(this).brightness == Brightness.dark
        ? const Color(0xFF141418)
        : const Color(0xFFFFFFFF);
  }

}