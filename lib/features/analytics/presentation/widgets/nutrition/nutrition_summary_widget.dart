import 'package:flutter/material.dart';
import 'summary_item_widget.dart';

class NutritionSummaryWidget extends StatelessWidget {
  final double totalCalories;
  final double dailyAverage;

  const NutritionSummaryWidget({
    super.key,
    required this.totalCalories,
    required this.dailyAverage,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SummaryItemWidget(
          value: totalCalories.toStringAsFixed(0),
          label: 'Total calories',
        ),
        SummaryItemWidget(
          value: dailyAverage.toStringAsFixed(0),
          label: 'Daily avg.',
        ),
      ],
    );
  }
}
