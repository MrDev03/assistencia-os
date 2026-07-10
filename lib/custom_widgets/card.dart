import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final Color? color;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;
  final double elevation;
  final Offset offset;
  final Color? borderColor;
  final Clip? clipBehavior;
  final VoidCallback? onTap;
  final double? width;

  const CustomCard({
    super.key,
    required this.child,
    this.color,
    this.margin,
    this.padding,
    this.borderRadius = 30,
    this.elevation = 0,
    this.offset = const Offset(0, 0),
    this.borderColor,
    this.clipBehavior,
    this.onTap,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final backgroundColor = color ??
        (Theme.of(context).brightness == Brightness.dark
            ? const Color(0xFF141418)//Theme.of(context).colorScheme.surfaceContainer
            : Colors.white);

    return Container(
      margin: margin,
      width: width,
      child: Material(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        clipBehavior: clipBehavior ?? Clip.antiAlias,
        elevation: elevation,
        child: InkWell(
          borderRadius: BorderRadius.circular(borderRadius),
          onTap: onTap,
          child: Padding(
            padding: padding ?? EdgeInsets.zero,
            child: child,
          ),
        ),
      ),
    );
  }
}
