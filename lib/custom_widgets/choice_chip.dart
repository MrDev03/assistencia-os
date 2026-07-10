import 'package:flutter/material.dart';

class CustomChoiceChip extends StatefulWidget {
  final String label;
  final Widget? icon;
  final bool selected;
  final ValueChanged<bool> onSelected;

  const CustomChoiceChip({
    super.key,
    required this.label,
    this.icon,
    required this.selected,
    required this.onSelected,
  });

  @override
  State<CustomChoiceChip> createState() => _CustomChoiceChipState();
}

class _CustomChoiceChipState extends State<CustomChoiceChip> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8, right: 10),
      child: ChoiceChip(
        disabledColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        avatar: widget.icon,
        labelStyle: TextStyle(
          color: widget.selected ? Colors.white : Theme.of(context).colorScheme.onSurface,
        ),
        checkmarkColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        selectedColor: Theme
            .of(context)
            .colorScheme
            .primary,
        label: Text(widget.label),
        selected: widget.selected,
        onSelected: (value) => widget.onSelected(value),
      ),
    );
  }
}
