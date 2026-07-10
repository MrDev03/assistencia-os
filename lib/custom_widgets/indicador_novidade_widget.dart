import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/badge_provider.dart';
// Importe o seu BadgeProvider aqui

class IndicadorNovidade extends StatelessWidget {
  final String featureId;
  final Widget child; // O widget que vai receber a bolinha (ícone, texto, etc)
  final double offsetDireita;
  final double offsetTopo;

  const IndicadorNovidade({
    super.key,
    required this.featureId,
    required this.child,
    this.offsetDireita = 0,
    this.offsetTopo = 0,
  });

  @override
  Widget build(BuildContext context) {
    // Escuta o provider. Se o featureId sumir da lista, hasBadge vira false.
    final bool mostrarPonto = context.select<BadgeProvider, bool>(
          (provider) => provider.temNovidade(featureId),
    );

    return Badge(
      isLabelVisible: mostrarPonto,
      // Design estilo Apple: Bolinha com uma leve borda branca/transparente
      backgroundColor: Colors.deepOrange,
      smallSize: 8, // Tamanho sutil
      offset: Offset(offsetDireita, offsetTopo), // Ajuste fino da posição
      child: child,
    );
  }
}