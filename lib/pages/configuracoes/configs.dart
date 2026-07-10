import 'package:assistencia_os/custom_widgets/appbar_btn.dart';
import 'package:assistencia_os/custom_widgets/card.dart';
import 'package:assistencia_os/custom_widgets/indicador_novidade_widget.dart';
import 'package:assistencia_os/custom_widgets/top_msg.dart';
import 'package:assistencia_os/pages/configuracoes/usuario_page.dart';
import 'package:assistencia_os/pages/empresa/empresa_info_page.dart';
import 'package:assistencia_os/pages/funcionario_forn/fornecedor_page.dart';
import 'package:assistencia_os/pages/premium_page.dart';
import 'package:assistencia_os/pages/sobre_page.dart';
import 'package:assistencia_os/theme/tela_personalizacao.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remix_icons_flutter/remixicon_ids.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../db_helper/cargo_helper.dart';
import '../../db_helper/premium_helper.dart';
import '../../providers/badge_provider.dart';
import '../assinatura/subscription_screen.dart';
import '../funcionario_forn/atendente/atendentes_screen.dart';
import '../funcionario_forn/tecnicos/tecnicos_page.dart';
import 'components/horario_funcionamento_page.dart';

class Configs extends StatefulWidget {
  const Configs({super.key});

  @override
  State<Configs> createState() => _ConfigsState();
}

class _ConfigsState extends State<Configs> {
  String? cargoAtual;
  bool checkAssinatura = false;

  // Índice para controlar qual tela mostrar à direita no Desktop
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    carregarDados();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   context.read<BadgeProvider>().marcarComoVisto('tela_relatorios');
    // });
  }

  Future<void> carregarDados() async {
    final cargoSalvo = await CargoHelper.lerCargo();
    final assi = await PremiumHelper.lerPremium();

    setState(() {
      checkAssinatura = assi;
      cargoAtual = cargoSalvo;
    });
  }

  // Método centralizado para gerenciar a lógica de navegação e permissão
  void _handleSelection(int index, bool isWideScreen, Widget? pageDestination, {bool isUrl = false, String? url}) {
    // 1. Lógica de URL (Links externos sempre abrem fora, independente do layout)
    if (isUrl && url != null) {
      launchUrl(Uri.parse(url));
      return;
    }

    // 2. Lógica de Permissões (Bloqueia antes de trocar a tela)
    // Exemplo: Bloqueio para Fornecedores
    if ([1, 8, 10].contains(index)) { // Index de Fornecedores
      if (cargoAtual == 'Visitante') {
        AppFlushbar.error('Faça login para acessar essa página');
        return;
      }
      if (cargoAtual != 'admin' && cargoAtual != 'tecnico') {
        AppFlushbar.error('Você não tem permissão para acessar essa página');
        return;
      }
    }

    // Exemplo: Bloqueio Premium (Técnicos, Atendentes, Personalização)
    if ([2, 3, 4, 8].contains(index)) {
      if (cargoAtual == 'Visitante') {
        AppFlushbar.error('Faça login para acessar essa página');
        return;
      }
      if (!checkAssinatura) {
        AppFlushbar.error('Você precisa de uma assinatura para acessar esse recurso');
        // No desktop, podemos mandar para a página Premium à direita ou abrir modal
        if (isWideScreen) {
          setState(() => _selectedIndex = 99); // 99 seria o index da PremiumPage interna
        } else {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const PremiumPage()));
        }
        return;
      }
    }

    // 3. Navegação Efetiva
    if (isWideScreen) {
      // Desktop: Atualiza o painel da direita
      setState(() {
        _selectedIndex = index;
      });
    } else if (pageDestination != null) {
      // Mobile: Empilha a nova tela
      Navigator.push(context, MaterialPageRoute(builder: (context) => pageDestination));
    }
  }

  String _titulo(){
    switch (_selectedIndex) {
      case 0: return "Dados da Loja";
      case 1: return "Fornecedores";
      case 2: return "Técnicos";
      case 3: return "Atendentes";
      case 4: return "Personalização";
      case 7: return "Sobre";
      case 99: return "Recurso Pro";
      case 8: return "Assinatura";
      case 9: return "Horários de Operação";
      case 10: return "Conta";
      default: return "Configurações";
    }
  }

  // Retorna o widget correto para o lado direito baseando-se no índice
  Widget _getSelectedWidget() {
    switch (_selectedIndex) {
      case 0: return const DadosEmpresaPage(configPage: true);
      case 1: return const FornecedoresPage(configPage: true);
      case 2: return const TecnicosPage(configPage: true);
      case 3: return const AtendentesPage(configPage: true);
      case 4: return const TemaPage(configPage: true);
      case 7: return const SobrePage(configPage: true); // Pulei 5 e 6 pois são URLs
      case 8: return SubscriptionScreen(configPage: true);
      case 9: return const HorarioFuncionamentoPage(configPage: true);
      case 10: return const GerenciarContaScreen(configPage: true);
      case 99: return const PremiumPage(configPage: true); // Caso especial para redirecionamento Premium
      default: return const Center(child: Text("Selecione uma opção"));
    }
  }

  // Widget _getActionsWidget() {
  //   switch (_selectedIndex) {
  //     case 1: return ActionsFornecedor();
  //     default: return const SizedBox();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // 1. Descobre se é tela larga antes de renderizar os componentes
    bool isWideScreen = MediaQuery.of(context).size.width > 900;

    return Scaffold(
      appBar: AppBar(
        // 2. Corrige o título: dinâmico no Desktop, fixo no Mobile
        title: Text(isWideScreen ? _titulo() : "Configurações"),
        elevation: 0,
        leading: AppbarBtn(
          onPressed: () => Navigator.pop(context),
        ),
        actionsPadding: EdgeInsets.zero,
        actions: [
          if (checkAssinatura)
            GestureDetector(
              onTap: () => _handleSelection(8, isWideScreen, SubscriptionScreen()),
              child: Container(
                padding: const EdgeInsets.fromLTRB(15, 8, 8, 8),
                margin: const EdgeInsets.only(right: 8), // Pequeno ajuste de margem
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: const BorderRadius.all(Radius.circular(20))
                ),
                child: Row(
                  children: [
                    const Text('OS Pro',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 3),
                    if (checkAssinatura == true)
                      const Icon(Icons.verified, color: Colors.blueAccent, size: 15),
                  ],
                ),
              ),
            ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // A variável isWideScreen já foi calculada no início do build.
          // REMOVIDA A LINHA: !isWideScreen ? _selectedIndex = 8 : _selectedIndex = _selectedIndex;

          if (isWideScreen) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // LADO ESQUERDO: Menu (Tamanho Fixo)
                SizedBox(
                  width: 350,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(right: BorderSide(color: Colors.grey.shade300)),
                      color: Theme.of(context).cardColor,
                    ),
                    child: _buildMenuList(isWideScreen),
                  ),
                ),
                // LADO DIREITO: Conteúdo (Expansível)
                Expanded(
                  child: Container(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: KeyedSubtree(
                        key: ValueKey<int>(_selectedIndex),
                        child: _getSelectedWidget(),
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else {
            // MOBILE: Apenas a lista
            return _buildMenuList(isWideScreen);
          }
        },
      ),
    );
  }

  Widget _buildMenuList(bool isWideScreen) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16,0,16,0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: ListView(
            children: [

              _buildSection(
                title: "Minha Conta",
                children: [
                  _customTile(
                      index: 10,
                      title: "Conta",
                      subtitle: 'Gerencie sua conta',
                      icon: const Icon(Icons.person),
                      isWideScreen: isWideScreen,
                      onTap: () {
                        _handleSelection(10, isWideScreen, const GerenciarContaScreen());
                      }
                  ),
                  _customTile(
                      index: 8,
                      title: "Gerenciar Assinatura",
                      subtitle: 'Gerencie sua assinatura',
                      icon: const Icon(Icons.verified),
                      isWideScreen: isWideScreen,
                      onTap: () {
                        _handleSelection(8, isWideScreen, SubscriptionScreen());
                      }
                  ),
                ]
              ),

              _buildSection(
                title: "Empresa",
                children: [
                  _customTile(
                    index: 0,
                    title: "Dados da Loja",
                    subtitle: 'Adicione informações sobre a loja',
                    icon: const Icon(Icons.business_sharp),
                    isWideScreen: isWideScreen,
                    onTap: () => _handleSelection(0, isWideScreen, const DadosEmpresaPage()),
                  ),
                  _customTile(
                    index: 9,
                    title: "Horários de Operação",
                    subtitle: 'Definir hora de abertura e fechamento',
                    icon: const Icon(Icons.access_time_filled),
                    isWideScreen: isWideScreen,
                    onTap: () => _handleSelection(9, isWideScreen, const HorarioFuncionamentoPage()),
                  ),
                ]
              ),

              _buildSection(
                title: "Gestão",
                children: [
                  _customTile(
                    featureId: 'for',
                    index: 1,
                    title: "Fornecedores",
                    subtitle: 'Lista de fornecedores',
                    icon: const Icon(Icons.featured_play_list),
                    isWideScreen: isWideScreen,
                    onTap: () {
                      _handleSelection(1, isWideScreen, const FornecedoresPage());
                      context.read<BadgeProvider>().marcarComoVisto('for');
                    }
                  ),
                  _customTile(
                    featureId: 'tec',
                    index: 2,
                    title: "Técnicos",
                    subtitle: "Lista de técnicos",
                    icon: const Icon(Icons.build),
                    isWideScreen: isWideScreen,
                    trailing: checkAssinatura ? const Icon(Icons.chevron_right) : const Icon(RemixIcon.vipCrownLine, color: Colors.amber, size: 20),
                    onTap: () {
                      _handleSelection(2, isWideScreen, const TecnicosPage());
                      context.read<BadgeProvider>().marcarComoVisto('tec');
                    }
                  ),
                  _customTile(
                    featureId: 'ate',
                    index: 3,
                    title: "Atendentes",
                    subtitle: 'Lista de atendentes',
                    icon: const Icon(Icons.person),
                    isWideScreen: isWideScreen,
                    trailing: checkAssinatura ? const Icon(Icons.chevron_right) : const Icon(RemixIcon.vipCrownLine, color: Colors.amber, size: 20),
                    onTap: () {
                      _handleSelection(3, isWideScreen, const AtendentesPage());
                      context.read<BadgeProvider>().marcarComoVisto('ate');
                    }
                  ),
                ]
              ),

              _buildSection(
                title: "Aparência",
                children: [
                  _customTile(
                    index: 4,
                    title: "Personalização",
                    subtitle: 'Altere a aparência do app',
                    icon: const Icon(Icons.color_lens),
                    isWideScreen: isWideScreen,
                    trailing: checkAssinatura ? const Icon(Icons.chevron_right) : const Icon(RemixIcon.vipCrownLine, color: Colors.amber, size: 20),
                    onTap: () => _handleSelection(4, isWideScreen, const TemaPage()),
                  ),
                ]
              ),

              _buildSection(
                title: "Suporte e Ajuda",
                children: [
                  _customTile(
                    index: 5,
                    title: "Informar Problema",
                    subtitle: 'Informe algum problema',
                    icon: const Icon(Icons.bug_report),
                    isWideScreen: isWideScreen,
                    trailing: const Icon(Icons.open_in_new),
                    onTap: () => _handleSelection(5, isWideScreen, null, isUrl: true, url: 'https://docs.google.com/forms/d/e/1FAIpQLSfcTYYjDJuWfcXFkUQOsN1wXjabuo3UYbp4I2nxG2lNIb840w/viewform?usp=sf_link'),
                  ),
                  _customTile(
                    index: 6,
                    title: "Sugestões",
                    subtitle: "Conte-nos de suas sugestões",
                    icon: const Icon(Icons.feedback),
                    isWideScreen: isWideScreen,
                    trailing: const Icon(Icons.open_in_new),
                    onTap: () => _handleSelection(6, isWideScreen, null, isUrl: true, url: 'https://docs.google.com/forms/d/e/1FAIpQLSc6gwky9Hx39-aqkc-T5fXIKcwG9zsYXKMD7nuNISV3mqoqgQ/viewform?usp=sf_link'),
                  ),
                  _customTile(
                    index: 7,
                    title: "Sobre",
                    subtitle: 'Saiba mais sobre o app',
                    icon: const Icon(Icons.info),
                    isWideScreen: isWideScreen,
                    onTap: () => _handleSelection(7, isWideScreen, const SobrePage()),
                  ),
                ]
              ),

            ],
          ),
        ),
      ),
    );
  }

  // Novo Widget: Criador de Seções (Categorias)
  Widget _buildSection({required String title, required List<Widget> children}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12, top: 24, bottom: 8),
          child: Text(
            title.toUpperCase(),
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        CustomCard(
          child: Column(
            // Adiciona um Divider entre os itens, mas não no último
            children: children
          ),
        ),
      ],
    );
  }

  Widget _customTile({
    required int index,
    required String title,
    required String subtitle,
    required Widget icon,
    required Function() onTap,
    required bool isWideScreen,
    String? featureId,
    Widget? trailing,
  }) {
    // Verifica se este item está selecionado (apenas visualmente no desktop)
    bool isSelected = isWideScreen && _selectedIndex == index;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
          color: isSelected ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.15) : null,
          borderRadius: BorderRadius.circular(30),
          border: isSelected ? Border.all(color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3)) : null
      ),
      child: ListTile(
        dense: true,
        trailing: trailing ?? (isWideScreen ? null : const Icon(Icons.chevron_right)), // No desktop não precisa de seta indicando navegação
        leading: IndicadorNovidade(
          featureId: featureId ?? '', // <-- ID da novidade
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isSelected ? Colors.transparent : Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(25),
            ),
            child: IconTheme(
              data: IconThemeData(
                  color: isSelected ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.primary
              ),
              child: icon,
            ),
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
              fontWeight: isSelected ? FontWeight.w900 : FontWeight.bold,
              fontSize: 16,
              color: isSelected ? Theme.of(context).colorScheme.primary : null
          ),
        ),
        subtitle: Text(
          subtitle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: isSelected ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.8) : null),
        ),
        onTap: onTap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}