import 'package:flutter/material.dart';

/// Goal plan data for goal selection
class GoalPlanData {
  static const List<Map<String, dynamic>> goals = [
    {
      'id': 'lose_weight',
      'icon': Icons.local_fire_department_outlined,
      'title': 'Lose Weight',
      'description': 'Burn fat and slim down.',
    },
    {
      'id': 'maintain_weight',
      'icon': Icons.favorite_outline,
      'title': 'Maintain Weight',
      'description': 'Stay fit and healthy.',
    },
    {
      'id': 'gain_weight',
      'icon': Icons.fitness_center_outlined,
      'title': 'Gain Weight',
      'description': 'Build muscle and strength.',
    },
  ];
}
