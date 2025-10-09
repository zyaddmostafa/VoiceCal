import 'package:flutter/material.dart';
import 'legend_item.dart';

class NutritionLegendWidget extends StatelessWidget {
  const NutritionLegendWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        LegendItem(
          color: Color(0xFFFF6B6B),
          label: 'Protein',
          icon: Icons.fitness_center,
        ),
        LegendItem(color: Color(0xFF4ECDC4), label: 'Carbs', icon: Icons.grain),
        LegendItem(
          color: Color(0xFFFFBE0B),
          label: 'Fats',
          icon: Icons.water_drop,
        ),
      ],
    );
  }
}
