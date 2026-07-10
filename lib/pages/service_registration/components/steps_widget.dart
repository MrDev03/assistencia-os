import 'package:flutter/material.dart';

class StepsWidget extends StatelessWidget {
  final bool isActivated;
  final int currentStep;
  //final String status;
  final Function()? onTap;
  const StepsWidget({
    super.key,
    required this.currentStep,
    required this.isActivated,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 60,
        child: Container(
          padding: const EdgeInsets.all(5),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActivated ? theme.primary : theme.primary.withValues(alpha: 0.05),
            border: Border.all(
              color: theme.primary,
              width: 1,
            ),
          ),
          child: Text(currentStep.toString(),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: isActivated ? Colors.white : theme.primary,
            ),
          )
        ),
      ),
    );
  }
}