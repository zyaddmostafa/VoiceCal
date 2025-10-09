import 'package:flutter/material.dart';

/// Goal plan model for goal selection
class GoalPlanModel {
  final String id;
  final IconData icon;
  final String title;
  final String description;

  const GoalPlanModel({
    required this.id,
    required this.icon,
    required this.title,
    required this.description,
  });

  /// Static list of all goal plans
  static const List<GoalPlanModel> goals = [
    GoalPlanModel(
      id: 'lose_weight',
      icon: Icons.local_fire_department_outlined,
      title: 'Lose Weight',
      description: 'Burn fat and slim down.',
    ),
    GoalPlanModel(
      id: 'maintain_weight',
      icon: Icons.favorite_outline,
      title: 'Maintain Weight',
      description: 'Stay fit and healthy.',
    ),
    GoalPlanModel(
      id: 'gain_weight',
      icon: Icons.fitness_center_outlined,
      title: 'Gain Weight',
      description: 'Build muscle and strength.',
    ),
  ];
}
