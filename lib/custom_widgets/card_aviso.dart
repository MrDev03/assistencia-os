import 'package:flutter/material.dart';

class CardAviso extends StatelessWidget {
  final Color color;
  final String message;
  final bool showCloseButton;
  final Function()? onPressed;

  const CardAviso({
    super.key,
    this.color = Colors.blue,
    required this.message,
    this.onPressed,
    this.showCloseButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      constraints: const BoxConstraints(
        maxWidth: 500,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(45),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          const SizedBox(width: 8),
          Icon(Icons.info_outline, color: color),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(fontSize: 13),
            ),
          ),
          Visibility(
            visible: showCloseButton,
            child: IconButton(
              onPressed: onPressed,
              icon: Icon(Icons.close, color: color),
            ),
          ),
        ],
      ),
    );
  }
}
