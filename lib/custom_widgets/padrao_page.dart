import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter_animate/flutter_animate.dart';

class PatternLockWidget extends StatefulWidget {
  final void Function(String?) onSalvar;
  final int gridSize;            // 3 = 3x3
  final bool confirmar;          // pede confirmação (duas vezes)
  final int minLength;           // mínimo de pontos

  const PatternLockWidget({
    super.key,
    required this.onSalvar,
    this.gridSize = 3,
    this.confirmar = true,
    this.minLength = 3,
  });

  @override
  State<PatternLockWidget> createState() => _PatternLockWidgetState();
}

class _PatternLockWidgetState extends State<PatternLockWidget> {
  final List<int> _pattern = [];
  List<int> _confirmPattern = [];
  bool _confirming = false;
  String? _mensagem;
  Offset? _pointerPos; // para a linha elástica

  void _reset() {
    setState(() {
      _pattern.clear();
      _confirmPattern = [];
      _confirming = false;
      _mensagem = null;
      _pointerPos = null;
    });
  }

  void _tentarSalvar() {
    if (_pattern.length < widget.minLength) {
      setState(() {
        _mensagem = "Use ao menos ${widget.minLength} pontos";
      });
      return;
    }

    if (widget.confirmar && !_confirming) {
      // primeira etapa concluída: pedir confirmação
      setState(() {
        _confirmPattern = List.from(_pattern);
        _pattern.clear();
        _confirming = true;
        _mensagem = "Confirme o padrão";
        _pointerPos = null;
      });
      return;
    }

    if (widget.confirmar && _confirming) {
      if (_pattern.join(',') != _confirmPattern.join(',')) {
        setState(() {
          _mensagem = "Padrões diferentes. Tente novamente.";
          _pattern.clear();
          _confirming = false;
          _pointerPos = null;
        });
        return;
      }
    }

    widget.onSalvar(_pattern.join(','));
    Navigator.of(context).pop();
  }

  // Seleciona ponto por proximidade. Também preenche pontos intermediários (linha reta/diagonal).
  void _handlePointer(Offset pos, Size canvasSize) {
    final centers = _computeCenters(canvasSize, widget.gridSize);
    final cellSize = canvasSize.width / widget.gridSize;
    final hitRadius = cellSize * 0.28; // raio de acerto confortável

    // Descobre se encostou em algum centro
    int? hitIndex;
    for (int i = 0; i < centers.length; i++) {
      if ((pos - centers[i]).distance <= hitRadius) {
        hitIndex = i;
        break;
      }
    }

    if (hitIndex == null) return;

    setState(() {
      if (_pattern.isEmpty) {
        _pattern.add(hitIndex!);
      } else if (!_pattern.contains(hitIndex)) {
        // inclui pontos intermediários se a linha passar por eles (retas/diagonais)
        final last = _pattern.last;
        final lastR = last ~/ widget.gridSize;
        final lastC = last % widget.gridSize;
        final newR  = hitIndex! ~/ widget.gridSize;
        final newC  = hitIndex % widget.gridSize;

        final dR = newR - lastR;
        final dC = newC - lastC;
        final steps = math.max(dR.abs(), dC.abs());

        // Só entra aqui se alinhar em linha/coluna/diagonal perfeitas
        if (steps > 1) {
          final stepR = dR ~/ steps;
          final stepC = dC ~/ steps;
          // verifica se é múltiplo perfeito (sem resto)
          if (dR == stepR * steps && dC == stepC * steps) {
            for (int s = 1; s < steps; s++) {
              final r = lastR + s * stepR;
              final c = lastC + s * stepC;
              final mid = r * widget.gridSize + c;
              if (!_pattern.contains(mid)) _pattern.add(mid);
            }
          }
        }

        _pattern.add(hitIndex);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      constraints: const BoxConstraints(
        maxWidth: 350
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: LayoutBuilder(
          builder: (context, constraints) {
            // área quadrada para canvas
            final side = math.min(constraints.maxWidth, 360.0);
            final canvasSize = Size.square(side);

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _mensagem ??
                      (_confirming ? "Confirme o padrão" : "Desenhe o padrão"),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                  ),
                ),
                // const SizedBox(height: 12),
                // const Text('Por segurança essa senha será automaticamente descartada após a conclusão do serviço.',
                //   textAlign: TextAlign.center,
                //   style: TextStyle(fontSize: 12, color: Colors.red),
                // ),
                const SizedBox(height: 12),

                // Canvas interativo
                SizedBox(
                  width: canvasSize.width,
                  height: canvasSize.height,
                  child: GestureDetector(
                    onPanStart: (d) {
                      setState(() => _pointerPos = d.localPosition);
                      _handlePointer(d.localPosition, canvasSize);
                    },
                    onPanUpdate: (d) {
                      setState(() => _pointerPos = d.localPosition);
                      _handlePointer(d.localPosition, canvasSize);
                    },
                    onPanEnd: (_) => setState(() => _pointerPos = null),
                    onPanCancel: () => setState(() => _pointerPos = null),
                    child: CustomPaint(
                      painter: _PatternPainter(
                        context: context,
                        gridSize: widget.gridSize,
                        pattern: _pattern,
                        pointerPos: _pointerPos,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton.icon(
                      onPressed: _reset,
                      icon: const Icon(Icons.refresh),
                      label: const Text("Limpar"),
                    ),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green.shade100,
                        foregroundColor: Colors.green.shade800,
                      ),
                      onPressed: _pattern.isNotEmpty ? _tentarSalvar : null,
                      icon: const Icon(Icons.check),
                      label: Text(_confirming ? "Salvar" : "Confirmar"),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    ).animate().fade(delay: 150.ms).scale(curve: Curves.easeOutBack);
  }

  // Calcula centros dos pontos
  List<Offset> _computeCenters(Size size, int gridSize) {
    final cell = size.width / gridSize;
    final centers = <Offset>[];
    for (int r = 0; r < gridSize; r++) {
      for (int c = 0; c < gridSize; c++) {
        centers.add(Offset(
          c * cell + cell / 2,
          r * cell + cell / 2,
        ));
      }
    }
    return centers;
  }
}

class _PatternPainter extends CustomPainter {
  final int gridSize;
  final List<int> pattern;
  final Offset? pointerPos;
  final BuildContext context;

  _PatternPainter({
    required this.gridSize,
    required this.pattern,
    required this.pointerPos,
    required this.context,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final cell = size.width / gridSize;
    final rDot = cell * 0.18;
    final rSel = cell * 0.22;

    final paintDot = Paint()
      ..color = const Color(0xFFBDBDBD) // cinza
      ..style = PaintingStyle.fill;

    final paintSel = Paint()
      ..color = Theme.of(context).colorScheme.primary // azul selecionado
      ..style = PaintingStyle.fill;

    final paintLine = Paint()
      ..color = Theme.of(context).colorScheme.primary.withValues(alpha: 0.5) //const Color(0xFF1976D2)
      ..strokeWidth = cell * 0.08
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    // centros
    final centers = <Offset>[];
    for (int r = 0; r < gridSize; r++) {
      for (int c = 0; c < gridSize; c++) {
        centers.add(Offset(
          c * cell + cell / 2,
          r * cell + cell / 2,
        ));
      }
    }

    // linhas entre pontos selecionados
    for (int i = 0; i < pattern.length - 1; i++) {
      final a = centers[pattern[i]];
      final b = centers[pattern[i + 1]];
      canvas.drawLine(a, b, paintLine);
    }

    // linha elástica até o ponteiro
    if (pointerPos != null && pattern.isNotEmpty) {
      final lastCenter = centers[pattern.last];
      canvas.drawLine(lastCenter, pointerPos!, paintLine..color = paintLine.color.withOpacity(0.6));
    }

    // pontos
    for (int i = 0; i < centers.length; i++) {
      final isSel = pattern.contains(i);
      canvas.drawCircle(centers[i], isSel ? rSel : rDot, isSel ? paintSel : paintDot);
    }
  }

  @override
  bool shouldRepaint(covariant _PatternPainter old) {
    return old.pattern != pattern || old.pointerPos != pointerPos || old.gridSize != gridSize;
  }
}
