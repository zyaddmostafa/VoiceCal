import 'package:flutter/material.dart';
import 'macro_item.dart';

class MacronutrientsCard extends StatelessWidget {
  const MacronutrientsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Macronutrients',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF2C3E50),
          ),
        ),
        const SizedBox(height: 20),
        const Row(
          children: [
            Expanded(
              child: MacroItem(
                label: 'Protein',
                value: '78g',
                sublabel: '130g goal',
                color: Color(0xFF2196F3),
              ),
            ),
            Expanded(
              child: MacroItem(
                label: 'Carbs',
                value: '113g',
                sublabel: '260g goal',
                color: Color(0xFF4CAF50),
              ),
            ),
            Expanded(
              child: MacroItem(
                label: 'Fat',
                value: '45g',
                sublabel: '70g goal',
                color: Color(0xFFFFA726),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
