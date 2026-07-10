import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:spoiler_widget/models/spoiler_configs.dart';
import 'package:spoiler_widget/models/text_spoiler_configs.dart';
import 'package:spoiler_widget/spoiler_text_wrapper.dart';
import '../../../models/servico_model/servico_model.dart';

class BodySuperior extends StatelessWidget {
  final List<Servico> servicos;
  final String cargoAtual;
  final bool visibilidade;
  final VoidCallback onTap;
  BodySuperior({
    super.key,
    required this.servicos,
    required this.cargoAtual,
    required this.visibilidade,
    required this.onTap,
  });

  //bool visible = true;
  final formatter = NumberFormat.simpleCurrency(locale: 'pt_BR');

  IconData getIconeCargo() {
    switch (cargoAtual) {
      case 'Administrador':
        return Icons.admin_panel_settings;
      case 'Técnico':
        return Icons.build;
      case 'Atendente':
        return Icons.support_agent;
      default:
        return Icons.person;
    }
  }

  @override
  Widget build(BuildContext context) {

    final hoje = DateTime.now();

    final servicosDoDia = servicos.where((s) {
      final data = s.createdAt; // ou s.dataCriacao
      if (data == null) return false;
      return data.day == hoje.day &&
          data.month == hoje.month &&
          data.year == hoje.year;

    }).toList();

    final qtdHoje = servicosDoDia.length;

    final faturamentoHoje = servicosDoDia.fold<double>(
      0.0,
          (total, current) => total + parseValor(current.valorOriginalServicoDouble),
    );

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(vertical: 16),
      width: double.infinity,
      height: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Icon(getIconeCargo(),
                      color: Colors.white,
                      size: 18,
                    ),
                    const SizedBox(width: 5),
                    Text(cargoAtual,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Text(
                formatarData(hoje),
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.8),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const Spacer(),
          // --- LINHA INFERIOR (Valores Consolidados) ---
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Bloco 1: Faturamento
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Faturamento hoje',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.7),
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    SpoilerTextWrapper(
                      config: TextSpoilerConfig(
                        isEnabled: true,
                        enableGestureReveal: cargoAtual != 'Atendente',
                        particleConfig: const ParticleConfig(
                          color: Colors.white,
                          density: 0.3,
                          maxParticleSize: 1.6,
                          speed: 0.1,
                        ),
                        fadeConfig: const FadeConfig(padding: 3.0, edgeThickness: 20.0),
                        onSpoilerVisibilityChanged: (s) => onTap(),
                      ),
                      child: Text(
                        formatter.format(faturamentoHoje),
                        maxLines: 1,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 30, // Fonte maior para destaque principal
                          fontWeight: FontWeight.w800,
                          letterSpacing: -1.0, // Deixa os números mais unidos e modernos
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Bloco 2: Quantidade
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Serviços',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.7),
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    qtdHoje.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  double parseValor(dynamic value) {
    if (value == null) return 0;

    if (value is num) return value.toDouble();

    if (value is String) {
      if (value.trim().isEmpty) return 0;
      return double.parse(value.replaceAll(',', '.'));
    }

    return 0;
  }

  String formatarData(DateTime? data) {
    if (data == null) return 'Não disponível';
    // Exemplo: "16/09/2025 08:30"
    return DateFormat("d 'de' MMMM 'de' y", 'pt_BR').format(data);
  }
}
