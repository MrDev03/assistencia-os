import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class Contador extends StatefulWidget {
  final String text;
  const Contador({super.key, required this.text});

  @override
  State<Contador> createState() => _ContadorState();
}

class _ContadorState extends State<Contador> {
  @override
  Widget build(BuildContext context) {
    return Animate(
      effects: const [
        ScaleEffect()
      ],
      child: Container(
        height: 25,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        constraints: const BoxConstraints(
          minWidth: 25,
          minHeight: 25,
        ),
        alignment: Alignment.center,
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.2),
        ),
        child: Text(widget.text, style: TextStyle(
          fontSize: 12,
          color: Theme.of(context).colorScheme.onSurface,
          fontWeight: FontWeight.bold,
        ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
