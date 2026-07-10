import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import '../badge_peca.dart';
import '../dropdown_button_formfield.dart';
import 'models/pagamanto_model.dart';

class PagamentoDialog extends StatefulWidget {
  final double valorTotalRecebido;
  final bool segundoPagamento;
  final Function(
  String formaPagamento,
  double valorRecebido,
  String parcelas,
  double troco,
  ) pagamento;

  const PagamentoDialog({
    super.key,
    required this.valorTotalRecebido,
    required this.segundoPagamento,
    required this.pagamento,
  });

  @override
  State<PagamentoDialog> createState() => _PagamentoDialogState();
}

class _PagamentoDialogState extends State<PagamentoDialog> {

  PagamantoModel modelPgto = PagamantoModel();

  int _paginaAtual = 0;

  String? formaPagamentoSelecionada;
  String parcelasRetornadas = '';
  double valorTelaAnterior = 0;
  double valorTroco = 0;
  double valorRetornado = 0;

  @override
  void initState() {
    super.initState();
    valorTelaAnterior = widget.valorTotalRecebido;
  }

  void _selecionarPagamento(String pagamento) {
    setState(() {
      formaPagamentoSelecionada = pagamento;

      if (pagamento == "Crédito") {
        _paginaAtual = 1;   // vai para parcelamento
      } else {
        _paginaAtual = 2;   // vai direto para confirmação
      }
    });
  }

  final currency = NumberFormat.currency(
    locale: 'pt_BR',
    symbol: 'R\$',
  );

  void _paginaAnterior() {

      setState(() {
        _paginaAtual--;
      });

  }

  String obterParcelamento2x(double valor) {
    if (valor <= 0) return "";

    final fmt = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');

    return "2x de ${fmt.format(valor / 2)}";
  }

  bool _carregando = false;


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      contentPadding: const EdgeInsets.all(0),
      content: SingleChildScrollView(
        child: AnimatedSize(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          alignment: Alignment.topCenter,
          child: Container(
            //duration: const Duration(milliseconds: 300),
            width: 380,
            constraints: const BoxConstraints(
              maxWidth: 380,
              minHeight: 200,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
          
                /// indicador de etapas
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        currency.format(widget.valorTotalRecebido),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      const Spacer(),
                      Visibility(
                        visible: formaPagamentoSelecionada != null,
                        child: BadgeCustom(
                          label: formaPagamentoSelecionada ?? '',
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
        
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  switchInCurve: Curves.easeOut,
                  switchOutCurve: Curves.easeIn,
                  transitionBuilder: (child, animation) {
                    return FadeTransition(
                      opacity: animation,
                      child: SlideTransition(
                        position: Tween(
                          begin: const Offset(0.08, 0),
                          end: Offset.zero,
                        ).animate(animation),
                        child: child,
                      ),
                    );
                  },
                  child: _buildPaginaAtual(),
                ),
        
        
                const Divider(height: 1),
          
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: SizedBox(
                    height: 50,
                    child: Row(
                      children: [
          
                        if (_paginaAtual != 0)
                          FilledButton.icon(
                            style: FilledButton.styleFrom(
                              backgroundColor: Theme.of(context).colorScheme.primary,
                              foregroundColor: Colors.white,
                            ),
                            onPressed: () {
                              if (formaPagamentoSelecionada == 'Crédito parcelado' || formaPagamentoSelecionada == 'Crédito à vista') {
                                _paginaAnterior();
                              } else {
                                setState(() {
                                  _paginaAtual = 0;
                                });
                              }
                              if (_paginaAtual == 2){
                                modelPgto.valorDigitado = '';
                                modelPgto.valorParceladoSelecionado = '';
                              }
                              formaPagamentoSelecionada = null;
                            },
                            label: const Text("Voltar"),
                            icon: const Icon(Icons.arrow_back),
                          ),
          
                        const Spacer(),
          
                        if (_paginaAtual == 2)
                          FilledButton(
                            style: FilledButton.styleFrom(
                              backgroundColor: Colors.green[700],
                              foregroundColor: Colors.white,
                            ),
                            onPressed: _carregando ? null : () {

                              setState(() {
                                _carregando = true;
                              });

                              if (valorRetornado > valorTelaAnterior && formaPagamentoSelecionada == 'Crédito parcelado') return;
                              // Retorna valores para a tela de pagamento
                              widget.pagamento(
                                formaPagamentoSelecionada ?? '',
                                valorRetornado == 0.0 ? valorTelaAnterior : valorRetornado,
                                parcelasRetornadas == '' && formaPagamentoSelecionada == 'Crédito parcelado' ? obterParcelamento2x(valorTelaAnterior) : parcelasRetornadas,
                                valorTroco,
                              );
                              Navigator.pop(context);
                            },
                            child: const Text("Concluir"),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ).animate().scale(curve: Curves.elasticOut, duration: const Duration(milliseconds: 700), delay: 100.ms);
  }

  Widget _buildPaginaAtual() {
    switch (_paginaAtual) {
      case 0:
        return _Tela1(
          key: const ValueKey(0),
          onSelecionar: _selecionarPagamento,
        );
      case 1:
        return _Tela2(
          key: const ValueKey(2),
          onSelecionar: _selecionarPagamento,
          pagamentoSelecionado: formaPagamentoSelecionada ?? '',
        );
      case 2:
        return _Tela3(
          key: const ValueKey(3),
          valorTotal: valorTelaAnterior,
          segundoPagamento: widget.segundoPagamento,
          pagamentoSelecionado: formaPagamentoSelecionada ?? '',
          onAtualizar: (pago, parcelas, troco) {
            setState(() {
              valorRetornado = pago;
              valorTroco = troco;
              if (parcelas != '') {
                parcelasRetornadas = parcelas;
              }
            });
            //print('Pago: $pago, Parcelas: $parcelas, Troco: $troco');
          },
        );
      default:
        return const SizedBox();
    }
  }

}

class _Tela1 extends StatelessWidget {

  final Function(String) onSelecionar;
  final Key key;

  _Tela1({
    required this.key,
    required this.onSelecionar,
  });

  String? selecionado;

  final formasPagamento = [
    _FormaPagamento("Dinheiro", Icons.attach_money),
    _FormaPagamento("Pix", Icons.pix),
    _FormaPagamento("Débito", Icons.credit_card),
    _FormaPagamento("Crédito", Icons.credit_card_outlined),
    _FormaPagamento("Alimentação", Icons.restaurant),
    _FormaPagamento("Boleto", Icons.receipt_long),
    _FormaPagamento("Cheque", Icons.description),
    //_FormaPagamento("Fiado", Icons.handshake),
  ];

  @override
  Widget build(BuildContext context) {

    final brigthness = Theme.of(context).brightness;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: GridView.builder(
        itemCount: formasPagamento.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          //childAspectRatio: 1.4,
          mainAxisExtent: 90,
        ),
        itemBuilder: (context, index) {

          final forma = formasPagamento[index];
          final ativo = forma.nome == selecionado;

          return InkWell(
            borderRadius: BorderRadius.circular(14),
            onTap: () => onSelecionar(forma.nome),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              decoration: BoxDecoration(
                color: brigthness == Brightness.dark
                    ? Colors.grey.shade900
                    : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: brigthness == Brightness.dark
                      ? Colors.grey.shade800
                      : Colors.grey.shade300,
                  width: ativo ? 2 : 1,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    forma.icon,
                    size: 30,
                    color: brigthness == Brightness.dark
                        ? Colors.grey.shade200
                        : Colors.grey[700],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    forma.nome,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: brigthness == Brightness.dark
                          ? Colors.grey.shade200
                          : Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _FormaPagamento {
  final String nome;
  final IconData icon;

  _FormaPagamento(this.nome, this.icon);
}

//===========================
// TELA 2
//===========================

class _Tela2 extends StatelessWidget {
  final Function(String) onSelecionar;
  final String pagamentoSelecionado;
  //final Function(String parcelas) parcelasCallBack;
  final Key key;
  _Tela2({
    required this.key,
    required this.onSelecionar,
    required this.pagamentoSelecionado,
    //required this.parcelasCallBack,
  });

  final PagamantoModel modelPgto = PagamantoModel();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          leading: const Icon(Icons.credit_card),
          title: const Text("Crédito parcelado"),
          trailing: const Icon(Icons.chevron_right_outlined),
          onTap: () {
            onSelecionar("Crédito parcelado");
            _definirParcelaPadrao();

          },
        ),
        ListTile(
          leading: const Icon(Icons.credit_card_outlined),
          title: const Text("Crédito à vista"),
          trailing: const Icon(Icons.chevron_right_outlined),
          onTap: () {
            onSelecionar("Crédito à vista");
          },
        ),
      ],
    );
  }

  void _definirParcelaPadrao() {

    print('Entrou no definir parcela padrão ');
    //if (pagamentoSelecionado != 'Crédito parcelado') return;
    print('Passo pagamento selecionado ');

    double total = modelPgto.valorPago;
    print('Total: $total');
    if (total <= 0) {
      modelPgto.valorParceladoSelecionado = "";
      return;
    }

    print('Passo pagamento selecionado 2');

    final fmt = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');

    final opcoes = List.generate(
      11,
          (i) => "${i + 2}x de ${fmt.format(total / (i + 2))}",
    );

    // 👇 define automaticamente a primeira opção
    //modelPgto.valorParceladoSelecionado = opcoes.first;
    //parcelasCallBack(opcoes.first);

    print('Passo pagamento: ${opcoes.first}');
  }

}

//===========================
// TELA 3
//===========================


class _Tela3 extends StatefulWidget {
  final bool segundoPagamento;
  final String pagamentoSelecionado;
  final double valorTotal;
  final Function(double pago, String parcelas, double troco) onAtualizar;

  // Transformado em final (Widgets devem ser imutáveis)
  // Caso precise iniciar com um valor, use isso apenas para o initState

  const _Tela3({
    super.key, // Key passada no super
    required this.valorTotal,
    required this.onAtualizar,
    required this.segundoPagamento,
    required this.pagamentoSelecionado,
  });

  @override
  State<_Tela3> createState() => _Tela3State();
}

class _Tela3State extends State<_Tela3> {
  PagamantoModel modelPgto = PagamantoModel();

  @override
  void initState() {
    super.initState();
    modelPgto.valorTotal = widget.valorTotal;
    //_definirParcelaPadrao();
    // Se precisar iniciar o modelPgto com o valorDigitadoInicial, faça aqui:
    // modelPgto.valorDigitado = converterDoubleParaString(widget.valorDigitadoInicial);
  }

  String formatar(double valor) {
    return NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$').format(valor);
  }

  void adicionarNumero(String numero) {
    setState(() {
      if (modelPgto.valorDigitado.length < 9) {
        modelPgto.valorDigitado += numero;
      }
      _validarParcelaAtual(); // Valida se a parcela ainda faz sentido com o novo valor
    });
    _notificar();
  }

  void apagar() {
    if (modelPgto.valorDigitado.isEmpty) return;
    setState(() {
      modelPgto.valorDigitado = modelPgto.valorDigitado.substring(0, modelPgto.valorDigitado.length - 1);
      _validarParcelaAtual();
    });
    _notificar();
  }

  void limpar() {
    setState(() {
      modelPgto.valorDigitado = "";
      modelPgto.valorParceladoSelecionado = "";
      _validarParcelaAtual();
    });
    _notificar();
  }

  // Se o usuário apagar ou digitar um novo número, os valores do dropdown mudam.
  // Precisamos garantir que a parcela antiga não fique "presa" no model.
  void _validarParcelaAtual() {
    if (widget.pagamentoSelecionado != 'Crédito parcelado') return;

    // Simula a geração de opções para ver se a parcela selecionada ainda existe
    double total = modelPgto.valorPago;
    if (total <= 0) {
      //modelPgto.valorParceladoSelecionado = "";
      return;
    }

    final fmt = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
    List<String> opcoes = List.generate(
      11,
          (i) => "${i + 2}x de ${fmt.format(total / (i + 2))}",
    );

    if (!opcoes.contains(modelPgto.valorParceladoSelecionado)) {
      modelPgto.valorParceladoSelecionado = opcoes.isNotEmpty ? opcoes.first : "";
    }
  }

  // Essa é a função que manda os dados pra tela anterior instantaneamente
  void _notificar() {
    widget.onAtualizar(
      modelPgto.valorPago,
      modelPgto.valorParceladoSelecionado,
      modelPgto.troco,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          //if ()
          AnimatedSize(
            duration: const Duration(milliseconds: 300),
            child: Visibility(
              visible: modelPgto.valorPago > modelPgto.valorTotal && widget.pagamentoSelecionado == 'Crédito parcelado',
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                margin: const EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                  color: Colors.red.withAlpha(50),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text('Valor recebido maior que o valor total!',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),

          if (widget.pagamentoSelecionado == 'Crédito parcelado')
            _buildParcelasDropdown(),

          /// VALOR RECEBIDO
          _valorAnimado(
            label: "Recebido",
            valor: modelPgto.valorPago,
            cor: modelPgto.valorPago > modelPgto.valorTotal && widget.pagamentoSelecionado == 'Crédito parcelado' ? Colors.red : Colors.green,
          ),

          const SizedBox(height: 10),

          /// RESTANTE OU TROCO
          Visibility(
            visible: !widget.segundoPagamento,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: modelPgto.troco > 0 && widget.pagamentoSelecionado != 'Crédito parcelado'
                  ? _valorAnimado(
                key: const ValueKey("troco"),
                label: "Troco",
                valor: modelPgto.troco,
                cor: Colors.blue,
              )
                  : _valorAnimado(
                key: const ValueKey("restante"),
                label: "Restante",
                valor: modelPgto.restante,
                cor: Colors.orange,
              ),
            ),
          ),

          const SizedBox(height: 20),

          Visibility(
            visible: !widget.segundoPagamento,
            child: _teclado(),
          ),
        ],
      ),
    );
  }

  Widget _valorAnimado({
    Key? key,
    required String label,
    required double valor,
    required Color cor,
  }) {
    return Column(
      key: key,
      children: [
        Text(label),
        Text(
          formatar(valor),
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: cor,
          ),
        ),
      ],
    );
  }

  Widget _teclado() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 3,
      childAspectRatio: 1.4,
      children: [
        ...["1", "2", "3", "4", "5", "6", "7", "8", "9"].map((n) => _teclaNumero(n)),
        _teclaLimpar(),
        _teclaNumero("0"),
        _teclaApagar(),
      ],
    );
  }

  Widget _teclaNumero(String n) {
    return InkWell(
      splashColor: Theme.of(context).colorScheme.primary,
      highlightColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.5),
      borderRadius: BorderRadius.circular(10),
      onTap: () => adicionarNumero(n),
      child: Center(
        child: Text(
          n,
          style: const TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _teclaApagar() {
    return InkWell(
      splashColor: Colors.red,
      highlightColor: Colors.redAccent.withValues(alpha: 0.5),
      borderRadius: BorderRadius.circular(10),
      onTap: apagar,
      onLongPress: limpar,
      child: const Center(
        child: Icon(CupertinoIcons.delete_left, size: 28),
      ),
    );
  }

  Widget _teclaLimpar() {
    return InkWell(
      splashColor: Colors.green,
      highlightColor: Colors.green.withValues(alpha: 0.5),
      borderRadius: BorderRadius.circular(10),
      onTap: limpar,
      child: const Center(
        child: Icon(Icons.refresh, size: 28),
      ),
    );
  }

  void _definirParcelaPadrao() {
    if (widget.pagamentoSelecionado != 'Crédito parcelado') return;

    double total = modelPgto.valorPago;
    if (total <= 0) {
      modelPgto.valorParceladoSelecionado = "";
      return;
    }

    final fmt = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');

    final opcoes = List.generate(
      11,
          (i) => "${i + 2}x de ${fmt.format(total / (i + 2))}",
    );

    // 👇 define automaticamente a primeira opção
    modelPgto.valorParceladoSelecionado = opcoes.first;
  }

  Widget _buildParcelasDropdown() {
    double total = modelPgto.valorPago;
    List<String> opcoes = [];

    if (total > 0) {
      final fmt = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
      opcoes = List.generate(
        11,
            (i) => "${i + 2}x de ${fmt.format(total / (i + 2))}",
      );
    }

    String? valorValido = opcoes.contains(modelPgto.valorParceladoSelecionado)
        ? modelPgto.valorParceladoSelecionado
        : (opcoes.isNotEmpty ? opcoes.first : null);

    //modelPgto.parcelas = valorValido ?? '';

    return CustomDBFF(
      labelText: 'Número de Parcelas',
      prefixIcon: const Icon(Icons.list_alt),
      initialValue: valorValido,
      items: opcoes.map((e) => DropdownMenuItem(
        value: e,
        child: Text(e, style: const TextStyle(fontSize: 14)),
      )).toList(),
      onChanged: (v) {
        setState(() {
          modelPgto.valorParceladoSelecionado = v ?? '';
        });
        // IMPORTANTE: Chama notificar aqui para a tela anterior saber que a parcela mudou!
        _notificar();
      },
      suffixIcon: null,
    );
  }
}




