import 'package:flutter/material.dart';

class EditGoalArgs {
  final String label; // Calories, Carbs, Protein, Fats
  final String unit; // '', 'g'
  final int value; // raw value (no separators)
  final double progress; // 0..1 for ring
  final Color ringColor;
  final IconData icon;

  const EditGoalArgs({
    required this.label,
    required this.unit,
    required this.value,
    required this.progress,
    required this.ringColor,
    required this.icon,
  });
}
