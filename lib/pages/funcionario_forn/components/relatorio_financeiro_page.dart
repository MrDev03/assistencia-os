import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../custom_widgets/appbar_btn.dart';
import '../../../custom_widgets/card.dart';
import '../../../db_helper/db_helper.dart';
import '../cadastro_funcionario_page.dart';
import 'custom_period_selector.dart'; // Para o TipoFuncionario

class RelatorioFinanceiroPage extends StatefulWidget {
  final dynamic funcionario;
  final TipoFuncionario tipo;

  const RelatorioFinanceiroPage({
    super.key,
    required this.funcionario,
    required this.tipo,
  });

  @override
  State<RelatorioFinanceiroPage> createState() => _RelatorioFinanceiroPageState();
}

class _RelatorioFinanceiroPageState extends State<RelatorioFinanceiroPage> {
  // Variáveis de Estado para o Período
  DateTime _dataInicio = DateTime.now().subtract(const Duration(days: 30)); // Padrão: Últimos 30 dias
  DateTime _dataFim = DateTime.now();
  String _labelPeriodo = 'Últimos 30 dias';

  // Variáveis de Estado para os Resultados
  double _valorTotalGerado = 0.0;
  double _valorComissao = 0.0;
  int _qtdServicos = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _filtrarDados();
  }

  /// 🔥 Lógica que busca os serviços e filtra pela data
  Future<void> _filtrarDados() async {
    setState(() => _isLoading = true);

    final servicos = await DatabaseHelper.getAllServicos();

    double totalCalc = 0.0;
    int qtdCalc = 0;

    final nomeFuncionario = widget.funcionario.nome?.trim();
    final percentualComissao = widget.funcionario.comissao ?? 0.0;

    for (var servico in servicos) {
      // 1. Verifica se o serviço pertence a este funcionário
      final nomeServico = switch (widget.tipo) {
        TipoFuncionario.atendente => servico.atendente,
        TipoFuncionario.tecnico => servico.tecnico,
        TipoFuncionario.fornecedor => servico.fornecedor,
      }?.trim();

      if (nomeServico != null && nomeServico == nomeFuncionario) {
        // 2. Verifica se o serviço está dentro da data selecionada
        final dataServico = servico.createdAt;

        if (dataServico != null) {
          // Zera as horas para comparar apenas os dias perfeitamente
          final dataComparacao = DateTime(dataServico.year, dataServico.month, dataServico.day);
          final inicio = DateTime(_dataInicio.year, _dataInicio.month, _dataInicio.day);
          final fim = DateTime(_dataFim.year, _dataFim.month, _dataFim.day);

          if (dataComparacao.isAfter(inicio.subtract(const Duration(days: 1))) &&
              dataComparacao.isBefore(fim.add(const Duration(days: 1)))) {

            totalCalc += servico.valorOriginalServicoDouble ?? 0.0;
            qtdCalc++;
          }
        }
      }
    }

    if (mounted) {
      setState(() {
        _valorTotalGerado = totalCalc;
        _valorComissao = (totalCalc * percentualComissao) / 100;
        _qtdServicos = qtdCalc;
        _isLoading = false;
      });
    }
  }

  /// 🔥 Função que o Seletor Customizado vai chamar quando mudar a data
  void _onPeriodoAlterado(DateTime inicio, DateTime fim, String label) {
    setState(() {
      _dataInicio = inicio;
      _dataFim = fim;
      _labelPeriodo = label;
    });
    _filtrarDados(); // Refaz o cálculo automaticamente
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final currency = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Relatório de Ganhos'),
        centerTitle: true,
        leading: AppbarBtn(onPressed: () => Navigator.pop(context)),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // --------------------------------------------------------
            // 🕒 1. SELETOR DE MÊS E ANO CUSTOMIZADO
            // --------------------------------------------------------
            Padding(
              padding: const EdgeInsets.only(top: 16.0, bottom: 24.0),
              child: SeletorMesAnoCustomizado(
                dataCadastro: widget.funcionario.dateTimeCadastro, // 🔥 Passa a data formatada
                onPeriodoChanged: _onPeriodoAlterado,
              ),
            ),

            // --------------------------------------------------------
            // 📊 2. RESULTADOS DO FILTRO
            // --------------------------------------------------------
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [

                    // CARD DE COMISSÃO (Destaque principal)
                    CustomCard(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.green.withValues(alpha: 0.1),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.payments_rounded, color: Colors.green, size: 32),
                          ),
                          const SizedBox(height: 12),
                          const Text('Sua Comissão no Período', style: TextStyle(fontSize: 14)),
                          const SizedBox(height: 4),
                          Text(
                            currency.format(_valorComissao),
                            style: const TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.green
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Taxa aplicada: ${widget.funcionario.comissao ?? 0}%',
                            style: TextStyle(color: theme.onSurface.withValues(alpha: 0.6), fontSize: 12),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // CARD DE RESUMO GERAL
                    CustomCard(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          _buildLinhaResumo(
                            context,
                            icone: Icons.attach_money,
                            titulo: 'Faturamento',
                            valor: currency.format(_valorTotalGerado),
                          ),
                          Divider(color: Colors.grey.withValues(alpha: 0.2), height: 30),
                          Visibility(
                            visible: (widget.funcionario.metaMensal ?? 0.0) > 0,
                            child: Column(
                              children: [
                                _buildLinhaResumo(
                                  context,
                                  icone: Icons.show_chart,
                                  titulo: 'Meta esse mês',
                                  valor: currency.format(widget.funcionario.metaMensal ?? 0.0),
                                ),
                                if ((widget.funcionario.metaMensal ?? 0.0) > 0) ...[
                                  const SizedBox(height: 12),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: LinearProgressIndicator(
                                      value: (_valorTotalGerado / (widget.funcionario.metaMensal ?? 0)).clamp(0.0, 1.0),
                                      minHeight: 8,
                                      backgroundColor: theme.primary.withValues(alpha: 0.1),
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        _valorTotalGerado >= (widget.funcionario.metaMensal ?? 0.0) ? Colors.green : theme.primary,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    '${((_valorTotalGerado / (widget.funcionario.metaMensal ?? 1)) * 100).toStringAsFixed(1).replaceAll('.0', '').replaceAll('.', ',')}% da meta atingida',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: theme.onSurface.withValues(alpha: 0.6),
                                    ),
                                  ),
                                ],
                                Divider(color: Colors.grey.withValues(alpha: 0.2), height: (widget.funcionario.metaMensal ?? 0.0) > 0 ? 40 : 30),
                              ],
                            ),
                          ),

                          _buildLinhaResumo(
                            context,
                            icone: Icons.build_circle_outlined,
                            titulo: 'Serviços Realizados',
                            valor: '$_qtdServicos serviços',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLinhaResumo(BuildContext context, {required IconData icone, required String titulo, required String valor}) {
    final theme = Theme.of(context).colorScheme;
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: theme.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Icon(icone, color: theme.primary, size: 20),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(titulo, style: const TextStyle(fontSize: 14)),
        ),
        Text(
          valor,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}