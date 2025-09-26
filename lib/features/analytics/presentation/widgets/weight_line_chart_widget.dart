import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/models/weight_entry.dart';

class WeightLineChartWidget extends StatelessWidget {
  final List<WeightEntry> weightData;
  final double minWeight;
  final double maxWeight;

  const WeightLineChartWidget({
    super.key,
    required this.weightData,
    required this.minWeight,
    required this.maxWeight,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180.h,
      child: LineChart(
        LineChartData(
          gridData: _buildGridData(),
          titlesData: _buildTitlesData(),
          borderData: FlBorderData(show: false),
          lineBarsData: [_buildLineBarData()],
          minX: 0,
          maxX: weightData.isNotEmpty ? (weightData.length - 1).toDouble() : 0,
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
        return FlLine(color: Colors.grey[200]!, strokeWidth: 1);
      },
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
            final intValue = value.toInt();
            if (intValue % 5 == 0 && intValue < weightData.length) {
              return Text(
                '${(weightData.length - intValue).toString()}d',
                style: style,
              );
            }
            return const Text('');
          },
        ),
      ),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 45.w,
          interval: 2,
          getTitlesWidget: (double value, TitleMeta meta) {
            return Text(
              value.toInt().toString(),
              style: TextStyle(
                color: Colors.grey[600],
                fontWeight: FontWeight.w400,
                fontSize: 10.sp,
              ),
            );
          },
        ),
      ),
    );
  }

  LineChartBarData _buildLineBarData() {
    return LineChartBarData(
      spots: weightData
          .asMap()
          .entries
          .map((entry) => FlSpot(entry.key.toDouble(), entry.value.weight))
          .toList(),
      isCurved: true,
      curveSmoothness: 0.35,
      color: const Color(0xFF6366F1),
      barWidth: 3.w,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: true,
        getDotPainter: (spot, percent, barData, index) {
          return FlDotCirclePainter(
            radius: 4.r,
            color: const Color(0xFF6366F1),
            strokeWidth: 2.w,
            strokeColor: Colors.white,
          );
        },
      ),
      belowBarData: BarAreaData(
        show: true,
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFF6366F1).withOpacity(0.3),
            const Color(0xFF6366F1).withOpacity(0.05),
          ],
        ),
      ),
    );
  }
}
