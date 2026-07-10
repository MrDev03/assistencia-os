import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:assistencia_os/custom_widgets/appbar_btn.dart';
import 'package:assistencia_os/theme/theme_constants.dart';
import 'package:assistencia_os/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';

import '../custom_widgets/card.dart';

// Caso não tenha essa extensão, pode remover ou usar MediaQuery
// import '../pages/home.dart';

class TemaPage extends StatelessWidget {
  final bool configPage;

  const TemaPage({
    super.key,
    this.configPage = false,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDesktop = MediaQuery.of(context).size.width > 800; // Verificação simples de desktop

    return Scaffold(
      appBar: configPage && isDesktop
          ? null
          : AppBar(
        title: const Text('Aparência e Personalização'),
        leading: AppbarBtn(
          onPressed: () => Navigator.pop(context),
        ),
        surfaceTintColor: Colors.transparent,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Lógica de layout responsivo
          if (constraints.maxWidth > 900) {
            // Layout Desktop (Lado a Lado)
            return Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1200),
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 4,
                        child: _StickyPreview(themeProvider: themeProvider),
                      ),
                      const SizedBox(width: 40),
                      Expanded(
                        flex: 5,
                        child: _ControlsSection(themeProvider: themeProvider),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            // Layout Mobile (Vertical)
            return SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  _AppPreviewMockup(
                    corPrimaria: themeProvider.corPrimaria,
                    isDark: Theme.of(context).brightness == Brightness.dark,
                  ),
                  const SizedBox(height: 30),
                  _ControlsSection(themeProvider: themeProvider),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

// --- Seção de Controles (Modo e Cor) ---

class _ControlsSection extends StatelessWidget {
  final ThemeProvider themeProvider;

  const _ControlsSection({required this.themeProvider});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _ConfigCard(
          title: 'Modo do Tema',
          subtitle: 'Escolha como o aplicativo se apresenta',
          child: _ThemeModeSelector(themeProvider: themeProvider),
        ),
        const SizedBox(height: 20),
        _ConfigCard(
          title: 'Cor de Destaque',
          subtitle: 'Defina a identidade visual do sistema',
          child: _ColorSelector(themeProvider: themeProvider),
        ),
      ],
    ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.1, end: 0);
  }
}

// --- Widget de Preview (Mockup de Celular) ---

class _StickyPreview extends StatelessWidget {
  final ThemeProvider themeProvider;
  const _StickyPreview({required this.themeProvider});

  @override
  Widget build(BuildContext context) {
    // Mantém o preview fixo no topo em telas grandes
    return Column(
      children: [
        Text(
          "Pré-visualização",
          style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.grey),
        ),
        const SizedBox(height: 16),
        _AppPreviewMockup(
          corPrimaria: themeProvider.corPrimaria,
          isDark: Theme.of(context).brightness == Brightness.dark,
        ),
      ],
    );
  }
}

class _AppPreviewMockup extends StatelessWidget {
  final Color corPrimaria;
  final bool isDark;

  const _AppPreviewMockup({required this.corPrimaria, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final bgColor = isDark ? const Color(0xFF1E1E1E) : const Color(0xFFF5F5F5);
    final cardColor = isDark ? const Color(0xFF2C2C2C) : Colors.white;
    final onPrimary = corPrimaria.computeLuminance() > 0.5 ? Colors.black : Colors.white;

    return Center(
      child: Container(
        width: 280,
        height: 500, // Proporção de celular
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(32),
          border: Border.all(color: Colors.grey.withOpacity(0.2), width: 4),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          children: [
            // Fake Status Bar
            Container(
              height: 24,
              decoration: BoxDecoration(
                color: corPrimaria,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
              ),
            ),
            // Fake App Bar
            Container(
              height: 50,
              color: corPrimaria,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Icon(Icons.menu, color: onPrimary, size: 20),
                  const SizedBox(width: 16),
                  Text("Meu App", style: TextStyle(color: onPrimary, fontWeight: FontWeight.bold)),
                  const Spacer(),
                  Icon(Icons.search, color: onPrimary, size: 20),
                ],
              ),
            ),
            // Fake Body
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: ListView(
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Fake Card Grande
                    Container(
                      height: 100,
                      decoration: BoxDecoration(
                        color: corPrimaria.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 16),
                          CircleAvatar(backgroundColor: corPrimaria, radius: 20, child: Icon(Icons.person, color: onPrimary)),
                          const SizedBox(width: 12),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(height: 10, width: 80, color: corPrimaria.withOpacity(0.5)),
                              const SizedBox(height: 6),
                              Container(height: 8, width: 50, color: Colors.grey),
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Fake List Items
                    ...List.generate(3, (index) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: cardColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            const SizedBox(width: 12),
                            Icon(Icons.check_box_outline_blank, color: Colors.grey[400]),
                            const SizedBox(width: 12),
                            Container(height: 8, width: 100, color: Colors.grey[400]),
                          ],
                        ),
                      ),
                    )),
                  ],
                ),
              ),
            ),
            // Fake FAB
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    color: corPrimaria,
                    shape: BoxShape.circle,
                    boxShadow: [BoxShadow(color: corPrimaria.withValues(alpha: 0.4), blurRadius: 8, offset: const Offset(0, 4))],
                  ),
                  child: Icon(Icons.add, color: onPrimary),
                ),
              ),
            ),
            const SizedBox(height: 10), // Bottom Safe Area
          ],
        ),
      ),
    ).animate().scale(duration: 400.ms, curve: Curves.easeOutBack);
  }
}

// --- Seletor de Tema (Material 3 SegmentedButton) ---

class _ThemeModeSelector extends StatelessWidget {
  final ThemeProvider themeProvider;

  const _ThemeModeSelector({required this.themeProvider});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return SizedBox(
      width: double.infinity,
      child: AnimatedToggleSwitch<TemaApp>.size(
        current: themeProvider.tema,
        values: const [TemaApp.sistema, TemaApp.claro, TemaApp.escuro],
        iconOpacity: 1.0,

        // 🌟 O truque para dividir as 3 opções igualmente na largura total
        indicatorSize: const Size.fromWidth(double.infinity),
        borderWidth: 1.5,
        clipBehavior: Clip.none, // Permite que o brilho vaze

        style: ToggleStyle(
          borderColor: colors.outlineVariant.withValues(alpha: 0.5),
          indicatorColor: colors.primary,
          backgroundColor: Colors.transparent,
          borderRadius: BorderRadius.circular(16), // Arredondamento consistente

          // Efeito de iluminação (Glow)
          indicatorBoxShadow: [
            BoxShadow(
              color: colors.primary.withValues(alpha: 0.6),
              blurRadius: 12,
              offset: const Offset(0, 0),
            ),
          ],
        ),

        customIconBuilder: (context, local, global) {
          final isSelected = local.value == global.current;

          final color = isSelected
              ? Colors.white
              : colors.onSurface.withValues(alpha: 0.6);

          // Configura ícone e texto baseados na opção
          IconData icon;
          String label;
          switch (local.value) {
            case TemaApp.sistema:
              icon = Icons.brightness_auto_rounded;
              label = 'Sistema';
              break;
            case TemaApp.claro:
              icon = Icons.wb_sunny_rounded;
              label = 'Claro';
              break;
            case TemaApp.escuro:
              icon = Icons.dark_mode_rounded;
              label = 'Escuro';
              break;
          }

          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 18, color: color),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  fontSize: 13, // Fonte levemente menor para caber bem os 3 itens
                ),
              ),
            ],
          );
        },

        onChanged: (TemaApp value) {
          themeProvider.alterarTema(value);
        },
      ),
    );
  }
}

// --- Seletor de Cores (Grid com Check) ---

class _ColorSelector extends StatelessWidget {
  final ThemeProvider themeProvider;

  const _ColorSelector({required this.themeProvider});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.start,
      spacing: 16,
      runSpacing: 16,
      children: coresDisponiveis.map((cor) {
        final isSelected = themeProvider.corPrimaria.value == cor.value;

        return GestureDetector(
          onTap: () => themeProvider.alterarCor(cor),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: cor,
              shape: BoxShape.circle,
              boxShadow: isSelected
                  ? [BoxShadow(color: cor.withOpacity(0.6), blurRadius: 10, spreadRadius: 2)]
                  : [],
              border: Border.all(
                  color: isSelected ? Colors.white : Colors.transparent,
                  width: 2.5
              ),
            ),
            child: isSelected
                ? const Icon(Icons.check, color: Colors.white, size: 28)
                .animate().scale(duration: 200.ms)
                : null,
          ),
        );
      }).toList(),
    );
  }
}

// --- Cards de Container Genéricos ---

class _ConfigCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget child;

  const _ConfigCard({
    required this.title,
    required this.subtitle,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: CustomCard(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(subtitle, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
            const SizedBox(height: 20),
            child,
          ],
        ),
      ),
    );
  }
}