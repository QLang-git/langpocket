import 'package:flutter/material.dart';

class StepMessage extends StatelessWidget {
  final String message;
  const StepMessage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final ThemeData(:colorScheme, :textTheme) = Theme.of(context);
    return Container(
        alignment: Alignment.center,
        width: double.infinity,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: colorScheme.primaryContainer,
        ),
        child: Text(
          message,
          style: textTheme.labelLarge?.copyWith(color: colorScheme.outline),
        ));
  }
}
