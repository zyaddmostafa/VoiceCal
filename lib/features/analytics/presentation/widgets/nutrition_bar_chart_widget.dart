import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/models/daily_nutrition.dart';

class NutritionBarChartWidget extends StatefulWidget {
  final List<DailyNutrition> nutritionData;

  const NutritionBarChartWidget({super.key, required this.nutritionData});

  @override
  State<NutritionBarChartWidget> createState() =>
      _NutritionBarChartWidgetState();
}

class _NutritionBarChartWidgetState extends State<NutritionBarChartWidget> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceEvenly,
        maxY: 100,
        barTouchData: _buildBarTouchData(),
        titlesData: _buildTitlesData(),
        borderData: FlBorderData(show: false),
        barGroups: _buildBarGroups(),
        gridData: _buildGridData(),
      ),
    );
  }

  BarTouchData _buildBarTouchData() {
    return BarTouchData(
      touchCallback: (FlTouchEvent event, barTouchResponse) {
        setState(() {
          if (!event.isInterestedForInteractions ||
              barTouchResponse == null ||
              barTouchResponse.spot == null) {
            touchedIndex = -1;
            return;
          }
          touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
        });
      },
      touchTooltipData: BarTouchTooltipData(
        getTooltipColor: (_) => Colors.black87,
        getTooltipItem: (group, groupIndex, rod, rodIndex) {
          final nutrition = widget.nutritionData[groupIndex];
          final labels = ['Protein', 'Carbs', 'Fats'];
          final values = [nutrition.protein, nutrition.carbs, nutrition.fats];
          return BarTooltipItem(
            '${labels[rodIndex]}\n${values[rodIndex].toStringAsFixed(1)}g',
            const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          );
        },
      ),
    );
  }

  FlTitlesData _buildTitlesData() {
    return FlTitlesData(
      show: true,
      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 30.h,
          getTitlesWidget: (double value, TitleMeta meta) {
            const style = TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w400,
              fontSize: 10,
            );
            return Text('Day ${value.toInt() + 1}', style: style);
          },
        ),
      ),
      leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
    );
  }

  FlGridData _buildGridData() {
    return FlGridData(
      show: true,
      drawVerticalLine: false,
      horizontalInterval: 25,
      getDrawingHorizontalLine: (value) {
        return FlLine(color: Colors.grey[200]!, strokeWidth: 1);
      },
    );
  }

  List<BarChartGroupData> _buildBarGroups() {
    return widget.nutritionData.asMap().entries.map((entry) {
      final index = entry.key;
      final nutrition = entry.value;

      return BarChartGroupData(
        x: index,
        barRods: [
          _buildBarRod(nutrition.protein, const Color(0xFFFF6B6B)),
          _buildBarRod(nutrition.carbs, const Color(0xFF4ECDC4)),
          _buildBarRod(nutrition.fats, const Color(0xFFFFBE0B)),
        ],
        barsSpace: 2.w,
      );
    }).toList();
  }

  BarChartRodData _buildBarRod(double value, Color color) {
    final topRadius = Radius.circular(4.r);
    return BarChartRodData(
      toY: value,
      color: color,
      width: 8.w,
      borderRadius: BorderRadius.only(topLeft: topRadius, topRight: topRadius),
    );
  }
}
