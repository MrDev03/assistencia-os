import 'package:flutter/material.dart';

class CustomElevatedButton extends StatefulWidget {
  final String label;
  final dynamic Function()? click;
  final Widget? icon;
  final IconAlignment? posicao;
  final double? sizeLabel;
  final Color? backgroundColor;
  final Color? borderColor;
  final EdgeInsets? padding;

  const CustomElevatedButton({
    super.key,
    required this.label,
    required this.click,
    this.icon,
    this.posicao,
    this.sizeLabel,
    this.backgroundColor,
    this.borderColor,
    this.padding,
  });

  @override
  State<CustomElevatedButton> createState() => _CustomElevatedButtonState();
}

class _CustomElevatedButtonState extends State<CustomElevatedButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        // boxShadow: [
        //   BoxShadow(
        //     color: widget.backgroundColor ?? Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
        //     blurRadius: 6,
        //     offset: const Offset(0, 0),
        //   ),
        // ],
      ),
      constraints: const BoxConstraints(
        maxWidth: 450,
        minWidth: 100,
      ),
      width: double.infinity,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          // shadowColor: Theme.of(context).colorScheme.primary,
          disabledForegroundColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
          disabledBackgroundColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
          padding: widget.padding ?? const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          backgroundColor: widget.backgroundColor ?? Theme.of(context).colorScheme.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          textStyle: TextStyle(
            fontSize: widget.sizeLabel ?? 18,
            fontWeight: FontWeight.bold,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          side: widget.borderColor != null ? BorderSide(
            color: widget.borderColor ?? Theme.of(context).colorScheme.primary,
            width: 1.5,
          ) : BorderSide.none,
        ),
        iconAlignment: widget.posicao,
        onPressed: widget.click,
        icon: widget.icon,
        label: Text(widget.label,textAlign: TextAlign.center,),
      ),
    );
  }
}
