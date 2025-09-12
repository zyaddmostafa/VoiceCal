import 'package:flutter/material.dart';

import 'macro_card.dart';

class RecommendedDailyCaloriesScreenBody extends StatelessWidget {
  const RecommendedDailyCaloriesScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.8,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: const [
          MacroCard(
            icon: Icons.local_fire_department,
            label: 'Calories',
            value: '1712',
            progress: 0.6,
            progressColor: Color(0xFF1D1D1F),
          ),
          MacroCard(
            icon: Icons.grain,
            label: 'Carbs',
            value: '212g',
            progress: 0.7,
            progressColor: Color(0xFFFF9500),
          ),
          MacroCard(
            icon: Icons.restaurant,
            label: 'Protein',
            value: '108g',
            progress: 0.5,
            progressColor: Color(0xFFFF3B30),
          ),
          MacroCard(
            icon: Icons.opacity,
            label: 'Fats',
            value: '47g',
            progress: 0.4,
            progressColor: Color(0xFF007AFF),
          ),
        ],
      ),
    );
  }
}
