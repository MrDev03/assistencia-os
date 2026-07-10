import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Vazio extends StatelessWidget {
  final String? label;
  const Vazio({
    this.label,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          key: key,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: Lottie.asset(
                'assets/images/NotFound.json',
                width: 200,
                height: 200,
              ),
            ),
            Text(label ?? "Nenhum registro encontrado",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey[500],
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      )
    );
  }
}
