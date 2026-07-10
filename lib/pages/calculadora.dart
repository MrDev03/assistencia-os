import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

void showCalculatorModal(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => const CalculatorModal(),
  );
}

class CalculatorModal extends StatefulWidget {
  const CalculatorModal({super.key});

  @override
  State<CalculatorModal> createState() => _CalculatorModalState();
}

class _CalculatorModalState extends State<CalculatorModal> {
  // --- ESTADO ---
  String _currentBuffer = "0"; // O número sendo digitado agora (raw: "1234.5")
  final List<String> _history = []; // Guarda a expressão: ["1000", "+", "200", "*"]
  bool _shouldResetBuffer = false; // Flag para limpar o buffer ao digitar novo número

  // Formatador apenas para casas de milhar
  final _formatter = NumberFormat("#,###", "pt_BR");

  // --- LÓGICA DE FORMATAÇÃO VISUAL ---
  // Transforma "1234.5" em "1.234,5"
  String _formatVisual(String rawValue) {
    if (rawValue.isEmpty) return "";
    if (rawValue == "-") return "-"; // Caso esteja digitando número negativo

    List<String> parts = rawValue.split('.');
    String integerPart = parts[0];

    // Formata a parte inteira
    String formattedInt = integerPart;
    if (integerPart.isNotEmpty && integerPart != "-") {
      try {
        formattedInt = _formatter.format(int.parse(integerPart));
      } catch (e) {
        // Fallback em caso de erro
      }
    }

    // Se tiver parte decimal
    if (parts.length > 1) {
      return "$formattedInt,${parts[1]}";
    }
    // Se o usuário digitou o ponto (que vira vírgula) mas ainda não tem decimais
    else if (rawValue.endsWith('.')) {
      return "$formattedInt,";
    }

    return formattedInt;
  }

  // Gera a string completa da conta para exibir (ex: "1.000 + 200")
  String get _fullExpressionVisual {
    String visual = "";
    for (var item in _history) {
      if (["+", "-", "x", "÷"].contains(item)) {
        visual += " $item ";
      } else {
        visual += _formatVisual(item);
      }
    }
    return visual;
  }

  // --- LÓGICA DE CÁLCULO ---
  double _calculateTotal() {
    // Cria uma lista temporária com histórico + buffer atual
    List<String> calcList = List.from(_history);
    if (_currentBuffer.isNotEmpty) {
      calcList.add(_currentBuffer);
    }

    if (calcList.isEmpty) return 0.0;

    // Se o último item for operador, remove para não quebrar
    if (["+", "-", "x", "÷"].contains(calcList.last)) {
      calcList.removeLast();
    }

    // Passo 1: Resolver Multiplicação e Divisão (Precedência)
    for (int i = 0; i < calcList.length; i++) {
      if (calcList[i] == 'x' || calcList[i] == '÷') {
        double val1 = double.parse(calcList[i - 1]);
        double val2 = double.parse(calcList[i + 1]);
        double res = calcList[i] == 'x' ? val1 * val2 : val1 / val2;

        calcList[i - 1] = res.toString();
        calcList.removeAt(i); // Remove operador
        calcList.removeAt(i); // Remove segundo número
        i--; // Ajusta índice
      }
    }

    // Passo 2: Resolver Soma e Subtração
    double total = double.parse(calcList[0]);
    for (int i = 1; i < calcList.length; i += 2) {
      String op = calcList[i];
      double val = double.parse(calcList[i + 1]);

      if (op == '+') total += val;
      if (op == '-') total -= val;
    }

    return total;
  }

  // --- INTERAÇÕES ---
  void _onNumberPress(String num) {
    setState(() {
      if (_shouldResetBuffer) {
        _currentBuffer = "0";
        _shouldResetBuffer = false;
      }

      if (num == ',') {
        if (!_currentBuffer.contains('.')) {
          // Se for a primeira vírgula, adiciona ponto interno
          _currentBuffer += ".";
        }
      } else {
        if (_currentBuffer == "0") {
          _currentBuffer = num;
        } else {
          _currentBuffer += num;
        }
      }
    });
  }

  void _onOperatorPress(String op) {
    setState(() {
      if (_currentBuffer.isNotEmpty) {
        _history.add(_currentBuffer);
        _history.add(op);
        _currentBuffer = "0"; // Reseta visual para zero aguardando próximo
        _shouldResetBuffer = true;
      } else if (_history.isNotEmpty && ["+", "-", "x", "÷"].contains(_history.last)) {
        // Se já tem operador e apertou outro, troca o operador
        _history.last = op;
      }
    });
  }

  void _onPercentagePress() {
    setState(() {
      if (_history.isEmpty) return;

      double currentVal = double.tryParse(_currentBuffer) ?? 0.0;

      // Lógica:
      // Se for "100 + 10%", calcula 10% de 100 (que é 10)
      // Se for "100 x 10%", calcula 0.10

      String lastOp = _history.last;

      if (lastOp == "+" || lastOp == "-") {
        // Pega o acumulado até agora pra saber a base da porcentagem
        // Simplificação: Pega o número imediatamente anterior
        double base = double.parse(_history[_history.length - 2]);
        double result = base * (currentVal / 100);
        _currentBuffer = result.toString();
      } else {
        // Apenas converte para decimal (ex: 50 * 10% -> 50 * 0.1)
        _currentBuffer = (currentVal / 100).toString();
      }
    });
  }

  void _onClear() {
    setState(() {
      _currentBuffer = "0";
      _history.clear();
    });
  }

  void _onBackspace() {
    setState(() {
      if (_currentBuffer.length > 1) {
        _currentBuffer = _currentBuffer.substring(0, _currentBuffer.length - 1);
      } else {
        _currentBuffer = "0";
      }
    });
  }

  void _copyResult() {
    double total = _calculateTotal();
    String formatted = NumberFormat.currency(locale: 'pt_BR', symbol: '').format(total).trim();

    Clipboard.setData(ClipboardData(text: formatted));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Resultado copiado!"), duration: Duration(milliseconds: 1500)),
    );
    //Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Calcula valores
    double currentTotal = _calculateTotal();
    String displayTotal = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$').format(currentTotal);

    return LayoutBuilder(
      builder: (context, constraints) {
        // 📐 DETECÇÃO DE LAYOUT
        // Se a altura for menor que 500px, consideramos "muito baixa" -> Modo Lado a Lado
        final bool isLandscapeMode = constraints.maxHeight < 500;
        final bool isDesktop = constraints.maxWidth > 500;

        final backgroundModal = (isDark ? Theme.of(context).colorScheme.surfaceContainer : Colors.white);

        // --- WIDGET 1: VISOR (Definido como variável para reutilizar) ---
        Widget visorSection = Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          alignment: isLandscapeMode || isDesktop ? Alignment.centerRight : Alignment.bottomRight, // Ajusta alinhamento
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: isLandscapeMode || isDesktop ? MainAxisAlignment.center : MainAxisAlignment.end,
            children: [
              // Histórico
              Expanded(
                child: SingleChildScrollView(
                  reverse: true,
                  child: Text(
                    _fullExpressionVisual +
                        (_shouldResetBuffer && _currentBuffer == "0"
                            ? ""
                            : _formatVisual(_currentBuffer)),
                    style: TextStyle(
                      fontSize: isLandscapeMode || isDesktop ? 20 : 24,
                      color: theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.6),
                      height: 1.5,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              // Resultado
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: AutoSizeText(
                      "= $displayTotal",
                      maxLines: 1,
                      minFontSize: 12,
                      maxFontSize: isLandscapeMode || isDesktop ? 32 : 42,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 42,
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  IconButton(
                    style: IconButton.styleFrom(
                      backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.1),
                      foregroundColor: theme.colorScheme.primary,
                      visualDensity: VisualDensity.compact,
                    ),
                    onPressed: _copyResult,
                    icon: const Icon(Icons.copy, size: 20),
                  ),
                ],
              ),
            ],
          ),
        );

        // --- WIDGET 2: TECLADO (Definido como variável) ---
        Widget keyboardSection = Container(
          color: isDark ? Colors.black12 : Colors.grey.shade50,
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              _buildRow(['C', '⌫', '÷', '%'], theme),
              _buildRow(['7', '8', '9', 'x'], theme),
              _buildRow(['4', '5', '6', '-'], theme),
              _buildRow(['1', '2', '3', '+'], theme),
              _buildRow(['00', '0', ','], theme),
            ],
          ),
        );

        // --- ESTRUTURA PRINCIPAL ---
        return SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.80,
            decoration: BoxDecoration(
              color: backgroundModal,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
            ),
            child: Column(
              children: [
                // Puxador (Sempre no topo)
                Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: 12, bottom: 8),
                    width: 40,
                    height: 5,
                    decoration: BoxDecoration(
                        color: Colors.grey.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),

                // CORPO DA CALCULADORA (Troca dinâmica)
                Expanded(
                  child: isLandscapeMode || isDesktop
                  // MODO PAISAGEM (Lado a Lado)
                      ? Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Visor na Esquerda (40% da tela)
                      Expanded(
                        flex: 4,
                        child: visorSection,
                      ),
                      // Linha Vertical divisória
                      const VerticalDivider(width: 1),
                      // Teclado na Direita (60% da tela)
                      Expanded(
                        flex: 6,
                        child: keyboardSection,
                      ),
                    ],
                  )
                  // MODO RETRATO (Um em cima do outro - Padrão)
                      : Column(
                    children: [
                      Expanded(
                        flex: 2,
                        child: visorSection,
                      ),
                      const Divider(height: 1),
                      Expanded(
                        flex: 5,
                        child: keyboardSection,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildRow(List<String> keys, ThemeData theme) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: keys.map((e) {

          // LÓGICA: Se o botão for '0', ele ocupa peso 2. O resto ocupa peso 1.
          // Você pode adicionar outros botões na lista se quiser (ex: 'Enter')
          int flex = (e == '00') ? 2 : 1;

          return Expanded(
            flex: flex,
            child: _buildButton(e, theme),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildButton(String label, ThemeData theme) {
    bool isOperator = ['+', '-', 'x', '÷', '%', 'C', '⌫'].contains(label);

    // Cores
    Color textColor = theme.colorScheme.onSurface;
    if (['C', '⌫'].contains(label)) textColor = Colors.redAccent;
    if (['+', '-', 'x', '÷', '%'].contains(label)) textColor = theme.colorScheme.primary;

    return InkWell(
      onTap: () {
        if (['+', '-', 'x', '÷'].contains(label)) {
          _onOperatorPress(label);
        } else if (label == 'C') {
          _onClear();
        } else if (label == '⌫') {
          _onBackspace();
        } else if (label == '%') {
          _onPercentagePress();
        } else {
          _onNumberPress(label);
        }
      },
      child: Card(
        elevation: 0,
        color: theme.colorScheme.primary.withValues(alpha: 0.1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
        child: Center(
          child: AutoSizeText(
            label,
            maxLines: 1,
            minFontSize: 10,
            maxFontSize: 30,
            style: TextStyle(
              fontSize: 35,
              fontWeight: isOperator ? FontWeight.bold : FontWeight.w500,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}