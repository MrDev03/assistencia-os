import 'package:flutter/material.dart';

class CustomIconButtonWithShadow extends StatefulWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color iconColor;
  final Color shadowColor;
  final double elevation;
  final double size;

  const CustomIconButtonWithShadow({
    super.key,
    required this.icon,
    required this.onPressed,
    required this.backgroundColor,
    required this.iconColor,
    required this.shadowColor,
    this.elevation = 5,
    this.size = 35,
  });

  @override
  State<CustomIconButtonWithShadow> createState() => _CustomIconButtonWithShadowState();
}

class _CustomIconButtonWithShadowState extends State<CustomIconButtonWithShadow> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        constraints: BoxConstraints(
          minWidth: widget.size,
          minHeight: widget.size,
          maxWidth: widget.size, // 🔹 impede expandir
          maxHeight: widget.size,
        ),
        alignment: Alignment.center,
        width: widget.size,
        decoration: BoxDecoration(
          color: widget.backgroundColor.withValues(alpha: 0.3),
          shape: BoxShape.circle,
        ),
        child: Icon(
          widget.icon,
          color: widget.iconColor,
          size: widget.size * 0.5,
        ),
      ),
    );
  }
}
