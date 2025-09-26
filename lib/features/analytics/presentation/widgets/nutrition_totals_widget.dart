import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/models/daily_nutrition.dart';

class NutritionTotalsWidget extends StatelessWidget {
  final List<DailyNutrition> nutritionData;

  const NutritionTotalsWidget({super.key, required this.nutritionData});

  @override
  Widget build(BuildContext context) {
    if (nutritionData.isEmpty) return const SizedBox.shrink();

    final totalNutrition = _calculateTotalNutrition();

    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF8B5CF6).withOpacity(0.1),
            const Color(0xFF6366F1).withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          _NutrientColumn(
            label: 'Total Protein',
            value: '${totalNutrition.protein.toStringAsFixed(1)}g',
            color: const Color(0xFFFF6B6B),
          ),
          const _NutrientDivider(),
          _NutrientColumn(
            label: 'Total Carbs',
            value: '${totalNutrition.carbs.toStringAsFixed(1)}g',
            color: const Color(0xFF4ECDC4),
          ),
          const _NutrientDivider(),
          _NutrientColumn(
            label: 'Total Fats',
            value: '${totalNutrition.fats.toStringAsFixed(1)}g',
            color: const Color(0xFFFFBE0B),
          ),
        ],
      ),
    );
  }

  DailyNutrition _calculateTotalNutrition() {
    return nutritionData.fold<DailyNutrition>(
      DailyNutrition(date: DateTime.now(), protein: 0, carbs: 0, fats: 0),
      (prev, current) => DailyNutrition(
        date: DateTime.now(),
        protein: prev.protein + current.protein,
        carbs: prev.carbs + current.carbs,
        fats: prev.fats + current.fats,
      ),
    );
  }
}

class _NutrientColumn extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _NutrientColumn({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 11.sp,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            value,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

class _NutrientDivider extends StatelessWidget {
  const _NutrientDivider();

  @override
  Widget build(BuildContext context) {
    return Container(width: 1, height: 40.h, color: Colors.grey[300]);
  }
}
