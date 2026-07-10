
import 'package:assistencia_os/custom_widgets/indicador_novidade_widget.dart';
import 'package:assistencia_os/db_helper/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:isar_community/isar.dart';
import '../../custom_widgets/card.dart';
import '../../custom_widgets/card_servico_status/card_servico.dart';
import '../../custom_widgets/elevated_button.dart';
import '../../custom_widgets/top_msg.dart';
import '../../models/cliente_model/cliente_model.dart';
import '../../models/estoque_pecas_model/estoque_pecas_model.dart';
import '../../models/servico_model/servico_model.dart';
import '../all_os/all_os.dart';
import '../calculadora.dart';
import '../clientes/cadastro_ou_editar_cliente.dart';
import '../clientes/lista_clientes.dart';
import '../configuracoes/configs.dart';
import '../empresa/empresa_info_page.dart';
import '../estoque_peças/lista_pecas_screen.dart';
import '../premium_page.dart';
import '../relatorio_diario.dart';
import '../service_registration/base_screen.dart';
import 'components/analytics_card.dart';
import 'components/analytics_row.dart';
import 'components/cross_platform_promo_card.dart';
import 'components/user_card.dart';
import 'services/dashboard_data.dart';
import 'home.dart';

class DashboardContent extends StatelessWidget {
  final String cargoAtual;
  final DashboardData data;

  const DashboardContent({
    super.key,
    required this.data,
    required this.cargoAtual,
  });

  @override
  Widget build(BuildContext context) {

    final clientes = data.clientes;
    final servicos = data.servicos;
    //final pendentes = data.servicosPendentes;
    final empresa = data.empresa;
    final subscription = data.subscription;
    final theme = Theme.of(context).colorScheme;
    final estoque = DatabaseHelper.isar.estoquePecas;
    final estoquePecas = estoque.where().findAllSync();

    final faturamento7Dias = calcularFaturamento7Dias(servicos);

    final servicosEmAndamento = servicos
        .asMap()
        .entries
        .toList()
      ..sort((a, b) {
        final dataA = a.value.createdAt;
        final dataB = b.value.createdAt;

        final dateA = dataA ?? DateTime(0);
        final dateB = dataB ?? DateTime(0);

        return dateB.compareTo(dateA); // mais recente primeiro
      });

    final listaLimitada = servicosEmAndamento.take(5).toList();

    return SafeArea(
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(35),
            topRight: Radius.circular(35),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 15,
              offset: const Offset(0, -10),
            )
          ]
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {

            final isWide = context.isDesktop || context.isTablet;

            return isWide
                ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // COLUNA ESQUERDA
                Expanded(
                  flex: 2,
                  child: Container(
                    constraints: const BoxConstraints(
                        minWidth: 250
                    ),
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      //padding: const EdgeInsets.symmetric(horizontal: 16),
                      children: [
                        const SizedBox(height: 16),

                        UserCard(
                          empresa: empresa,
                          subscription: subscription,
                          theme: Theme.of(context).colorScheme,
                          cargoAtual: cargoAtual,
                        ),

                        const SizedBox(height: 16),

                        Container(
                          margin: const EdgeInsets.only(right: 16),
                          child: AnalyticsRow(
                            data: data,
                            isPro: subscription,
                          ),
                        ),

                        Container(
                          margin: const EdgeInsets.only(right: 16),
                          child: _servicosRecentes(
                            listaLimitada: listaLimitada,
                            clientes: clientes,
                            subscription: subscription,
                          ),
                        ),

                        const SizedBox(height: 16),
                        // Ações rápidas ficam na coluna direita em telas largas, mas exibimos também aqui para continuidade
                        rowCard(
                          [
                            _cardClientes(context, clientes),
                            _cardRelatorioss(context, subscription),
                          ],
                        ),

                        rowCard(
                          [
                            _cardConfig(context),
                            _cardCalc(context),
                          ],
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),

                // if (context.isDesktop)
                //   const SizedBox(width: 16),

                // COLUNA DIREITA
                Expanded(
                  flex: context.isTablet ? 2 : 1,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      children: [
                        const SizedBox(height: 16),

                        AnalyticsCard(
                          theme: theme,
                          faturamento: faturamento7Dias,
                          cargoAtual: cargoAtual,
                        ),

                        const SizedBox(height: 16),

                        const CrossPlatformPromoCard(padding: EdgeInsetsGeometry.symmetric(horizontal: 0)),

                        const SizedBox(height: 16),
                        // Mantemos alguns atalhos e informações adicionais
                        CustomCard(
                          padding: const EdgeInsets.all(12),
                          borderRadius: 20,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Atalhos", style: TextStyle(fontWeight: FontWeight.bold, color: theme.onSurface)),
                              const SizedBox(height: 8),
                              ListTile(
                                dense: true,
                                contentPadding: EdgeInsets.zero,
                                leading: Icon(Icons.add, color: theme.primary),
                                title: const Text("Nova Ordem de Serviço"),
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (_) => const BaseScreen(index: 1)));
                                },
                              ),
                              ListTile(
                                dense: true,
                                contentPadding: EdgeInsets.zero,
                                leading: Icon(Icons.person_add_alt_1_rounded, color: theme.primary),
                                title: const Text("Cadastrar Cliente"),
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (_) => const CadastroEditarCliente()));
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            _cardPecas(context, estoquePecas),
                          ],
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
              ],
            )

            // ================================
            // LAYOUT PARA DISPOSITIVOS MÓVEIS
            // ================================

                : ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                // USUÁRIO CARD
                Visibility(
                  visible: empresa?.telefone1 != null || empresa?.telefone1?.isEmpty == false ? false : false,
                  child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                    padding: const EdgeInsets.all(6),
                    constraints: const BoxConstraints(
                        maxWidth: 500//MediaQuery.of(context).size.width * 0.8,
                    ),
                    decoration: BoxDecoration(
                      color: theme.surface,
                      borderRadius: BorderRadius.circular(35),
                      border: Border.all(
                        color: theme.primary.withValues(alpha: 0.15),
                        width: 2,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.info_outline),
                        const SizedBox(width: 8),
                        const Expanded(
                          child: Text(
                            'Adicione informações da sua empresa, para que possa ser impresso na O.S',
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                        const SizedBox(width: 8),
                        SizedBox(
                          width: 100,
                          child: CustomElevatedButton(
                            label: "Adicionar",
                            sizeLabel: 12,
                            click: () {
                              Navigator.push(context, MaterialPageRoute(builder: (_) => const DadosEmpresaPage()));
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // ElevatedButton(
                //   onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => PremiumPage())),
                //   child: Text("Premium page"),
                // ),

                // RESUMO DIÁRIO CARD
                // Visibility(
                //   visible: cargoAtual == 'Atendente' ? false : true,
                //   child: Padding(
                //     padding: const EdgeInsets.symmetric(vertical: 16.0),
                //     child: ResumoDiario(servicos: servicos),
                //   ),
                // ),

                // VISAO GERAL CARD
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 18, 16, 0),
                  child: AnalyticsCard(
                    theme: theme,
                    faturamento: faturamento7Dias,
                    cargoAtual: cargoAtual,
                  ),
                ),

                const CrossPlatformPromoCard(),

                AnalyticsRow(
                  data: data,
                  isPro: subscription,
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Text("Últimas OS",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: theme.onSurface,
                          fontSize: 16,
                        ),
                      ),
                      const Expanded(
                        child: Divider(
                          color: Colors.grey,
                          thickness: 1,
                          indent: 14,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 8),

                _servicosRecentes(
                  listaLimitada: listaLimitada,
                  clientes: clientes,
                  subscription: subscription,
                ),

                const SizedBox(height: 8),

                rowCard(
                  [
                    _cardClientes(context, clientes),
                    _cardRelatorioss(context, subscription),
                  ],
                ),

                rowCard(
                  [
                    _cardPecas(context, estoquePecas),
                  ],
                ),

                rowCard(
                  [
                    _cardConfig(context),
                    _cardCalc(context),
                  ],
                ),

                const SizedBox(height: 24),

              ],
            );
          },
        ),
      ),
    );
  }

  Widget _cardRelatorioss (BuildContext context, bool subscription) {
    return CardClicavel(
        icon: Icons.trending_up,
        label: 'Relatórios', //'Registros',
        desc: 'Resumo financeiro e estatísticas',
        isPro: subscription,
        //contador: pendentes.length,
        onTap: () async {
          if (!subscription) {
            if (!context.mounted) return;
            Navigator.push(context, MaterialPageRoute(builder: (_) => const PremiumPage()));
          }

          else if (cargoAtual == 'Administrador' || cargoAtual == 'Visitante') {
            if (!context.mounted) return;
            Navigator.push(context, MaterialPageRoute(builder: (_) => const RelatorioDiarioPage()));
          } else {
            if (!context.mounted) return;
            AppFlushbar.error('Somente administradores podem acessar os relatórios!');
          }
        }
    );
  }

  Widget _cardClientes (BuildContext context, List<Cliente> clientes) {
    return CardClicavel(
      icon: Icons.people_alt_rounded,
      label: 'Clientes',
      desc: 'Total de cadastros ativos de clientes',
      contador: clientes.length,
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ListaClientesPage())),
    );
  }

  Widget _cardPecas (BuildContext context, List<EstoquePecas> estoquePecas) {
    return CardClicavel(
      icon: Icons.inventory,
      label: 'Estoque de Peças',
      desc: 'Gerencie o estoque de peças',
      contador: estoquePecas.length,
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PecasListScreen())),
    );
  }

  Widget _cardCalc (BuildContext context) {
    return CardClicavel(
      icon: Icons.calculate,
      label: 'Calculadora',
      desc: 'Exibir calculadora de preço',
      onTap: () => showCalculatorModal(context),
    );
  }

  Widget _cardConfig (BuildContext context) {
    return CardClicavel(
      id: 'ate',
      icon: Icons.settings,
      label: 'Configurações',
      desc: 'Personalize o aplicativo',
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const Configs())),
    );
  }

  Widget rowCard (List<Widget> children) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Row(
        spacing: 16,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: children
      ),
    );
  }

  List<double> calcularFaturamento7Dias(List<Servico> servicos) {
    final hoje = DateTime.now();
    final inicio = DateTime(hoje.year, hoje.month, hoje.day)
        .subtract(const Duration(days: 6));

    final valoresPorDia = List<double>.filled(7, 0.0);

    for (final servico in servicos) {
      final data = servico.createdAt;
      if (data == null) continue;

      if (data.isBefore(inicio)) continue;

      if ((servico.status ?? '').toLowerCase() == 'falhou') continue;

      final diaIndex =
          data.difference(inicio).inDays;

      if (diaIndex < 0 || diaIndex > 6) continue;

      final valor = servico.valorOriginalServicoDouble ?? 0;

      valoresPorDia[diaIndex] += valor;
    }

    return valoresPorDia;
  }

  Widget _servicosRecentes ({
    required final listaLimitada,
    required final clientes,
    required bool subscription,
  }) {
    return Visibility(
      visible: listaLimitada.isNotEmpty,
      replacement: const SizedBox(
        height: 150,
        child: Center(
          child: Text(
            'Nenhum serviço em andamento',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
          ),
        ),
      ),
      child: SizedBox(
        height: 250,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: listaLimitada.length + 1, // +1 pro botão
          itemBuilder: (context, index) {

            // 🔹 Último item = botão "Ver mais"
            if (index == listaLimitada.length) {
              return SizedBox(
                width: 200,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: FilledButton.icon(
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    iconAlignment: IconAlignment.end,
                    icon: const Icon(Icons.arrow_forward_ios_rounded),
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AllOs())),
                    label: const Text('Ver mais'),
                  ),
                ),
              );
            }

            // 🔹 Cards normais
            final entry = listaLimitada[index];
            final servico = entry.value;

            final cliente = clientes.firstWhere(
                  (c) => c.id == servico.clienteId,
              orElse: () => Cliente(),
            );

            return Padding(
              padding: const EdgeInsets.only(left: 16),
              child: SizedBox(
                width: 350,
                child: ServicoCard(
                  os: servico,
                  cliente: cliente,
                  checkAssinatura: subscription,
                  onTap: () {},
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // Widget miniBadge (String label) {
  //   final theme = Theme.of(context).primaryColor;
  //   return Container(
  //     padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
  //     decoration: BoxDecoration(
  //         color: theme.withValues(alpha: 0.1),
  //         borderRadius: BorderRadius.circular(4),
  //         border: Border.all(
  //           color: theme.withValues(alpha: 0.4),
  //           width: 1,
  //         )
  //     ),
  //     child: Text(
  //       label, style: TextStyle(color: theme, fontSize: 10),
  //     ),
  //   );
  // }

}

class CardClicavel extends StatelessWidget {
  final int? contador;
  final VoidCallback onTap;
  final String desc;
  final IconData icon;
  final String label;
  final bool? isPro;
  final String? id;

  const CardClicavel({
    super.key,
    this.contador,
    required this.onTap,
    required this.desc,
    required this.icon,
    required this.label,
    this.isPro,
    this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: IndicadorNovidade(
        featureId: id ?? '', // <-- ID da novidade
        offsetDireita: 2, // Ajuste para ficar certinho no canto do ícone
        offsetTopo: -2,
        child: Container(
          //width: double.infinity,
          height: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.primary, //Color(0xFF4A00E0), // Roxo escuro
                Theme.of(context).colorScheme.primary.withValues(alpha: 0.8), //Color(0xFF8E2DE2), // Roxo claro/vibrante
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            // boxShadow: [
            //   BoxShadow(
            //     color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.4),
            //     blurRadius: 15,
            //     offset: const Offset(0, 8),
            //   ),
            // ],
          ),
          child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(24),
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(24),
              splashColor: Colors.white.withValues(alpha: 0.2),
              highlightColor: Colors.white.withValues(alpha: 0.1),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Stack(
                  children: [
                    // Ilustração de fundo (Marca d'água)
                    Positioned(
                      right: -25,
                      bottom: -20,
                      child: Transform.rotate(
                        angle: -0.2, // Leve inclinação para dar um toque moderno
                        child: Icon(
                          icon,
                          size: 140,
                          color: Colors.white.withValues(alpha: 0.2),
                        ),
                      ),
                    ),

                    // Conteúdo principal
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Cabeçalho com Título e Seta
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text(
                                  label,
                                  softWrap: true,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: isPro ?? true,
                                replacement: const Icon(
                                  Icons.lock,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                child: const Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ],
                          ),

                          const Spacer(),

                          // Quantidade de Clientes
                          if (contador != null)
                          Text(
                            contador.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              height: 1.0,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Expanded(
                            child: Text(
                              desc,
                              softWrap: true,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.8),
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
