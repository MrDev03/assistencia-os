import 'dart:io';
import 'dart:ui';
import 'package:assistencia_os/custom_widgets/appbar_btn.dart';
import 'package:assistencia_os/custom_widgets/card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../providers/mobile_premium_provider.dart';
// Importe seu provider aqui:
// import 'premium_provider.dart';

class SubscriptionScreen extends StatelessWidget {
   final bool configPage;
   SubscriptionScreen({
     super.key,
     this.configPage = false,
   });

  //final _db = FirebaseFirestore.instance;
  final uid = FirebaseAuth.instance.currentUser?.uid;

   Future<Map<String, dynamic>?> getSubscriptionData() async {
     final doc = await FirebaseFirestore.instance
         .collection('users')
         .doc(uid)
         .collection('subscription')
         .doc('info')
         .get();

     return doc.data();
   }

  @override
  Widget build(BuildContext context) {
    final premiumProvider = context.watch<PremiumProvider>();
    final isPro = premiumProvider.isPro;



    return Scaffold(
      // Um fundo com gradiente sutil para destacar o efeito de vidro
      appBar: configPage ? null : _buildAppBar(context),
      body: Container(
        // decoration: const BoxDecoration(
        //   gradient: LinearGradient(
        //     begin: Alignment.topLeft,
        //     end: Alignment.bottomRight,
        //     colors: [Color(0xFF1E1E2C), Color(0xFF2D2D44)],
        //   ),
        // ),
        child: SafeArea(
          child: Center(
            // ConstrainedBox garante que no Windows a tela não fique esticada e bizarra
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: ListView(
                padding: const EdgeInsets.all(32),
                children: [
                  _buildStatusCard(isPro),
                  const SizedBox(height: 32),

                  if (!isPro) _buildPlansSection(premiumProvider),
                  subscriptionInfo(),
                  const SizedBox(height: 32),
                  if (isPro) _buildActiveSubscriptionDetails(context),


                  //_buildHistorySection(),

                  const SizedBox(height: 40),
                  if (!isPro) _buildRestoreButton(premiumProvider),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // =======================================================
  // 1. APP BAR TRANSPARENTE
  // =======================================================
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      title: const Text(
        'Assinatura',
        //style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
      ),
      leading: AppbarBtn(
        //icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  // =======================================================
  // 2. CARD PRINCIPAL COM EFEITO DE VIDRO (GLASSMORPHISM)
  // =======================================================
  Widget _buildStatusCard(bool isPro) {
    return CustomCard(
      padding: const EdgeInsets.all(32),
      borderRadius: 24,
      child: Column(
        children: [
          Icon(
            isPro ? Icons.workspace_premium_rounded : Icons.lock_outline_rounded,
            size: 64,
            color: isPro ? Colors.amberAccent : Colors.white54,
          ),
          const SizedBox(height: 16),
          Text(
            isPro ? 'Você é Premium' : 'Plano Gratuito',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            isPro
                ? 'Todos os recursos estão desbloqueados.'
                : 'Faça o upgrade para gerenciar O.S. sem limites.',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 15),
          ),
        ],
      ),
    );
  }

  // =======================================================
  // 3. SEÇÃO DE PLANOS (Quando o usuário NÃO é Pro)
  // =======================================================
  Widget _buildPlansSection(PremiumProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Escolha seu plano',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 16),
        // Layout Builder adapta para lado a lado no PC e empilhado no Celular
        LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > 500) {
              return Row(
                children: [
                  Expanded(child: _buildPlanCard('Mensal', 'R\$ 24,90', 'Cobrado mensalmente', () => provider.buyMonthly())),
                  const SizedBox(width: 16),
                  Expanded(child: _buildPlanCard('Anual', 'R\$ 199,90', 'Economize 33%', () => provider.buyYearly(), isHighlighted: true)),
                ],
              );
            } else {
              return Column(
                children: [
                  _buildPlanCard('Mensal', 'R\$ 24,90', 'Cobrado mensalmente', () => provider.buyMonthly()),
                  const SizedBox(height: 16),
                  _buildPlanCard('Anual', 'R\$ 199,90', 'Economize 33%', () => provider.buyYearly(), isHighlighted: true),
                ],
              );
            }
          },
        ),
      ],
    );
  }

  Widget _buildPlanCard(String title, String price, String subtitle, VoidCallback onTap, {bool isHighlighted = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: isHighlighted ? Colors.blueAccent.withValues(alpha: 0.15) : Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isHighlighted ? Colors.blueAccent.withValues(alpha: 0.5) : Colors.white.withValues(alpha: 0.1),
            width: isHighlighted ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            if (isHighlighted)
              Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(color: Colors.blueAccent, borderRadius: BorderRadius.circular(10)),
                child: const Text('MAIS POPULAR', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            Text(title, style: const TextStyle(fontSize: 18, color: Colors.white70)),
            const SizedBox(height: 8),
            Text(price, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white)),
            const SizedBox(height: 8),
            Text(subtitle, style: TextStyle(fontSize: 13, color: isHighlighted ? Colors.blueAccent.shade100 : Colors.white54)),
          ],
        ),
      ),
    );
  }

  Widget _buildData (AsyncSnapshot<Map<String, dynamic>?> snapshot, BuildContext context) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return LoadingAnimationWidget.staggeredDotsWave(color: Theme.of(context).primaryColor, size: 25);
    }

    if (!snapshot.hasData) {
      return const Text('Sem dados');
    }
    return const SizedBox();
  }

  // =======================================================
  // 4. DETALHES DA ASSINATURA ATIVA
  // =======================================================
  Widget _buildActiveSubscriptionDetails(BuildContext context) {
    return CustomCard(
      padding: const EdgeInsets.all(20),
      borderRadius: 20,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Próxima Cobrança', style: TextStyle(fontSize: 14)),
          const SizedBox(height: 4),
          //subscriptionInfo('purchaseDate'),
          FutureBuilder(
            future: getSubscriptionData(),
            builder: (context, snapshot) {

              final data = snapshot.data;
              final expirationDate = data?['expirationDate'] ?? 'sem dados';
              final renovacao = data?['renovacao'] ?? false;

              if (snapshot.connectionState == ConnectionState.waiting) {
                return LoadingAnimationWidget.staggeredDotsWave(color: Theme.of(context).primaryColor, size: 25);
              }

              if (!snapshot.hasData) {
                return const Text('Sem dados');
              }

              return renovacao ? Text(formatarData(expirationDate),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ) : const Text(
                'Cancelado',
                style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red,
                ),
              );
            }
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: _openSubscriptionManager,
              style: FilledButton.styleFrom(
                backgroundColor: Colors.blueAccent.shade700,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Gerenciar Assinatura'),
            ),
          )
        ],
      ),
    );
  }

   // 1. A FUNÇÃO AGORA É "BLINDADA" E INTELIGENTE
   String formatarData(dynamic campoData) {
     // Se veio nulo ou já é a string de fallback, retorna sem dados
     if (campoData == null || campoData == 'sem dados') {
       return 'sem dados';
     }

     DateTime? date;

     // Se for o padrão correto do Firebase (Timestamp)
     if (campoData is Timestamp) {
       date = campoData.toDate();
     }
     // Se for um resquício de dado antigo salvo como texto (String)
     else if (campoData is String) {
       date = DateTime.tryParse(campoData);
     }

     // Se a conversão falhou por algum motivo
     if (date == null) {
       return 'Data inválida';
     }

     // Se deu tudo certo, formata bonitinho
     return DateFormat('dd/MM/yyyy HH:mm').format(date);
   }

// 2. O SEU WIDGET AGORA FICA MAIS LIMPO
  Widget subscriptionInfo() {
    return CustomCard(
      padding: const EdgeInsets.all(20),
      borderRadius: 20,
      child: FutureBuilder( // Se puder, tipe aqui: FutureBuilder<Map<String, dynamic>?>
          future: getSubscriptionData(),
          builder: (context, snapshot) {

            // Primeiro, tratamos o carregamento
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: LoadingAnimationWidget.staggeredDotsWave(
                  color: Theme.of(context).primaryColor,
                  size: 35,
                ),
              );
            }

            // Depois, tratamos erro ou falta de dados reais
            if (!snapshot.hasData || snapshot.data == null) {
              return const Center(
                child: Text(
                  'Sem dados',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              );
            }

            // Agora é seguro extrair os dados
            final data = snapshot.data!;
            final renovacao = data['renovacao'] ?? false;
            final plano = data['plano'] ?? 'sem dados';

            return Column(
              children: [
                _info(
                  'Plano',
                  plano,
                ),
                _info(
                  'Data da Compra',
                  // Passamos o dado cru para a função inteligente
                  formatarData(data['primeiraCompra']),
                ),
                _info(
                  'Ultima Cobrança',
                  // Passamos o dado cru para a função inteligente
                  formatarData(data['lastPurchaseDate']),
                ),
                _info(
                  'Renovação Automática',
                  renovacao ? 'Ativada' : 'Desativada',
                  color: renovacao ? Colors.greenAccent : Colors.red,
                )
              ],
            );
          }
      ),
    );
  }

   Widget _info (
       String title,
       String value,
       {Color color = Colors.grey}
     ) {
     return ListTile(
       contentPadding: const EdgeInsets.all(0),
       title: Text(title),
       subtitle: Text(value,
         style: TextStyle(
           fontSize: 18,
           fontWeight: FontWeight.bold,
           color: color,
         )
       ),
     );
   }


  // =======================================================
  // 5. HISTÓRICO DE PAGAMENTOS
  // =======================================================
  Widget _buildHistorySection() {
    // 💡 DICA: Aqui você conectaria um StreamBuilder lendo a subcoleção de faturas do Firebase.
    // Para design, estou usando dados estáticos.
    final mockHistory = [
      {'date': '15 Abr 2026', 'amount': 'R\$ 24,90', 'status': 'Pago'},
      {'date': '15 Mar 2026', 'amount': 'R\$ 24,90', 'status': 'Pago'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Histórico de Pagamentos',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
        ),
        const SizedBox(height: 16),
        ...mockHistory.map((invoice) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.03),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(invoice['date']!, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                    const SizedBox(height: 4),
                    Text(invoice['status']!, style: const TextStyle(color: Colors.greenAccent, fontSize: 13)),
                  ],
                ),
                Text(invoice['amount']!, style: const TextStyle(fontSize: 16, color: Colors.white70)),
              ],
            ),
          ),
        )),
      ],
    );
  }

  // =======================================================
  // 6. BOTÃO DE RESTAURAR COMPRAS
  // =======================================================
  Widget _buildRestoreButton(PremiumProvider provider) {
    return Center(
      child: TextButton.icon(
        onPressed: () => provider.restorePurchases(),
        icon: provider.isLoading
            ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white54))
            : const Icon(Icons.restore, color: Colors.white54),
        label: const Text('Restaurar Compras', style: TextStyle(color: Colors.white54)),
      ),
    );
  }

  // =======================================================
  // 🛠 LÓGICA DE NAVEGAÇÃO PARA GERENCIAMENTO
  // =======================================================
  void _openSubscriptionManager() async {
    // Se estiver no Windows, envia para o painel de clientes do Stripe.
    // Se estiver no Android, envia para as assinaturas da Play Store.
    final Uri url = Platform.isWindows
        ? Uri.parse("https://billing.stripe.com/p/login/eVq6oJdATgFk7kpgEM5wI00")
        : Uri.parse("https://play.google.com/store/account/subscriptions");

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }
}