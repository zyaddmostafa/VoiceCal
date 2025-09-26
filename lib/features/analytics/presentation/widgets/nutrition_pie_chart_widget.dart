import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/models/daily_nutrition.dart';

class NutritionPieChartWidget extends StatefulWidget {
  final List<DailyNutrition> nutritionData;

  const NutritionPieChartWidget({super.key, required this.nutritionData});

  @override
  State<NutritionPieChartWidget> createState() =>
      _NutritionPieChartWidgetState();
}

class _NutritionPieChartWidgetState extends State<NutritionPieChartWidget> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    if (widget.nutritionData.isEmpty) return const SizedBox.shrink();

    final totalNutrition = _calculateTotalNutrition();
    final total =
        totalNutrition.protein + totalNutrition.carbs + totalNutrition.fats;

    return PieChart(
      PieChartData(
        pieTouchData: _buildPieTouchData(),
        borderData: FlBorderData(show: false),
        sectionsSpace: 2,
        centerSpaceRadius: 50.r,
        sections: _buildPieSections(totalNutrition, total),
      ),
    );
  }

  DailyNutrition _calculateTotalNutrition() {
    return widget.nutritionData.fold<DailyNutrition>(
      DailyNutrition(date: DateTime.now(), protein: 0, carbs: 0, fats: 0),
      (prev, current) => DailyNutrition(
        date: DateTime.now(),
        protein: prev.protein + current.protein,
        carbs: prev.carbs + current.carbs,
        fats: prev.fats + current.fats,
      ),
    );
  }

  PieTouchData _buildPieTouchData() {
    return PieTouchData(
      touchCallback: (FlTouchEvent event, pieTouchResponse) {
        setState(() {
          if (!event.isInterestedForInteractions ||
              pieTouchResponse == null ||
              pieTouchResponse.touchedSection == null) {
            touchedIndex = -1;
            return;
          }
          touchedIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;
        });
      },
    );
  }

  List<PieChartSectionData> _buildPieSections(
    DailyNutrition totalNutrition,
    double total,
  ) {
    return [
      _buildPieSection(
        totalNutrition.protein,
        total,
        const Color(0xFFFF6B6B),
        0,
      ),
      _buildPieSection(totalNutrition.carbs, total, const Color(0xFF4ECDC4), 1),
      _buildPieSection(totalNutrition.fats, total, const Color(0xFFFFBE0B), 2),
    ];
  }

  PieChartSectionData _buildPieSection(
    double value,
    double total,
    Color color,
    int index,
  ) {
    final isSelected = touchedIndex == index;
    return PieChartSectionData(
      color: color,
      value: value,
      title: '${(value / total * 100).toStringAsFixed(1)}%',
      radius: isSelected ? 80.r : 70.r,
      titleStyle: TextStyle(
        fontSize: isSelected ? 14.sp : 12.sp,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }
}
