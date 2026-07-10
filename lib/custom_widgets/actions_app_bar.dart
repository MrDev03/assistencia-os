import 'package:flutter/material.dart';

class CustomActions extends StatefulWidget {
  final Widget child;

  const CustomActions({
    super.key,
    required this.child,
  });

  @override
  State<CustomActions> createState() => _CustomActionsState();
}

class _CustomActionsState extends State<CustomActions> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(30), bottomLeft: Radius.circular(30)),
        color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
      ),
      child: widget.child,
    );
  }
}
