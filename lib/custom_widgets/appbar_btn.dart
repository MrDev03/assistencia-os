import 'package:flutter/material.dart';

class AppbarBtn extends StatelessWidget {
  final Function()? onPressed;
  final String? tooltip;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final EdgeInsets? margin;

  const AppbarBtn({
    super.key,
    this.onPressed,
    this.tooltip,
    this.icon,
    this.backgroundColor,
    this.foregroundColor,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    final color = backgroundColor ??
        (Theme.of(context).brightness == Brightness.dark
            ? const Color(0xFF141418)//Theme.of(context).colorScheme.surfaceContainer
            : Colors.white);
    return Container(
      margin: margin ?? const EdgeInsets.all(8),
      child: IconButton(
        style: IconButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Theme.of(context).colorScheme.onSurface,
          disabledForegroundColor: Colors.grey.withValues(alpha: 0.6),
          padding: EdgeInsets.zero,
        ),
        onPressed: onPressed ?? () => Navigator.pop(context),
        icon: Icon(icon ?? Icons.arrow_back_ios_new, color: foregroundColor),
        tooltip: tooltip,
      ),
    );
  }
}
