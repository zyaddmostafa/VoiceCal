import 'package:flutter/material.dart';
import '../../../../core/helpers/spacing.dart';
import 'macro_card.dart';

class MacrosRow extends StatelessWidget {
  final String protein;
  final String carbs;
  final String fats;

  const MacrosRow({
    super.key,
    required this.protein,
    required this.carbs,
    required this.fats,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: MacroCard(
            label: 'Protein',
            value: protein,
            emoji: '🥩',
            color: const Color(0xFFFF6B6B),
          ),
        ),
        horizontalSpace(12),
        Expanded(
          child: MacroCard(
            label: 'Carbs',
            value: carbs,
            emoji: '🍚',
            color: const Color(0xFFFFA726),
          ),
        ),
        horizontalSpace(12),
        Expanded(
          child: MacroCard(
            label: 'Fats',
            value: fats,
            emoji: '🧈',
            color: const Color(0xFF42A5F5),
          ),
        ),
      ],
    );
  }
}
