import 'package:flutter/material.dart';

import '../../../data/models/calories_and_macros_model.dart';
import 'macro_card.dart';

class RecommendedDailyCaloriesScreenBody extends StatelessWidget {
  final CaloriesAndMacrosModel recommendedDailyCalories;
  final Function(CaloriesAndMacrosModel)? onUpdate;

  const RecommendedDailyCaloriesScreenBody({
    super.key,
    required this.recommendedDailyCalories,
    this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.8,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          MacroCard(
            icon: Icons.local_fire_department,
            label: 'Calories',
            value: '${recommendedDailyCalories.calories?.toInt() ?? 0} ',
            progress: 0.5,
            progressColor: const Color(0xFF1D1D1F),
            caloriesAndMacros: recommendedDailyCalories,
            onUpdate: onUpdate,
          ),
          MacroCard(
            icon: Icons.grain,
            label: 'Carbs',
            value: '${recommendedDailyCalories.carbs?.toInt() ?? 0} g',
            progress: 0.5,
            progressColor: const Color(0xFFFF9500),
            caloriesAndMacros: recommendedDailyCalories,
            onUpdate: onUpdate,
          ),
          MacroCard(
            icon: Icons.restaurant,
            label: 'Protein',
            value: '${recommendedDailyCalories.protein?.toInt() ?? 0} g',
            progress: 0.5,
            progressColor: const Color(0xFFFF3B30),
            caloriesAndMacros: recommendedDailyCalories,
            onUpdate: onUpdate,
          ),
          MacroCard(
            icon: Icons.opacity,
            label: 'Fats',
            value: '${recommendedDailyCalories.fats?.toInt() ?? 0} g',
            progress: 0.5,
            progressColor: const Color(0xFF007AFF),
            caloriesAndMacros: recommendedDailyCalories,
            onUpdate: onUpdate,
          ),
        ],
      ),
    );
  }
}
