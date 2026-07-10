import 'package:flutter/material.dart';

class LateralIconbutom extends StatelessWidget {
  final Widget icon;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Function()? onPressed;
  final String? tooltip;

  const LateralIconbutom({
    super.key,
    required this.icon,
    this.backgroundColor,
    this.foregroundColor,
    required this.onPressed,
    this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return IconButton.filled(
      style: IconButton.styleFrom(
          fixedSize: const Size(50, 50),
          backgroundColor: backgroundColor ?? colorScheme.primaryContainer,
          foregroundColor: foregroundColor ?? colorScheme.onPrimaryContainer,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          iconSize: 30
      ),
      icon: icon, // Ícone de mira/scan
      tooltip: tooltip,
      onPressed: onPressed, // Chama a função criada acima
      //color: Theme.of(context).colorScheme.primary, // Usa a cor do tema
    );
  }
}
