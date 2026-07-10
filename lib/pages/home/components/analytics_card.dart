import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../custom_widgets/card.dart';
import '../../../custom_widgets/info_card.dart';

class AnalyticsCard extends StatelessWidget {
  final ColorScheme theme;
  final List<double> faturamento;
  final String cargoAtual;

  const AnalyticsCard({
    super.key,
    required this.theme,
    required this.faturamento,
    required this.cargoAtual,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // Garantindo acesso ao tema

    final dias = _gerarUltimos7Dias();

    final currencyFormatter =
    NumberFormat.simpleCurrency(locale: 'pt_BR');

    final maxValue = faturamento.isEmpty
        ? 0
        : faturamento.reduce((a, b) => a > b ? a : b);

    return InfoCard(
      title: "Faturamento últimos 7 dias",
      icon: Icons.trending_up,
      noBory: true,
      children: [

        // ==========================================
        // NOVO GRÁFICO DE BARRAS NATIVO
        // ==========================================
        SizedBox(
          height: 130, // Altura original mantida
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // O List.generate cria as 7 barras baseadas no tamanho do faturamento
            children: List.generate(faturamento.length, (index) {
              final double valor = faturamento[index];
              final String dia = dias[index];
              final double safeMaxValue = maxValue == 0 ? 10 : maxValue * 1.2;

              // Define o percentual de altura da barra atual
              final double heightFactor = safeMaxValue == 0 ? 0 : valor / safeMaxValue;

              return Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Tooltip(
                        message: cargoAtual != 'Administrador' ? 'Restrito 🔒' : currencyFormatter.format(valor),
                        triggerMode: TooltipTriggerMode.tap,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        textStyle: TextStyle(
                          color: theme.colorScheme.onPrimaryContainer,
                          fontWeight: FontWeight.bold,
                        ),
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            // 1. Fundo da barra (trilho fantasma)
                            Container(
                              width: 30, // Barra ligeiramente mais fina para caber na tela
                              decoration: BoxDecoration(
                                color: theme.colorScheme.primary.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            // 2. Barra principal com animação
                            TweenAnimationBuilder<double>(
                              tween: Tween<double>(begin: 0, end: heightFactor),
                              duration: const Duration(milliseconds: 800),
                              curve: Curves.easeOutCubic,
                              builder: (context, animValue, child) {
                                return FractionallySizedBox(
                                  heightFactor: animValue,
                                  child: Container(
                                    width: 30,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.bottomCenter,
                                        end: Alignment.topCenter,
                                        colors: [
                                          theme.colorScheme.primary,
                                          theme.colorScheme.primary.withValues(alpha: 0.6),
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    // 3. Rótulo do eixo X (Dia/Mês)
                    Text(
                      dia,
                      style: TextStyle(
                        fontSize: 10, // Fonte reduzida para não quebrar a linha
                        fontWeight: FontWeight.w500,
                        color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  List<String> _gerarUltimos7Dias() {
    final hoje = DateTime.now();
    final inicio = hoje.subtract(const Duration(days: 6));

    return List.generate(7, (i) {
      final dia = inicio.add(Duration(days: i));
      return DateFormat('dd/MM').format(dia);
    });
  }
}
