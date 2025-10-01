import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/helpers/spacing.dart';
import '../../data/models/weight_entry.dart';
import '../../data/models/daily_nutrition.dart';
import 'weight/weight_section_widget.dart';
import 'nutrition/nutrition_section_widget.dart';

class AnalyticsCombinedCardWidget extends StatelessWidget {
  final List<WeightEntry> weightData;
  final List<DailyNutrition> nutritionData;
  final String selectedPeriod;

  const AnalyticsCombinedCardWidget({
    super.key,
    required this.weightData,
    required this.nutritionData,
    required this.selectedPeriod,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          WeightSectionWidget(
            weightData: weightData,
            selectedPeriod: selectedPeriod,
          ),

          Divider(height: 8.h, color: Colors.grey),

          verticalSpace(16),

          NutritionSectionWidget(nutritionData: nutritionData),
        ],
      ),
    );
  }
}
