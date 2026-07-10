import 'package:flutter/material.dart';

class DeviceIcon extends StatelessWidget {
  final String tipo;
  final double size;
  final Color? color;

  const DeviceIcon({
    super.key,
    required this.tipo,
    this.size = 24,
    this.color,
  });

  IconData _getIcon() {
    switch (tipo.toLowerCase()) {
      case 'celular':
        return Icons.smartphone;
      case 'smartwatch':
        return Icons.watch;
      case 'tablet':
        return Icons.tablet;
      case 'notebook':
        return Icons.laptop;
      case 'computador':
        return Icons.desktop_mac_outlined;
      case 'caixa de som':
        return Icons.speaker;
      case 'fone de ouvido':
        return Icons.headphones;
      case 'outros':
      default:
        return Icons.devices_other;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Icon(
      _getIcon(),
      size: size,
      color: color ?? Theme.of(context).colorScheme.primary,
    );
  }
}
