import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_text_styles.dart';
import '../../../data/models/grouped_nutrition_data.dart';

class NutritionBarChartWidget extends StatefulWidget {
  final List<GroupedNutritionData> groupedData;
  final String selectedPeriod;

  const NutritionBarChartWidget({
    super.key,
    required this.groupedData,
    required this.selectedPeriod,
  });

  @override
  State<NutritionBarChartWidget> createState() =>
      _NutritionBarChartWidgetState();
}

class _NutritionBarChartWidgetState extends State<NutritionBarChartWidget> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    if (widget.groupedData.isEmpty) {
      return Center(
        child: Text(
          'No nutrition data available',
          style: AppTextStyles.font14RegularGrey,
        ),
      );
    }

    final maxY = _calculateMaxY();

    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceEvenly,
        maxY: maxY,
        barTouchData: _buildBarTouchData(),
        titlesData: _buildTitlesData(),
        borderData: FlBorderData(show: false),
        barGroups: _buildBarGroups(),
        gridData: _buildGridData(maxY),
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
          if (groupIndex >= widget.groupedData.length) return null;

          final n = widget.groupedData[groupIndex];
          final total = n.protein + n.carbs + n.fats;
          final text =
              'P ${n.protein.toStringAsFixed(0)}g  ·  '
              'C ${n.carbs.toStringAsFixed(0)}g  ·  '
              'F ${n.fats.toStringAsFixed(0)}g\n'
              'Total ${total.toStringAsFixed(0)}g';

          return BarTooltipItem(
            text,
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
          reservedSize: 35.h,
          interval: 1,
          getTitlesWidget: (double value, TitleMeta meta) {
            if (value % 1 != 0) return const SizedBox.shrink();
            final style = AppTextStyles.font10MediumGrey;

            final index = value.toInt();
            if (index >= 0 && index < widget.groupedData.length) {
              String label = widget.groupedData[index].label;
              // Extract just the day name (e.g., "Tue" from "Tue 23")
              if (label.contains(' ')) {
                label = label.split(' ')[0];
              }

              return Padding(
                padding: EdgeInsets.only(top: 8.h),
                child: Text(label, style: style),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
      leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
    );
  }

  FlGridData _buildGridData(double maxY) {
    return FlGridData(
      show: true,
      drawVerticalLine: false,
      horizontalInterval: maxY / 4,
      getDrawingHorizontalLine: (value) {
        return FlLine(color: Colors.grey[200], strokeWidth: 1);
      },
    );
  }

  double _calculateMaxY() {
    if (widget.groupedData.isEmpty) return 100;

    double maxValue = 0;
    for (final data in widget.groupedData) {
      final total = data.protein + data.carbs + data.fats;
      if (total > maxValue) maxValue = total;
    }

    // Add 20% padding to the max value
    return (maxValue * 1.2).ceilToDouble();
  }

  List<BarChartGroupData> _buildBarGroups() {
    return widget.groupedData.asMap().entries.map((entry) {
      final index = entry.key;
      final n = entry.value;

      // Build a single stacked rod per group
      final protein = n.protein;
      final carbs = n.carbs;
      final fats = n.fats;

      final double total = protein + carbs + fats;

      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: total,
            width: 12.w,
            rodStackItems: [
              BarChartRodStackItem(0, protein, const Color(0xFFFF6B6B)),
              BarChartRodStackItem(
                protein,
                protein + carbs,
                const Color(0xFF4ECDC4),
              ),
              BarChartRodStackItem(
                protein + carbs,
                total,
                const Color(0xFFFFBE0B),
              ),
            ],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(4.r),
              topRight: Radius.circular(4.r),
            ),
          ),
        ],
        barsSpace: 2.w,
      );
    }).toList();
  }
}
