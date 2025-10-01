import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import 'macro_item.dart';

class MacronutrientsCard extends StatelessWidget {
  const MacronutrientsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: MacroItem(
            label: 'Protein',
            value: '78g',
            sublabel: '130g goal',
            color: Colors.red,
            progress: 0.6, // 78/130
          ),
        ),
        Expanded(
          child: MacroItem(
            label: 'Carbs',
            value: '113g',
            sublabel: '260g goal',
            color: Colors.orange,
            progress: 0.43, // 113/260
          ),
        ),
        Expanded(
          child: MacroItem(
            label: 'Fat',
            value: '45g',
            sublabel: '70g goal',
            color: Colors.blueAccent,
            progress: 0.64, // 45/70
          ),
        ),
      ],
    );
  }
}
