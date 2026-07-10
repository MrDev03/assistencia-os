import 'package:flutter/material.dart';

class PatternLockIcon extends StatelessWidget {
  final double size;
  final Color color;

  const PatternLockIcon({
    super.key,
    this.size = 48,
    this.color = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.square(size),
      painter: _PatternLockPainter(color),
    );
  }
}

class _PatternLockPainter extends CustomPainter {
  final Color color;

  _PatternLockPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final double spacing = size.width / 4; // espaçamento entre pontos
    final double radius = size.width * 0.08; // tamanho do ponto

    for (int row = 0; row < 3; row++) {
      for (int col = 0; col < 3; col++) {
        final dx = spacing * (col + 1);
        final dy = spacing * (row + 1);
        canvas.drawCircle(Offset(dx, dy), radius, paint);
      }
    }
  }

  @override
  bool shouldRepaint(_PatternLockPainter oldDelegate) => false;
}
