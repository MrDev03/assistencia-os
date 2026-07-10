import 'dart:ui';
import 'package:assistencia_os/custom_widgets/card.dart';
import 'package:assistencia_os/sync/modules/fornecedor_sync.dart';
import 'package:assistencia_os/sync/modules/tecnico_sync.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import 'package:remix_icons_flutter/remixicon_ids.dart';
import '../../../custom_widgets/dialog.dart';
import '../../../custom_widgets/appbar_btn.dart';
import '../../../custom_widgets/loading_widget.dart';
import '../../../custom_widgets/top_msg.dart';
import '../../../db_helper/db_helper.dart';
import '../../../models/atendente_model/atendente_model.dart';
import '../../../services/launcher_helper.dart';
import '../../../sync/modules/atendente_sync.dart';
import '../../funcionario_forn/cadastro_funcionario_page.dart';
import '../components/relatorio_financeiro_page.dart';

class AtendenteDetalhesPage extends StatefulWidget {

  final TipoFuncionario tipo;
  final VoidCallback onPress;
  final dynamic funcionario;
  final Future<void> Function() onEdit;  // 🔥 Novo: Para editar
  final int? index;

  const AtendenteDetalhesPage({
    super.key,
    required this.onPress,
    required this.funcionario,
    required this.tipo,
    required this.onEdit, // 🔥 Novo parâmetro obrigatório
    this.index,
  });

  @override
  State<AtendenteDetalhesPage> createState() => _AtendenteDetalhesPageState();
}

class _AtendenteDetalhesPageState extends State<AtendenteDetalhesPage> {

  Map<String, _ResumoFuncionario> resumoF = {};

  late dynamic func;
  final syncAtendente = AtendenteSync();
  final syncTecnico = TecnicoSync();
  final syncFornecedor = FornecedorSync();

  @override
  void initState() {
    carregarDados();
    func = widget.funcionario;
    super.initState();
  }

  String cargoName () {
    return switch (widget.tipo) {
      TipoFuncionario.atendente => 'Atendente',
      TipoFuncionario.tecnico => 'Técnico',
      TipoFuncionario.fornecedor => 'Fornecedor',
    };
  }

  /// 🔥 Badge Animada de Ranking (Ouro, Prata, Bronze)
  Widget _buildRankingBadge(BuildContext context, bool isDark) {
    if (widget.index == null || widget.index! > 2) {
      return const SizedBox.shrink(); // Se não for Top 3, não ocupa espaço na tela
    }

    final int rank = widget.index!;

    // Configurações de cores baseadas na posição
    Color baseColor;
    Color textColor;
    String text;

    if (rank == 0) {
      baseColor = Colors.amber; // Ouro
      textColor = isDark ? Colors.amber.shade200 : Colors.amber.shade800;
      text = '🥇 Top 1 em Faturamentos';
    } else if (rank == 1) {
      baseColor = isDark ? Colors.grey.shade400 : Colors.grey.shade600; // Prata
      textColor = isDark ? Colors.grey.shade200 : Colors.grey.shade800;
      text = '🥈 Top 2 em Faturamentos';
    } else {
      baseColor = Colors.orange; // Bronze
      textColor = isDark ? Colors.orange.shade200 : Colors.orange.shade900;
      text = '🥉 Top 3 em Faturamentos';
    }

    return Container(
      margin: const EdgeInsets.only(top: 12), // Espaço entre o cargo e a badge
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: baseColor.withValues(alpha: isDark ? 0.15 : 0.2), // Fundo translúcido
        borderRadius: BorderRadius.circular(20), // Formato de pílula
        border: Border.all(
          color: baseColor.withValues(alpha: 0.5),
          width: 1,
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.bold,
          color: textColor,
          letterSpacing: 0.5,
        ),
      ),
    )
        .animate() // 🔥 Início das animações
        .fade(duration: 500.ms)
        .scale(curve: Curves.easeOutBack, duration: 500.ms) // Efeito "Bounce" ao surgir
        .shimmer(delay: 800.ms, duration: 1500.ms, color: Colors.white54); // Brilho metálico passando
  }

Future<void> carregarDados() async {
  final atendentes = await DatabaseHelper.getAllAtendentes();
  final tecnicos = await DatabaseHelper.getAllTecnicos();
  final servicos = await DatabaseHelper.getAllServicos();
  final fornecedores = await DatabaseHelper.getAllFornecedores();

  final Map<String, _ResumoFuncionario> mapaTemporario = {};

  for (var servico in servicos) {

    final nome = switch (widget.tipo) {
      TipoFuncionario.atendente => servico.atendente,
      TipoFuncionario.tecnico => servico.tecnico,
      TipoFuncionario.fornecedor => servico.fornecedor,
    }?.trim();

    if (nome != null && nome.isNotEmpty) {
      final valorServico = servico.valorOriginalServicoDouble ?? 0.0; // Ajuste para o campo de valor correto

      if (!mapaTemporario.containsKey(nome)) {
        mapaTemporario[nome] = _ResumoFuncionario();
      }

      mapaTemporario[nome]!.quantidadeServicos += 1;
      mapaTemporario[nome]!.valorTotal += valorServico;
    }
  }

  setState(() {
    resumoF = mapaTemporario;
  });

}

  /// 🔥 Atualizar (Editar) Atendente
  Future<void> dynamicUpdate() async {

    // 1. Abre a tela passando o objeto atual para preencher os campos
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CadastroFuncionarioPage(
            tipo: widget.tipo,
            funcionario: func
        ),
      ),
    );

    // 2. Se o usuário preencheu e clicou em Salvar, processamos:
    if (result != null && result is Map<String, dynamic>) {
      if(!mounted) return;

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const LoadingWidget(message: ['Sincronizando...', 'Aguarde']),
      );

      try {
        // Atualiza as propriedades do objeto existente com os novos dados
        // Não mexemos no createdAt nem no dateTimeCadastro para preservar a data original

        if (widget.tipo == TipoFuncionario.atendente || widget.tipo == TipoFuncionario.tecnico) {
          func
            ..nome = result['nome']
            ..numero = result['numero']
            ..salario = result['salario']
            ..comissao = result['comissao']
            ..metaMensal = result['metaMensal']
            ..tempoExperiencia = result['tempoExperiencia']
            ..observacoes = result['observacoes'];
        } else {

        }

        if (widget.tipo == TipoFuncionario.atendente) {

          await DatabaseHelper.updateAtendente(func);
          await syncAtendente.push(func);

        } else if (widget.tipo == TipoFuncionario.tecnico) {

          await DatabaseHelper.updateTecnico(func);
          await syncTecnico.push(func);

        } else {

          await DatabaseHelper.updateFornecedor(func);
          await syncFornecedor.push(func);

        }

        setState(() {
          widget.onEdit();
        });

        if (!mounted) return;
        Navigator.pop(context); // Fecha o dialog de loading
        AppFlushbar.success('${func.nome ?? cargoName} atualizado com sucesso!');

      } catch (e) {
        if (!mounted) return;
        Navigator.pop(context); // Fecha o dialog de loading
        AppFlushbar.error('Erro ao atualizar no banco de dados.');
      }
    }
  }

  String _comissaoValue (double v) {
    return v.toString().replaceAll('.0', '').replaceAll('.', ',');
  }

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final resumo = func.nome != null ? (resumoF[func.nome] ?? _ResumoFuncionario()) : _ResumoFuncionario();

    final currency = NumberFormat.currency(
      locale: 'pt_BR',
      symbol: 'R\$',
    );

    // 🔥 1. CÁLCULO DA COMISSÃO AQUI
    final double percentualComissao = func.comissao ?? 0.0; // Pega a % ou 0 se for null
    final double valorDaComissao = (resumo.valorTotal * percentualComissao) / 100;

    return Scaffold(
      appBar: AppBar(
        leading: const AppbarBtn(),
        actions: [
          // 🔥 Chama o novo Menu Popup
          _buildMenuPopup(theme, isDark),
          const SizedBox(width: 8),
        ],
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        // Fundo em gradiente suave para destacar o efeito Glassmorphism
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                _buildAvatar(theme),
                const SizedBox(height: 24),
                Text(
                  func.nome ?? 'Indisponivel',
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Text(
                  cargoName(),
                  style: TextStyle(
                    fontSize: 16,
                    color: theme.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Visibility(
                  visible: widget.index != null,
                  child: _buildRankingBadge(context, isDark),
                ),

                const SizedBox(height: 32),
                _buildCard(
                  title: 'Informações',
                  children: [
                    _buildInfoRow(
                      icon: Icons.phone_outlined,
                      title: 'Número de Contato',
                      value: func.numero,
                    ),

                    _buildInfoRow(
                      icon: Icons.calendar_today_outlined,
                      title: 'Data de Cadastro',
                      value: func.dateTimeCadastro,
                    ),

                    _buildInfoRow(
                      icon: Icons.build_circle_outlined,
                      title: 'Quantidade de Serviços',
                      value: resumo.quantidadeServicos.toString(),
                      isLast: func.tempoExperiencia == null || func.observacoes == null
                    ),

                    _buildInfoRow(
                      visible: func.tempoExperiencia != null,
                      icon: Icons.hourglass_bottom,
                      title: 'Tempo de Experiência',
                      value: func.tempoExperiencia
                    ),

                    _buildInfoRow(
                      visible: func.observacoes != null,
                      icon: Icons.info_outlined,
                      title: 'Observações',
                      value: func.observacoes,
                      isLast: true,
                    ),

                  ],
                ),
                _buildCard(
                  title: 'Financeiro',
                  children: [
                    _buildInfoRow(
                      icon: Icons.monetization_on_rounded,
                      title: 'Salário Base',
                      value: currency.format(func.salario ?? 0.0),
                    ),

                    _buildInfoRow(
                      icon: Icons.show_chart,
                      title: 'Meta Mensal',
                      value: currency.format(func.metaMensal ?? 0.0),
                    ),

                    _buildInfoRow(
                      icon: Icons.percent_outlined,
                      title: 'Comissão',
                      value: '${_comissaoValue(func.comissao ?? 0.0)}%',
                    ),

                    _buildInfoRow(
                      icon: Icons.payments_outlined,
                      title: 'Comissão Total',
                      value: currency.format(valorDaComissao),
                    ),

                    _buildInfoRow(
                        icon: Icons.attach_money,
                        title: 'Valor Total Gerado',
                        value: currency.format(resumo.valorTotal),
                        isLast: true,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => RelatorioFinanceiroPage(
                                funcionario: func, // Passa o objeto do funcionário
                                tipo: widget.tipo, // Passa se é tecnico, atendente, etc.
                              ),
                            ),
                          );
                        }
                    ),
                  ]
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _confirmarDelecao() {
    CustomDialog2.show(
      context: context,
      title: 'Deletar ${func.nome} ?',
      description: 'Essa ação não poderá ser desfeita. Os serviços feitos por esse(a) ${cargoName()} continuarão salvos.',
      confirmText: 'Deletar',
      cancelText: 'Cancelar',
      isDestructive: true,
      onConfirm: () {
        Navigator.pop(context); // Fecha dialog
        Navigator.pop(context); // Retorna para a tela anterior
        widget.onPress();
      },
    );
  }

  /// 🔥 Avatar Moderno
  Widget _buildAvatar(ColorScheme theme) {
    String iniciais = '';
    final String nome = func.nome ?? '';
    if (nome.isNotEmpty) {
      final partes = nome.trim().split(' ');
      if (partes.isNotEmpty) iniciais = partes[0][0].toUpperCase();
      if (partes.length > 1) iniciais += partes[1][0].toUpperCase();
    }

    return Container(
      width: 110,
      height: 110,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: theme.primary,
        boxShadow: [
          BoxShadow(
            color: theme.primary.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          )
        ]
      ),
      alignment: Alignment.center,
      child: Text(
        iniciais,
        style: const TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }


  /// 🔥 Container Liquid Glass (Glassmorphism)
  Widget _buildCard({required List<Widget> children, required String title}) {
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
            children: children
          ),
        ),
      ],
    );
  }

  /// 🔥 Linha de Informação Padrão
  Widget _buildInfoRow({
    required IconData icon,
    required String title,
    required String? value,
    bool isLast = false,
    bool? visible,
    VoidCallback? onTap,
  }) {
    return Visibility(
      visible: visible ?? true,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: onTap,
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(icon, color: Theme.of(context).colorScheme.primary, size: 22),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 13,
                            color: Theme.of(context).textTheme.bodySmall?.color?.withValues(alpha: 0.7),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          value != null && value.isNotEmpty ? value : 'Não Informado',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (!isLast)
            Divider(color: Colors.grey.withValues(alpha: 0.2), height: 1),
        ],
      ),
    );
  }

  /// 🔥 Menu Popup Moderno e Animado
  Widget _buildMenuPopup(ColorScheme theme, bool isDark) {
    return PopupMenuButton<int>(
      // Customização do Ícone que fica na AppBar
      icon: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: theme.primary.withValues(alpha: isDark ? 0.15 : 0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(Icons.more_horiz, color: theme.primary),
      ),
      // Design moderno: Bordas bem arredondadas e sombra suave
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 8,
      padding: EdgeInsetsGeometry.zero,
      offset: const Offset(0, 50), // Descola o menu do topo
      color: Theme.of(context).colorScheme.surface,

      onSelected: (value) {
        if (value == 1) LauncherHelper.fazerLigacao(numero: func.numero ?? '');
        if (value == 2) LauncherHelper.abrirWhatsApp(telefone: func.numero ?? '', mensagem: '',);
        if (value == 3) dynamicUpdate();
        if (value == 4) _confirmarDelecao();
      },

      itemBuilder: (context) => [
        // ITEM 1: LIGAR
        PopupMenuItem(
          value: 1,
          child: _menuItem(
            title: 'Ligar',
            icon: RemixIcon.phoneFill,
          ),
        ),

        const PopupMenuDivider(),

        // ITEM 2: MENSAGEM
        PopupMenuItem(
          value: 2,
          child: _menuItem(
            title: 'Mensagem',
            icon: RemixIcon.whatsappFill,
            delay: 50.ms,
          ),
        ),

        const PopupMenuDivider(),

        // ITEM 3: EDITAR
        PopupMenuItem(
          value: 3,
          child: _menuItem(
            title: 'Editar Perfil',
            icon: RemixIcon.pencilFill,
            delay: 100.ms,
          ),
        ),

        const PopupMenuDivider(),

        // ITEM 4: DELETAR
        PopupMenuItem(
          value: 4,
          child: _menuItem(
            color: Colors.red,
            title: 'Deletar Funcionário',
            icon: RemixIcon.deleteBin5Fill,
            delay: 150.ms,
          ),
        ),
      ],
    );
  }

  Widget _menuItem ({
    required String title,
    required IconData icon,
    Duration? delay,
    Color? color,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color != null ? color.withValues(alpha: 0.1) : Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 20, color: color ?? Theme.of(context).colorScheme.primary),
        ),
        const SizedBox(width: 12),
        Text(title, style: TextStyle(color: color ?? Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.w600)),
      ],
    ).animate().fade(delay: delay, duration: 200.ms).slideX(begin: 0.2, duration: 200.ms);
  }

}

class _ResumoFuncionario {
  int quantidadeServicos;
  double valorTotal;

  _ResumoFuncionario({
    this.quantidadeServicos = 0,
    this.valorTotal = 0.0,
  });
}