import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'nutrition_bar_chart_widget.dart';
import 'nutrition_chart_header_widget.dart';
import 'nutrition_legend_widget.dart';
import '../../data/models/daily_nutrition.dart';
import '../../data/services/nutrition_data_processor.dart';

class NutritionChartWidget extends StatelessWidget {
  final List<DailyNutrition> nutritionData;
  final String selectedPeriod;

  const NutritionChartWidget({
    super.key,
    required this.nutritionData,
    required this.selectedPeriod,
  });

  @override
  Widget build(BuildContext context) {
    final groupedData = NutritionDataProcessor.processNutritionData(
      nutritionData,
      selectedPeriod,
    );
    final verticalSpacing = SizedBox(height: 16.h);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const NutritionChartHeaderWidget(),
          verticalSpacing,
          SizedBox(
            height: 200.h,
            child: NutritionBarChartWidget(
              groupedData: groupedData,
              selectedPeriod: selectedPeriod,
            ),
          ),
          verticalSpacing,
          const NutritionLegendWidget(),
        ],
      ),
    );
  }
}
