import 'package:flutter/material.dart';

class SeletorMesAnoCustomizado extends StatefulWidget {
  final String? dataCadastro; // Recebe a string "DD/MM/AAAA • HH:MM"
  final Function(DateTime inicio, DateTime fim, String label) onPeriodoChanged;

  const SeletorMesAnoCustomizado({
    super.key,
    required this.dataCadastro,
    required this.onPeriodoChanged,
  });

  @override
  State<SeletorMesAnoCustomizado> createState() => _SeletorMesAnoCustomizadoState();
}

class _SeletorMesAnoCustomizadoState extends State<SeletorMesAnoCustomizado> {
  int _anoSelecionado = DateTime.now().year;
  int _mesSelecionado = DateTime.now().month;

  int _anoMinimo = DateTime.now().year;
  int _mesMinimo = 1;

  final int _anoMaximo = DateTime.now().year;
  final int _mesMaximo = DateTime.now().month;

  final List<String> _nomeMeses = [
    'Jan', 'Fev', 'Mar', 'Abr', 'Mai', 'Jun',
    'Jul', 'Ago', 'Set', 'Out', 'Nov', 'Dez'
  ];

  @override
  void initState() {
    super.initState();
    _extrairDataMinima();

    // Dispara a busca inicial para o mês atual assim que o componente é construído
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _notificarMudanca();
    });
  }

  /// 🔥 Extrai o ano e o mês da string "DD/MM/AAAA • HH:MM"
  void _extrairDataMinima() {
    if (widget.dataCadastro != null && widget.dataCadastro!.isNotEmpty) {
      try {
        final parteData = widget.dataCadastro!.split(' • ')[0]; // Pega "DD/MM/AAAA"
        final partes = parteData.split('/'); // [DD, MM, AAAA]

        if (partes.length == 3) {
          _mesMinimo = int.parse(partes[1]);
          _anoMinimo = int.parse(partes[2]);
        }
      } catch (e) {
        debugPrint('Erro ao fazer o parse da data de cadastro: $e');
      }
    }
  }

  /// Verifica se um determinado mês está bloqueado (antes da contratação ou no futuro)
  bool _isMesBloqueado(int ano, int mes) {
    if (ano == _anoMinimo && mes < _mesMinimo) return true; // Antes de entrar na empresa
    if (ano == _anoMaximo && mes > _mesMaximo) return true; // Meses que ainda não chegaram
    return false;
  }

  /// Atualiza o estado e envia as datas exatas para a tela principal
  void _notificarMudanca() {
    final inicio = DateTime(_anoSelecionado, _mesSelecionado, 1);
    final fim = DateTime(_anoSelecionado, _mesSelecionado + 1, 0); // O dia 0 traz o último dia do mês atual

    final label = '${_nomeMeses[_mesSelecionado - 1]} de $_anoSelecionado';

    widget.onPeriodoChanged(inicio, fim, label);
  }

  @override
  Widget build(BuildContext context) {
    // Calcula quantos anos exibir (do ano de cadastro até o ano atual)
    final anosDisponiveis = List.generate(
        (_anoMaximo - _anoMinimo) + 1,
            (index) => _anoMinimo + index
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ---------- SELETOR DE ANO ----------
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text('Selecione o Ano', style: _textStyleTitulo(context)),
        ),
        SizedBox(
          height: 40,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: anosDisponiveis.length,
            itemBuilder: (context, index) {
              final ano = anosDisponiveis[index];
              return _buildChip(
                context,
                texto: ano.toString(),
                isSelected: _anoSelecionado == ano,
                onTap: () {
                  setState(() {
                    _anoSelecionado = ano;
                    // Se ao trocar de ano o mês atual ficar bloqueado, corrige automaticamente
                    if (_isMesBloqueado(_anoSelecionado, _mesSelecionado)) {
                      _mesSelecionado = _anoSelecionado == _anoMinimo ? _mesMinimo : _mesMaximo;
                    }
                  });
                  _notificarMudanca();
                },
              );
            },
          ),
        ),

        const SizedBox(height: 12),

        // ---------- SELETOR DE MÊS ----------
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text('Selecione o Mês', style: _textStyleTitulo(context)),
        ),
        SizedBox(
          height: 40,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: 12,
            itemBuilder: (context, index) {
              final mes = index + 1;
              final isBloqueado = _isMesBloqueado(_anoSelecionado, mes);

              return _buildChip(
                context,
                texto: _nomeMeses[index],
                isSelected: _mesSelecionado == mes && !isBloqueado,
                isBlocked: isBloqueado,
                onTap: isBloqueado ? null : () {
                  setState(() => _mesSelecionado = mes);
                  _notificarMudanca();
                },
              );
            },
          ),
        ),
      ],
    );
  }

  TextStyle _textStyleTitulo(BuildContext context) {
    return TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.bold,
      color: Theme.of(context).colorScheme.primary,
      letterSpacing: 1.0,
    );
  }

  Widget _buildChip(BuildContext context, {
    required String texto,
    required bool isSelected,
    bool isBlocked = false,
    required VoidCallback? onTap
  }) {
    final theme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isBlocked
              ? Colors.grey.withValues(alpha: 0.2) // Cinza se bloqueado
              : isSelected
              ? theme.primary
              : theme.primary.withValues(alpha: isDark ? 0.1 : 0.05),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isBlocked
                ? Colors.transparent
                : isSelected
                ? theme.primary
                : theme.primary.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        child: Text(
          texto,
          style: TextStyle(
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
            color: isBlocked
                ? Colors.grey.withValues(alpha: 0.5)
                : isSelected
                ? Colors.white
                : theme.onSurface.withValues(alpha: 0.8),
          ),
        ),
      ),
    );
  }
}