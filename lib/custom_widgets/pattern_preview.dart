import 'package:flutter/material.dart';

class PatternPreview extends StatelessWidget {
  final List<int> pattern; // sequência de pontos salvos
  final int gridSize;

  const PatternPreview({
    super.key,
    required this.pattern,
    this.gridSize = 3, // padrão 3x3
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(150, 150),
      painter: _PatternPainter(pattern, gridSize),
    );
  }
}

class _PatternPainter extends CustomPainter {
  final List<int> pattern;
  final int gridSize;

  _PatternPainter(this.pattern, this.gridSize);

  @override
  void paint(Canvas canvas, Size size) {
    final paintCircle = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final paintActive = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    final paintLine = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    final double cellW = size.width / gridSize;
    final double cellH = size.height / gridSize;

    // coordenadas dos pontos
    final points = List.generate(gridSize * gridSize, (i) {
      int row = i ~/ gridSize;
      int col = i % gridSize;
      return Offset(
        col * cellW + cellW / 2,
        row * cellH + cellH / 2,
      );
    });

    // desenha linhas entre os pontos usados
    for (int i = 0; i < pattern.length - 1; i++) {
      canvas.drawLine(points[pattern[i]], points[pattern[i + 1]], paintLine);
    }

    // desenha os círculos
    for (int i = 0; i < points.length; i++) {
      canvas.drawCircle(points[i], 12, paintCircle);
    }

    // marca os pontos usados
    for (int i in pattern) {
      canvas.drawCircle(points[i], 10, paintActive);
    }
  }

  @override
  bool shouldRepaint(covariant _PatternPainter oldDelegate) =>
      oldDelegate.pattern != pattern;
}