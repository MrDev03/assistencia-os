import 'package:assistencia_os/custom_widgets/appbar_btn.dart';
import 'package:assistencia_os/custom_widgets/card.dart';
import 'package:assistencia_os/custom_widgets/info_card.dart';
import 'package:assistencia_os/db_helper/premium_helper.dart';
import 'package:assistencia_os/pages/auth/auth_gate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:remix_icons_flutter/remixicon_ids.dart';
import '../agradecimento_page.dart';
import '../custom_widgets/elevated_button.dart';
import '../providers/mobile_premium_provider.dart';
import '../sync/core/sync_service.dart';

class PremiumPage extends StatefulWidget {
  final bool configPage;
  const PremiumPage({
    super.key,
    this.configPage = false,
  });

  @override
  State<PremiumPage> createState() => _PremiumPageState();
}

class _PremiumPageState extends State<PremiumPage> {
  @override
  Widget build(BuildContext context) {
    final premium = context.watch<PremiumProvider>();
    final theme = Theme.of(context);
    final isDesktop = MediaQuery.of(context).size.width > 800;

    SyncService syncService = SyncService();

    return Scaffold(
      appBar: widget.configPage && isDesktop
          ? null
          : AppBar(
        title: const Text('Seja PRO', style: TextStyle(fontWeight: FontWeight.bold)),
        leading: AppbarBtn(
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          AppbarBtn(
            icon: Icons.cloud_download,
            onPressed: () => premium.restorePurchases(),
            //label: 'Restaurar',
          ),
        ],
      ),
      body: SafeArea(
        child: premium.isLoading
            ? Center(
          child: LoadingAnimationWidget.staggeredDotsWave(
            color: theme.colorScheme.primary,
            size: 50,
          ),
        ) : Consumer<PremiumProvider>(
          builder: (context, provider, child) {
            if (provider.isPro) {
              return PremiumThankYouWidget(
                onContinue: () {
                  premium.restorePurchases();
                  syncService.start();
                  Navigator.pop(context);
                }
              );
            }

            // Layout Responsivo: Centraliza em telas grandes
            return Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      children: [
                        // --- CABEÇALHO ---
                        _buildHeader(theme),

                        const SizedBox(height: 30),

                        // --- BENEFÍCIOS ---

                        InfoCard(
                          title: 'Benefícios',
                          noBory: true,
                          icon: Icons.check_circle_outline,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                              child: Column(
                                children: [
                                  Text(
                                    'Por que assinar o PRO?',
                                    style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 15),
                                  _buildMainBenefits(context),

                                  const SizedBox(height: 10),

                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: TextButton.icon(
                                      style: TextButton.styleFrom(
                                          backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.1),
                                          visualDensity: VisualDensity.compact

                                      ),
                                      onPressed: () => _mostrarTodosBeneficios(context),
                                      icon: const Icon(Icons.add_circle_outline, size: 18),
                                      label: const Text('Ver todos os 14 benefícios'),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),


                        const SizedBox(height: 10),

                        // --- MENSAGEM DE ERRO ---
                        if (premium.txtErro.isNotEmpty)
                          _buildErrorMessage(premium),

                        const SizedBox(height: 10),

                        // --- PLANO MENSAL (TESTE GRÁTIS) ---
                        _PlanCard(
                          title: 'Mensal',
                          price: 'R\$ 24,99',
                          period: '/mês',
                          description: 'Cobrado mensalmente.',
                          badgeText: '7 DIAS GRÁTIS', // Destaque
                          badgeColor: Colors.greenAccent.shade700,
                          isHighlight: false,
                          buttonText: 'Testar 7 dias grátis',
                          onTap: () => _handlePurchase(context, premium, isMonthly: true),
                        ),

                        const SizedBox(height: 20),

                        // --- PLANO ANUAL (DESCONTO) ---
                        _PlanCard(
                          title: 'Anual',
                          price: 'R\$ 204,00',
                          period: '/ano',
                          description: 'equivalente a R\$ 17,00 ao mês.',
                          badgeText: 'ECONOMIZE 32%',
                          badgeColor: Colors.blueAccent.shade700,
                          isHighlight: true, // Borda destacada
                          buttonText: 'Assinar Anual',
                          onTap: () => _handlePurchase(context, premium, isMonthly: false),
                        ),

                        const SizedBox(height: 30),

                        const Text(
                          "A renovação é automática. Cancele a qualquer momento nas configurações da loja de aplicativos.",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // Lógica de Compra unificada
  void _handlePurchase(BuildContext context, PremiumProvider premium, {required bool isMonthly}) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      _fazerLogin(context);
      return;
    }
    if (isMonthly) {
      premium.buyMonthly();
    } else {
      premium.buyYearly();
    }
  }

  // --- WIDGETS AUXILIARES ---

  Widget _buildHeader(ThemeData theme) {
    return Column(
      children: [
        Animate(
          onPlay: (controller) => controller.repeat(reverse: true),
          effects: const [
            ShimmerEffect(duration: Duration(seconds: 1),delay: Duration(seconds: 2))
          ],
          child: Icon(
            Icons.auto_awesome,
            size: 60,
            color: theme.colorScheme.primary,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Desbloqueie todo o potencial',
          textAlign: TextAlign.center,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Gerencie sua assistência técnica de forma profissional e sem limites.',
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
        ),
      ],
    );
  }

  Widget _buildMainBenefits(BuildContext context) {
    // Mostra apenas 4 principais para não poluir
    return const Column(
      children: [
        _BenefitRow(icon: Icons.cloud_done, text: 'Backup em Nuvem Automático'),
        _BenefitRow(icon: Icons.inventory, text: 'Estoque de peças ilimitado'),
        _BenefitRow(icon: Icons.picture_as_pdf, text: 'Gerar PDF e compartilhar no Whatsapp'),
        _BenefitRow(icon: Icons.image, text: 'Logo da sua empresa na OS'),
        _BenefitRow(icon: Icons.devices, text: 'Sincronização entre dispositivos'),
      ],
    );
  }

  Widget _buildErrorMessage(PremiumProvider premium) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.red.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(35),
        border: Border.all(color: Colors.red.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          const Icon(Icons.error_outline, color: Colors.red),
          const SizedBox(width: 10),
          Expanded(child: Text(premium.txtErro, style: const TextStyle(color: Colors.red))),
          IconButton(
            icon: const Icon(Icons.close, color: Colors.red, size: 20),
            onPressed: () => setState(() => premium.txtErro = ''),
          )
        ],
      ),
    );
  }

  // MODAL DE BENEFÍCIOS COMPLETO
  void _mostrarTodosBeneficios(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.6,
          maxChildSize: 0.9,
          builder: (_, controller) {
            return ListView(
              controller: controller,
              padding: const EdgeInsets.all(24),
              children: [
                Center(
                  child: Container(
                    width: 50, height: 5,
                    decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                const SizedBox(height: 20),
                Text('Todos os Benefícios PRO', style: Theme.of(context).textTheme.headlineSmall, textAlign: TextAlign.center),
                const SizedBox(height: 20),
                const _BenefitRow(icon: Icons.lock_open, text: 'Acesso ilimitado'),
                const _BenefitRow(icon: Icons.inventory, text: 'Estoque de peças ilimitado'),
                const _BenefitRow(icon: Icons.devices, text: 'Sincronização entre dispositivos'),
                const _BenefitRow(icon: Icons.av_timer_rounded, text: 'Acompanhamento de status do serviço'),
                const _BenefitRow(icon: Icons.cloud, text: 'Backup em nuvem'),
                const _BenefitRow(icon: Icons.history, text: 'Histórico completo'),
                const _BenefitRow(icon: Icons.ssid_chart, text: 'Relatórios financeiros'),
                const _BenefitRow(icon: Icons.image_outlined, text: 'Sua logo nos documentos'),
                const _BenefitRow(icon: Icons.support_agent, text: 'Suporte prioritário'),
                const _BenefitRow(icon: Icons.system_update, text: 'Atualizações antecipadas'),
                const _BenefitRow(icon: Icons.color_lens, text: 'Temas exclusivos'),
                const _BenefitRow(icon: Icons.settings, text: 'Configurações avançadas'),
                const _BenefitRow(icon: Icons.picture_as_pdf, text: 'PDF Profissional'),
                const _BenefitRow(icon: RemixIcon.whatsappLine, text: 'Integração Whatsapp'),
                const SizedBox(height: 20),
                CustomElevatedButton(
                  label: 'Fechar',
                  click: () => Navigator.pop(context),
                )
              ],
            );
          },
        );
      },
    );
  }

  // MODAL DE LOGIN
  void _fazerLogin(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Theme.of(context).colorScheme.surface,
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.account_circle, size: 60, color: Colors.grey),
              const SizedBox(height: 16),
              const Text(
                'Identifique-se',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Para assinar o plano PRO e manter sua assinatura segura, você precisa fazer login.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 24),
              CustomElevatedButton(
                label: 'Fazer Login / Criar Conta',
                click: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const AuthGate()));
                },
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }
}

// --- COMPONENTES VISUAIS ---

class _BenefitRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _BenefitRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1)
            ),
            child: Icon(
              icon,
              size: 20,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 15))),
        ],
      ),
    );
  }
}

class _PlanCard extends StatelessWidget {
  final String title;
  final String price;
  final String period;
  final String description;
  final String badgeText;
  final Color badgeColor;
  final bool isHighlight;
  final String buttonText;
  final VoidCallback onTap;

  const _PlanCard({
    required this.title,
    required this.price,
    required this.period,
    required this.description,
    required this.badgeText,
    required this.badgeColor,
    required this.isHighlight,
    required this.buttonText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CustomCard(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    // if (isHighlight)
                    //   const Icon(Icons.check_circle, color: Colors.green),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: badgeColor,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: badgeColor.withValues(alpha: 0.4),
                            blurRadius: 15,
                          )
                        ]
                      ),
                      child: Text(
                        badgeText,
                        style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                      ),
                    ).animate().scale(delay: 100.ms, duration: 500.ms),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      price,
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onPrimaryContainer,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6, left: 4),
                      child: Text(period, style: TextStyle(color: Colors.grey[600], fontSize: 16)),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(description, style: TextStyle(color: Colors.grey[600], fontSize: 14)),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: onTap,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    //side: BorderSide(color: theme.colorScheme.primary),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                  ),
                  child: Text(buttonText, style: const TextStyle(fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}