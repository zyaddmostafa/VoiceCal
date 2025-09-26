import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/models/grouped_nutrition_data.dart';

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
          style: TextStyle(color: Colors.grey, fontSize: 14.sp),
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

          final nutrition = widget.groupedData[groupIndex];
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
          reservedSize: 35.h,
          interval: 1,
          getTitlesWidget: (double value, TitleMeta meta) {
            if (value % 1 != 0) return const SizedBox.shrink();
            final style = TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w400,
              fontSize: 10.sp,
            );

            final index = value.toInt();
            if (index >= 0 && index < widget.groupedData.length) {
              return Padding(
                padding: EdgeInsets.only(top: 8.h),
                child: Text(widget.groupedData[index].label, style: style),
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
      final max = [
        data.protein,
        data.carbs,
        data.fats,
      ].reduce((a, b) => a > b ? a : b);
      if (max > maxValue) maxValue = max;
    }

    // Add 20% padding to the max value
    return (maxValue * 1.2).ceilToDouble();
  }

  List<BarChartGroupData> _buildBarGroups() {
    return widget.groupedData.asMap().entries.map((entry) {
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
