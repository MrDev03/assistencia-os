import 'dart:ui';

import 'package:flutter/material.dart';

class BtnBlur extends StatelessWidget {
  final VoidCallback onPressed;
  final Icon icon;
  final String tooltip;

  const BtnBlur({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40,
      height: 40,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: IconButton.filled(
            style: IconButton.styleFrom(
              backgroundColor: Colors.black.withValues(alpha: 0.3),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              side: BorderSide(
                color: Colors.grey.withValues(alpha: 0.3), width: 1,
              ),
            ),
            //padding: EdgeInsets.zero,
            onPressed: onPressed,
            icon: icon,
            tooltip: tooltip,
          ),
        ),
      ),
    );
  }
}
