import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/models/grouped_weight_data.dart';

class GroupedWeightLineChartWidget extends StatelessWidget {
  final List<GroupedWeightData> groupedData;
  final String selectedPeriod;

  const GroupedWeightLineChartWidget({
    super.key,
    required this.groupedData,
    required this.selectedPeriod,
  });

  @override
  Widget build(BuildContext context) {
    if (groupedData.isEmpty) {
      return SizedBox(
        height: 150.h,
        child: Center(
          child: Text(
            'No weight data available',
            style: TextStyle(color: Colors.grey, fontSize: 14.sp),
          ),
        ),
      );
    }

    final weights = groupedData.map((e) => e.weight).toList();
    final minWeight = weights.reduce((a, b) => a < b ? a : b) - 2;
    final maxWeight = weights.reduce((a, b) => a > b ? a : b) + 2;

    // Debug labels to verify no duplicates at runtime
    // ignore: avoid_print
    print('[GroupedWeightLineChart] labels: ' +
        groupedData.map((e) => e.label).join(', '));

    return SizedBox(
      height: 150.h,
      child: LineChart(
        LineChartData(
          gridData: _buildGridData(),
          titlesData: _buildTitlesData(),
          borderData: FlBorderData(show: false),
          lineBarsData: [_buildLineBarData()],
          minX: 0,
          maxX: groupedData.isNotEmpty
              ? (groupedData.length - 1).toDouble()
              : 0,
          minY: minWeight,
          maxY: maxWeight,
        ),
      ),
    );
  }

  FlGridData _buildGridData() {
    return FlGridData(
      show: true,
      drawVerticalLine: false,
      horizontalInterval: 1,
      getDrawingHorizontalLine: (value) {
        return FlLine(color: Colors.grey[200], strokeWidth: 1);
      },
    );
  }

  FlTitlesData _buildTitlesData() {
    return FlTitlesData(
      show: true,
      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 35.h,
          interval: 1, // ensure one label per x value
          getTitlesWidget: (double value, TitleMeta meta) {
            // Only show labels for whole-number x values
            if (value % 1 != 0) return const SizedBox.shrink();
            final style = TextStyle(
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
              fontSize: 10.sp,
            );

            final index = value.toInt();
            if (index >= 0 && index < groupedData.length) {
              return Padding(
                padding: EdgeInsets.only(top: 8.h),
                child: Text(
                  groupedData[index].label,
                  style: style,
                  overflow: TextOverflow.ellipsis,
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  LineChartBarData _buildLineBarData() {
    return LineChartBarData(
      spots: groupedData.asMap().entries.map((entry) {
        return FlSpot(entry.key.toDouble(), entry.value.weight);
      }).toList(),
      isCurved: true,
      gradient: LinearGradient(
        colors: [
          const Color(0xFF8B5CF6).withOpacity(0.8),
          const Color(0xFF8B5CF6),
        ],
      ),
      barWidth: 3.w,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: true,
        getDotPainter: (spot, percent, barData, index) {
          return FlDotCirclePainter(
            radius: 4.r,
            color: const Color(0xFF8B5CF6),
            strokeWidth: 2.w,
            strokeColor: Colors.white,
          );
        },
      ),
      belowBarData: BarAreaData(
        show: true,
        gradient: LinearGradient(
          colors: [
            const Color(0xFF8B5CF6).withOpacity(0.1),
            const Color(0xFF8B5CF6).withOpacity(0.05),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }
}
