import 'package:assistencia_os/custom_widgets/pagamentos/pagamento_check_list.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../../custom_widgets/acrescimos.dart';
import '../../custom_widgets/card.dart';
import '../../custom_widgets/text_field.dart';
import '../../providers/notifier.dart';
import '../calculadora.dart';
import 'models/data_cadastro.dart';

class PagamentoStep extends StatefulWidget {

  final DataCadastro data;
  final GlobalKey<FormState>? formKey;

  const PagamentoStep({
    super.key,
    required this.data,
    this.formKey,
  });

  @override
  State<PagamentoStep> createState() => _PagamentoStepState();
}

class _PagamentoStepState extends State<PagamentoStep> {

  final TextEditingController valorAcessorioController = TextEditingController();
  final TextEditingController entradaController = TextEditingController();
  final TextEditingController valorController = TextEditingController();
  final TextEditingController acessorioController = TextEditingController();

  bool pagamento2 = false;
  bool pagamentoAntecipado = false;

  @override
  void initState() {
    super.initState();

    _limparValores2();

    valorController.text = widget.data.valorOriginalServico;
    //entradaController.text = widget.data.entrada;

    valorController.addListener(() {
      widget.data.valorOriginalServico = valorController.text;
    });

    valorAcessorioController.addListener(() {
      widget.data.valorTotalAcessorios = valorAcessorioController.text;
    });

    acessorioController.addListener(() {
      widget.data.acessorios = acessorioController.text;
    });
  }

  @override
  void dispose() {
    super.dispose();
    valorController.dispose();
    entradaController.dispose();
    valorAcessorioController.dispose();
    acessorioController.dispose();
  }

  void _limparValores2 () {
    widget.data.formaPgto1 = '';
    widget.data.qtdParcelas1 = '';
    widget.data.formaPgto2 = '';
    widget.data.qtdParcelas2 = '';
    widget.data.valor2 = 0.0;
  }

  bool validarPagamentos(DataCadastro data) {
    final temPgto1 = data.formaPgto1.isNotEmpty;
    final temPgto2 = data.formaPgto2.isNotEmpty;

    return (!temPgto1 && temPgto2) || temPgto1;
  }

  bool validarCondicao(TextEditingController controller, DataCadastro data) {
    final campoVazio = controller.text.isEmpty;
    final doisPagamentos =
        data.formaPgto1.isNotEmpty && data.formaPgto2.isNotEmpty;
    final valor2ZeradoComPgto1 =
        data.formaPgto1.isNotEmpty && data.valor2 == 0.0;

    return campoVazio || doisPagamentos || valor2ZeradoComPgto1;
  }

  final currency = NumberFormat.currency(
    locale: 'pt_BR',
    symbol: 'R\$',
  );

  @override
  Widget build(BuildContext context) {

    final data = widget.data;
    //final valorTotalDouble = double.tryParse(widget.data.valor1.replaceAll('.', '').replaceAll(',', '.')) ?? 0;
    final theme = Theme.of(context);
    validate(value) =>
        value == null || value.isEmpty ? 'Campo obrigatório' : null;

    return Form(
      key: widget.formKey,
      child: Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: CustomCard(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                  
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Resumo:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    TextButton.icon(
                      style: TextButton.styleFrom(
                        visualDensity: VisualDensity.compact,
                        backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.1),
                      ),
                      onPressed: () {
                        setState(() {
                          data.formaPgto1 = '';
                          data.formaPgto2 = '';
                          data.qtdParcelas1 = '';
                          data.qtdParcelas2 = '';
                          data.valor2 = 0.0;
                          data.acessorios = '';
                          data.valorTotalAcessorios = '';
                          data.meusAcessorios = [];
                          valorAcessorioController.text = '';
                          acessorioController.text = '';
                        });
                      },
                      label: const Text('Restaurar dados'),
                      icon: const Icon(Icons.refresh),
                    ),
                  ],
                ),
                  
                const SizedBox(height: 20),
                  
                ValueListenableBuilder(
                  valueListenable: valorController,
                  builder: (context, value, child) {
                    return Column(
                      children: [
                  
                        _card(
                            cor: theme.colorScheme.primary.withValues(alpha: 0.1),
                            children: [
                              _linhaDados(
                                  label: 'Valor Total',
                                  valor: currency.format(data.valorServico + data.valorAcessorios),
                                  cor: theme.colorScheme.primary
                              ),
                  
                              if (data.valorAcessorios > 0)
                              _linhaDados(
                                label: 'Valor Total Acessórios',
                                valor: currency.format(data.valorAcessorios),
                                cor: theme.colorScheme.primary,
                              ),
                            ]
                        ),
                  
                        if (validarPagamentos(data))
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: _card(
                            cor: data.formaPgto1.isEmpty ? Colors.orange : Colors.green,
                            children: [
                  
                              _linhaDados(
                                label: data.formaPgto1.isEmpty ? 'Valor Restante' : 'Valor Pago',
                                valor: currency.format(data.valor1),
                                cor: data.formaPgto1.isEmpty ? Colors.orange : Colors.green,
                              ),
                  
                              if (data.formaPgto1 != '')
                              _linhaDados(
                                label: 'Forma de Pagamento',
                                valor: data.formaPgto1,
                                cor: data.formaPgto1.isEmpty ? Colors.orange : Colors.green,
                              ),
                  
                              if (data.formaPgto1 == 'Crédito parcelado')
                                _linhaDados(
                                  label: 'Parcelas',
                                  valor: data.qtdParcelas1 ?? '',
                                  cor: data.formaPgto1.isEmpty ? Colors.orange : Colors.green,
                                ),
                            ],
                          ),
                        ),
                  
                        if (data.formaPgto2 != '')
                        _card(
                          cor: Colors.green,
                          children: [
                            _linhaDados(
                              label: 'Valor Pago',
                              valor: currency.format(data.valor2),
                              cor: Colors.green,
                            ),
                            _linhaDados(
                              label: 'Forma de Pagamento',
                              valor: data.formaPgto2,
                              cor: Colors.green,
                            ),
                            if (data.formaPgto2 == 'Crédito parcelado')
                            _linhaDados(
                              label: 'Parcelas',
                              valor: data.qtdParcelas2 ?? '',
                              cor: Colors.green,
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
                  
                CustomTextField(
                  enabled: (data.formaPgto2 == '' || data.formaPgto1 == '') ? true : false,
                  hintText: '0,00',
                  controller: valorController,
                  labelText: 'Valor do Serviço',
                  requiredTxt: ' *',
                  prefix: const Text('R\$ '),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    CentavosInputFormatter(),
                  ],
                  validator: validate,
                  onChanged: (value) {
                    if (data.valorServico < widget.data.valor2) {
                      setState(() {
                        _limparValores2();
                      });
                  
                    }
                  },
                ),
                  
                const SizedBox(height: 16),
                  
                _buildBtn(
                  onPressed: () => showCalculatorModal(context),
                  icon: Icons.calculate_outlined,
                  label: "Calculadora",
                ),
                  
                // Onde ficava o AcessoriosWidget, coloque um botão ou card chamando essa função:
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: _buildBtn(
                    onPressed: () async {
                      // 1. Abre a tela e ESPERA o resultado (await)
                      final AcessoriosResult? resultado = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AcessoriosScreen(itensIniciais: data.meusAcessorios),
                        ),
                      );
                  
                      // 2. Se o usuário clicou em "Confirmar" na tela de acessórios, o resultado não será nulo
                      if (resultado != null) {
                        setState(() {
                          data.formaPgto1 = '';
                          data.qtdParcelas1 = '';
                  
                          // Atualiza a lista na tela principal
                          data.meusAcessorios = resultado.itens;
                  
                          // Atualiza os seus controllers!
                          valorAcessorioController.text = resultado.totalFormatado;
                          acessorioController.text = resultado.descricao;
                        });
            
                        // Aqui você tem acesso individual aos valores se precisar:
                        // resultado.total (double)
                        // resultado.itens (List<AcessorioItem>)
                      }
                    },
                    label: data.meusAcessorios.isEmpty ? "Incluir Acessórios" : "Gerenciar Acessórios",
                    icon: data.meusAcessorios.isEmpty ? Icons.add : Icons.edit,
                  ),
                ),
                  
                ValueListenableBuilder(
                    valueListenable: valorController,
                    builder: (context, value, child) {
                      return _buildBtn(
                  
                        onPressed: validarCondicao(valorController, data) ? null : () {
                  
                          showDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (_) => PagamentoDialog(
                                segundoPagamento: data.formaPgto1 == '' && data.formaPgto2 != '' ? true : false,
                                valorTotalRecebido: data.valor1,
                                pagamento: (formaPagamento, valorRecebido, parcelas, trocoRecebido) {
                  
                                  // Se o valor total for pago
                                  if (valorRecebido == data.valor1) {
                                    data.formaPgto1 = formaPagamento;
                                    data.qtdParcelas1 = parcelas;
                                  }
                  
                                  // Se o valor total não for pago
                                  if (valorRecebido != data.valor1) {
                                    data.formaPgto2 = formaPagamento;
                                    data.qtdParcelas2 = parcelas;
                                    data.valor2 = valorRecebido;
                                  }
                                  setState(() {});
                                }
                            ),
                          );
                        },
                        label: data.formaPgto2 != '' ? 'Pagar restante' : 'Pagamento Antecipado / Entrada',
                        icon: data.formaPgto2 != '' ? Icons.check : Icons.add,
                      );
                    }
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildBtn ({
    required String label, 
    required IconData? icon, 
    required VoidCallback? onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      child: FilledButton.icon(
        style: FilledButton.styleFrom(
          foregroundColor: Colors.white,
          disabledForegroundColor: Colors.grey.withValues(alpha: 0.5),
          animationDuration: const Duration(milliseconds: 300),
        ),
        onPressed: onPressed,
        label: Text(label),
        icon: Icon(icon),
      ),
    );
  }

  Widget _card ({required List<Widget> children, required Color cor}) {

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: cor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: cor.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: children,
      ),
    );
  }

  Color clarear(Color cor, [double amount = .2]) {
    final hsl = HSLColor.fromColor(cor);
    final hslLight = hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));
    return hslLight.toColor();
  }

  Color escurecer(Color cor, [double amount = .2]) {
    final hsl = HSLColor.fromColor(cor);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
    return hslDark.toColor();
  }


  Widget _linhaDados ({required String label, required String valor, Color? cor}) {

    final isDark = Theme.of(context).brightness == Brightness.dark;

    final corAjustada = cor == null
        ? null
        : isDark
        ? clarear(cor, 0.35)   // clareia no dark
        : escurecer(cor, 0.15); // escurece no light

    return Row(
      children: [
        Text(label,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: corAjustada,
          ),
        ),
        const Spacer(),
        Text(valor,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: corAjustada,
          ),
        )
      ],
    );
  }
}
