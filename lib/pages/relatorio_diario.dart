import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:assistencia_os/custom_widgets/badge_peca.dart';
import 'package:assistencia_os/pages/details_os/details_os_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:isar_community/isar.dart';
import '../custom_widgets/appbar_btn.dart';
import '../custom_widgets/card.dart';
import '../db_helper/db_helper.dart';
import '../models/cliente_model/cliente_model.dart';
import '../models/servico_model/servico_model.dart';
import 'home/home.dart';

enum FiltroPeriodo { diario, mensal }

class RelatorioDiarioPage extends StatefulWidget {
  const RelatorioDiarioPage({super.key});

  @override
  State<RelatorioDiarioPage> createState() => _RelatorioDiarioPageState();
}

class _RelatorioDiarioPageState extends State<RelatorioDiarioPage> {
  // Estado
  List<Servico> servicos = [];
  Map<String, int> formasPgto = {};

  int totalServicos = 0;
  double valorBruto = 0;
  double aReceber = 0;
  double faturado = 0;
  double lucroTotal = 0;
  double despesaPeca = 0;
  double semSolucao = 0;

  DateTime _dataSelecionada = DateTime.now();
  FiltroPeriodo filtroAtual = FiltroPeriodo.diario;
  bool isLoading = false;
  final currencyFormat = NumberFormat.simpleCurrency(locale: 'pt_BR');

  @override
  void initState() {
    super.initState();
    carregarRelatorio();
    DatabaseHelper.isar.servicos.watchLazy().listen((_) {
      if (mounted) carregarRelatorio();
    });
  }

  // --- Lógica de Seleção de Data ---
  Future<void> _processarSelecaoData() async {
    DateTime? picked;

    if (filtroAtual == FiltroPeriodo.diario) {
      picked = await showDatePicker(
        context: context,
        initialDate: _dataSelecionada,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
        locale: const Locale('pt', 'BR'),
        helpText: 'SELECIONE O DIA',
      );
    } else {
      picked = await showDatePicker(
        context: context,
        initialDate: _dataSelecionada,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
        locale: const Locale('pt', 'BR'),
        helpText: 'SELECIONE QUALQUER DIA DO MÊS',
        initialDatePickerMode: DatePickerMode.year,
      );
    }

    if (picked != null) {
      setState(() => _dataSelecionada = picked!);
      carregarRelatorio();
    }
  }

  // --- Lógica de Carregamento ---
  Future<void> carregarRelatorio() async {
    if (!mounted) return;
    setState(() => isLoading = true);
    final isar = DatabaseHelper.isar;
    List<Servico> result = [];

    try {
      if (filtroAtual == FiltroPeriodo.diario) {
        final dataStr = DateFormat('dd/MM/yyyy').format(_dataSelecionada);
        result = await isar.servicos.filter().dataStartsWith(dataStr).findAll();
      } else {
        final diasNoMes = DateUtils.getDaysInMonth(_dataSelecionada.year, _dataSelecionada.month);
        final mesAno = DateFormat('/MM/yyyy').format(_dataSelecionada);
        List<String> diasParaBuscar = [];

        for (int i = 1; i <= diasNoMes; i++) {
          String dia = i.toString().padLeft(2, '0');
          diasParaBuscar.add("$dia$mesAno");
        }

        result = await isar.servicos.filter().group((q) {
          QueryBuilder<Servico, Servico, QAfterFilterCondition>? builder;
          for (var diaStr in diasParaBuscar) {
            if (builder == null) {
              builder = q.dataStartsWith(diaStr);
            } else {
              builder = builder.or().dataStartsWith(diaStr);
            }
          }
          return builder!;
        }).findAll();
      }

      double somaValores = 0, aReceber2 = 0, faturado2 = 0;
      double lucroTotal2 = 0, despesaPeca2 = 0, semSolucao2 = 0;
      Map<String, int> contagemPgto = {};

      for (var s in result) {
        final status = s.status?.toLowerCase().trim() ?? '';
        final bool falhou = status == 'sem solução';

        if (!falhou) {
          faturado2 += s.valorOriginalServicoDouble ?? 0;
          lucroTotal2 += (s.valorOriginalServicoDouble ?? 0) - (s.valorTotalCustoPecasDouble ?? 0);
          despesaPeca2 += s.valorTotalCustoPecasDouble ?? 0;
          if (s.formaPgto1 == '') aReceber2 += (s.valor1Double ?? 0);
          if (s.formaPgto2 == '') aReceber2 += (s.valor2 ?? 0);
        } else {
          semSolucao2 += s.valorOriginalServicoDouble ?? 0;
        }

        somaValores += s.valorOriginalServicoDouble ?? 0;

        List<String> pagamentos = [];
        if (s.formaPgto1.isNotEmpty == true) pagamentos.add(s.formaPgto1);
        if (s.formaPgto2.isNotEmpty == true) pagamentos.add(s.formaPgto2);
        if (pagamentos.isEmpty) pagamentos.add("Não informado");

        for (var pgto in pagamentos) {
          contagemPgto[pgto] = (contagemPgto[pgto] ?? 0) + 1;
        }
      }

      if (mounted) {
        setState(() {
          servicos = result;
          totalServicos = servicos.length;
          valorBruto = somaValores;
          aReceber = aReceber2;
          faturado = faturado2;
          despesaPeca = despesaPeca2;
          semSolucao = semSolucao2;
          lucroTotal = lucroTotal2;
          formasPgto = contagemPgto;
          isLoading = false;
        });
      }
    } catch (e) {
      debugPrint("Erro ao carregar relatório: $e");
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      //backgroundColor: theme.colorScheme.surface, // Fundo limpo
      appBar: AppBar(
        title: const Text(
          'Desempenho',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: AppbarBtn(onPressed: () => Navigator.pop(context)),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : RefreshIndicator(
          onRefresh: carregarRelatorio,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                children: [
                  // --- Controles de Filtro ---
                  _seletorPeriodo().animate().fadeIn().slideY(begin: -0.2),
                  const SizedBox(height: 20),
                  Center(child: _buildSelectorData(context)).animate().fadeIn(delay: 100.ms).slideY(begin: -0.2),
                  const SizedBox(height: 24),

                  if (servicos.isNotEmpty) ...[
                    context.isDesktop ? _buildDesktopLayout() : _buildMobileLayout(),
                  ] else ...[
                    const SizedBox(height: 60),
                    const Vazio(label: "Nenhum serviço encontrado neste período.")
                        .animate()
                        .fadeIn()
                        .scale(begin: const Offset(0.9, 0.9)),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      children: [
        _cardResumo().animate().fadeIn(delay: 200.ms).slideX(begin: 0.1),
        const SizedBox(height: 24),
        _graficoPizza().animate().fadeIn(delay: 300.ms).scale(begin: const Offset(0.95, 0.95)),
        const SizedBox(height: 24),
        _listaServicos().animate().fadeIn(delay: 400.ms).slideY(begin: 0.1),
        const SizedBox(height: 30),
      ],
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _cardResumo().animate().fadeIn(delay: 200.ms),
              const SizedBox(height: 24),
              CustomCard(
                borderRadius: 24,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: _listaServicos(),
                ),
              ).animate().fadeIn(delay: 400.ms),
            ],
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          flex: 4,
          child: _graficoPizza().animate().fadeIn(delay: 300.ms),
        ),
      ],
    );
  }

  // 📊 Cards de Resumo Modernizados
  Widget _cardResumo() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      clipBehavior: Clip.none, // Permite que a sombra dos cards não seja cortada
      child: Row(
        children: [
          _buildResumoBox("Lucro Total", currencyFormat.format(lucroTotal), Icons.monetization_on_rounded, Colors.green),
          //_buildResumoBox("Faturado", currencyFormat.format(faturado), Icons.trending_up_rounded, Colors.blueAccent),
          _buildResumoBox('A Receber', currencyFormat.format(aReceber), Icons.pending_actions_rounded, Colors.orange),
          _buildResumoBox('Bruto Total', currencyFormat.format(valorBruto), Icons.account_balance_wallet_rounded, Colors.deepPurple),
          _buildResumoBox("Peças", currencyFormat.format(despesaPeca), Icons.memory_rounded, Colors.pink),
          _buildResumoBox("Sem Solução", currencyFormat.format(semSolucao), Icons.money_off_rounded, Colors.red, negative: true),
        ],
      ),
    );
  }

  // Donut Chart com Total no centro
  Widget _graficoPizza() {
    return CustomCard(
      borderRadius: 24,
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Formas de Pagamento",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 220,
            child: Stack(
              alignment: Alignment.center,
              children: [
                PieChart(
                  PieChartData(
                    sectionsSpace: 4, // Espaço maior e mais moderno
                    centerSpaceRadius: 65, // Buraco maior para o Donut
                    sections: formasPgto.entries.map((e) {
                      final percent = (e.value / totalServicos) * 100;
                      return PieChartSectionData(
                        color: _getCorPorPagamento(e.key),
                        value: e.value.toDouble(),
                        title: "${percent.toStringAsFixed(0)}%",
                        radius: 40, // Espessura do anel
                        titleStyle: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        badgeWidget: _buildBadgeGrafico(e.key),
                        badgePositionPercentageOffset: 1.2, // Joga o ícone pra fora
                      );
                    }).toList(),
                  ),
                ),
                // Texto Centralizado
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      totalServicos.toString(),
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    Text(
                      "Serviços",
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          _chips(),
        ],
      ),
    );
  }

  Widget _chips() {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 12,
      runSpacing: 12,
      children: formasPgto.keys.map((key) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(backgroundColor: _getCorPorPagamento(key), radius: 5),
              const SizedBox(width: 8),
              Text(
                "$key (${formasPgto[key]})",
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _seletorPeriodo() {
    return AnimatedToggleSwitch<FiltroPeriodo>.custom(
      current: filtroAtual,
      values: const [FiltroPeriodo.diario, FiltroPeriodo.mensal],
      iconOpacity: 1.0,
      indicatorSize: const Size.fromWidth(160),
      borderWidth: 0,
      height: 48,
      style: ToggleStyle(
        indicatorColor: Theme.of(context).colorScheme.primary,
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(25),
        indicatorBoxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      animatedIconBuilder: (context, local, global) {
        final isSelected = local.value == global.current;
        final isDiario = local.value == FiltroPeriodo.diario;
        final color = isSelected ? Theme.of(context).colorScheme.onPrimary : Theme.of(context).colorScheme.onSurfaceVariant;

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(isDiario ? Icons.today_rounded : Icons.calendar_month_rounded, size: 20, color: color),
            const SizedBox(width: 8),
            Text(
              isDiario ? "Diário" : "Mensal",
              style: TextStyle(
                color: color,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
              ),
            ),
          ],
        );
      },
      onChanged: (val) {
        setState(() => filtroAtual = val);
        carregarRelatorio();
      },
    );
  }

  // Lista estilo "Ajustes do iOS" (Inset Grouped)
  Widget _listaServicos() {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 12),
          child: Text(
            "Detalhamento de Serviços",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: theme.colorScheme.onSurface),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.02),
                blurRadius: 10,
                offset: const Offset(0, 4),
              )
            ],
          ),
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: servicos.length,
            separatorBuilder: (_, __) => Divider(
              height: 1,
              indent: 64, // O divisor não cruza o ícone, padrão Apple
              color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5),
            ),
            itemBuilder: (context, index) {
              final servico = servicos[index];
              final isar = DatabaseHelper.isar;
              final cliente = servico.clienteId != null
                  ? isar.clientes.getSync(servico.clienteId!) ?? Cliente()
                  : Cliente();
              final valor = servico.valorOriginalServicoDouble ?? 0;
              final isSemSolucao = servico.status == "sem solução";

              return ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DetalhesServicoPage(servico: servico, cliente: cliente)),
                  );
                },
                leading: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: isSemSolucao
                        ? Colors.red.withValues(alpha: 0.1)
                        : theme.colorScheme.primary.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isSemSolucao ? Icons.error_outline_rounded : Icons.build_rounded,
                    color: isSemSolucao ? Colors.red : theme.colorScheme.primary,
                  ),
                ),
                title: Row(
                  children: [
                    Expanded(
                      child: Text(
                        servico.modelo ?? "Sem modelo",
                        style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (isSemSolucao) const BadgeCustom(label: 'Sem solução', color: Colors.red),
                  ],
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Row(
                    children: [
                      Icon(Icons.person_outline_rounded, size: 14, color: theme.colorScheme.onSurfaceVariant),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          servico.nomeCliente ?? "Cliente não informado",
                          style: TextStyle(color: theme.colorScheme.onSurfaceVariant, fontSize: 13),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                trailing: Text(
                  "${isSemSolucao ? '-' : '+'} ${formatCurrencySafe(valor)}",
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                    color: isSemSolucao ? Colors.red : Colors.green,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // --- Widgets Auxiliares ---

  Widget _buildSelectorData(BuildContext context) {
    String textoDisplay = filtroAtual == FiltroPeriodo.diario
        ? UtilData.obterDataDDMMAAAA(_dataSelecionada)
        : "${DateFormat.MMMM('pt_BR').format(_dataSelecionada)[0].toUpperCase()}${DateFormat.MMMM('pt_BR').format(_dataSelecionada).substring(1)} ${_dataSelecionada.year}";

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: _processarSelecaoData,
        borderRadius: BorderRadius.circular(30),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.2)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.calendar_month_rounded, color: Theme.of(context).colorScheme.primary, size: 18),
              const SizedBox(width: 10),
              Text(
                textoDisplay,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(width: 6),
              Icon(Icons.keyboard_arrow_down_rounded, color: Theme.of(context).colorScheme.primary),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResumoBox(String label, String value, IconData icon, Color color, {bool negative = false}) {
    return Container(
      width: 150,
      margin: const EdgeInsets.only(right: 16, bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: color.withValues(alpha: 0.3)),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.05),
            blurRadius: 15,
            offset: const Offset(0, 8),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 16),
          Text(
            negative ? '- $value' : value,
            style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.onSurfaceVariant),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  String formatCurrencySafe(double? value) => currencyFormat.format(value ?? 0.0);

  // Widget para os ícones pequenos grudados no gráfico de anel
  Widget _buildBadgeGrafico(String forma) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        shape: BoxShape.circle,
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 4)],
      ),
      child: Icon(Icons.attach_money_rounded, size: 12, color: _getCorPorPagamento(forma)),
    );
  }

  Color _getCorPorPagamento(String forma) {
    switch (forma.toLowerCase()) {
      case 'dinheiro': return const Color(0xFF34C759); // Verde Apple
      case 'pix': return const Color(0xFF32ADE6); // Ciano Apple
      case 'crédito à vista': return const Color(0xFF007AFF); // Azul Apple
      case 'crédito parcelado': return const Color(0xFFFF2D55); // Rosa Apple
      case 'alimentação': return const Color(0xFFFF9500); // Laranja Apple
      case 'boleto': return const Color(0xFFAF52DE); // Roxo Apple
      case 'débito': return const Color(0xFF5856D6); // Anil Apple
      case 'fiado': return const Color(0xFFFF3B30); // Vermelho Apple
      default: return Colors.grey;
    }
  }
}

class Vazio extends StatelessWidget {
  final String label;
  const Vazio({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceVariant.withValues(alpha: 0.5),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.inbox_rounded, size: 48, color: Theme.of(context).colorScheme.onSurfaceVariant),
          ),
          const SizedBox(height: 16),
          Text(label, style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant, fontSize: 16, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

class UtilData {
  static String obterDataDDMMAAAA(DateTime data) => DateFormat('dd/MM/yyyy').format(data);
}