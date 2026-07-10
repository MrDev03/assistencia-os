import 'package:flutter/material.dart';
import 'card.dart';

class TilesGestao extends StatelessWidget {
  final VoidCallback onPressed;
  final VoidCallback? onLongPress;
  final dynamic widgetcustom;

  // 🔥 NOVO: Posição no ranking (0 para primeiro lugar, 1 para segundo...)
  final int? posicaoRanking;

  const TilesGestao({
    super.key,
    required this.onPressed,
    this.onLongPress,
    required this.widgetcustom,
    this.posicaoRanking, // 🔥 Adicionado ao construtor
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 300),
      child: GestureDetector(
        onTap: onPressed,
        onLongPress: onLongPress,
        child: CustomCard(
          borderRadius: 40,
          margin: const EdgeInsets.symmetric(vertical: 6),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              child: Text(
                widgetcustom.nome != null && widgetcustom.nome!.isNotEmpty
                    ? widgetcustom.nome![0].toUpperCase()
                    : '?',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // 🔥 Chamamos a função que constrói a medalha
            trailing: _buildTrailing(context),
            title: Text(
              widgetcustom.nome ?? "Sem nome",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            subtitle: Text(
              widgetcustom.numero == null || widgetcustom.numero!.isEmpty
                  ? "Sem número"
                  : widgetcustom.numero!,
              style: const TextStyle(fontWeight: FontWeight.w400),
            ),
          ),
        ),
      ),
    );
  }

  /// 🔥 Lógica de Exibição das Medalhas
  Widget _buildTrailing(BuildContext context) {
    // Se não passou ranking, retorna só a setinha padrão
    if (posicaoRanking == null) {
      return const Icon(Icons.chevron_right_outlined);
    }

    // Define o texto ou emoji baseado na posição
    String textoRanking = '';
    if (posicaoRanking == 0) {
      textoRanking = '🥇';
    } else if (posicaoRanking == 1) {
      textoRanking = '🥈';
    } else if (posicaoRanking == 2) {
      textoRanking = '🥉';
    } else {
      textoRanking = '${posicaoRanking! + 1}º';
    }

    // Retorna uma Row contendo a medalha + setinha
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          textoRanking,
          style: TextStyle(
            // Deixa os emojis de medalha maiores e os números normais
            fontSize: posicaoRanking! <= 2 ? 22 : 16,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(width: 8), // Espaço entre medalha e setinha
        const Icon(Icons.chevron_right_outlined),
      ],
    );
  }
}