import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool noBory;
  final EdgeInsetsGeometry? padding;
  final List<Widget> children;
  final Color? color;
  final Widget? trailing;
  const InfoCard({
    super.key,
    required this.title,
    required this.icon,
    required this.children,
    this.padding,
    this.noBory = false,
    this.color,
    this.trailing,
  });

  Color dynamicBackground(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? Colors.black
        : const Color(0xFFF2F5F9);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      clipBehavior: Clip.antiAlias,
      padding: padding ?? const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF141418) : Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              //color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 10,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color ?? Theme.of(context).colorScheme.primary,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: (color ?? Theme.of(context).colorScheme.primary).withValues(alpha: 0.3),
                        blurRadius: 10,
                        spreadRadius: 1,
                        offset: const Offset(0, 0),
                      )
                    ]
                  ),
                  child: Icon(icon, color: Colors.white, size: 18),
                ),
                Expanded(
                  child: Text(
                    title,
                    textAlign: TextAlign.left,
                    softWrap: true,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      //color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                ),
                Visibility(
                  visible: trailing != null,
                  child: trailing ?? const SizedBox.shrink(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          Visibility(
            visible: noBory,
            replacement: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: dynamicBackground(context),
                borderRadius: BorderRadius.circular(23),
              ),
              child: Column(
                children: children,
              ),
            ),
            child: Column(
              children: children,
            ),
          ),
        ],
      ),
    );
  }
}
