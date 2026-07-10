import 'package:flutter/material.dart';

class BadgeCustom extends StatelessWidget {
  final String label;
  final Color color;
  final double fontSize;

  const BadgeCustom({
    super.key,
    required this.label,
    required this.color,
    this.fontSize = 10,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color, width: 0.5),
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: fontSize, color: color, fontWeight: FontWeight.bold),
      ),
    );
  }
}
