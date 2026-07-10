import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class LedPulse extends StatelessWidget {
  final double size;
  final Color color;

  const LedPulse({super.key, this.size = 20, this.color = Colors.red});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            blurStyle: BlurStyle.outer,
            color: color.withValues(alpha: 0.8),
            blurRadius: 4,
            offset: const Offset(0, 0),
          ),
        ],
      ),
    )
        .animate(
      onPlay: (controller) => controller.repeat(reverse: true),
    )
        .fadeOut(
      duration: 800.ms,
      begin: 0.6,
      curve: Curves.easeInOut,
    );
  }
}
