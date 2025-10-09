import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_text_styles.dart';
import '../../../data/models/grouped_weight_data.dart';

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
            style: AppTextStyles.font14RegularGrey,
          ),
        ),
      );
    }

    final weights = groupedData.map((e) => e.weight).toList();
    final minWeight = weights.reduce((a, b) => a < b ? a : b) - 2;
    final maxWeight = weights.reduce((a, b) => a > b ? a : b) + 2;

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
          lineTouchData: _buildLineTouchData(),
        ),
      ),
    );
  }

  LineTouchData _buildLineTouchData() {
    return LineTouchData(
      touchTooltipData: LineTouchTooltipData(
        getTooltipColor: (touchedSpot) => Colors.black.withValues(alpha: 0.8),
        tooltipPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        getTooltipItems: (touchedSpots) {
          return touchedSpots
              .map((spot) {
                final index = spot.x.toInt();
                if (index >= 0 && index < groupedData.length) {
                  final dataPoint = groupedData[index];

                  return LineTooltipItem(
                    '${dataPoint.label}\n${dataPoint.weight.toStringAsFixed(1)} kg',
                    AppTextStyles.font12MediumWhite,
                  );
                }

                return null;
              })
              .whereType<LineTooltipItem>()
              .toList();
        },
      ),
      handleBuiltInTouches: true,
    );
  }

  FlGridData _buildGridData() {
    return FlGridData(
      show: true,
      drawVerticalLine: false,
      horizontalInterval: 1,
      getDrawingHorizontalLine: (value) {
        return FlLine(
          color: Colors.black.withValues(alpha: 0.1),
          strokeWidth: 1,
        );
      },
    );
  }

  FlTitlesData _buildTitlesData() {
    final labelInterval = _calculateLabelInterval();

    return FlTitlesData(
      show: true,
      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 35.h,
          interval: labelInterval,
          getTitlesWidget: (double value, TitleMeta meta) {
            if (value % labelInterval != 0) return const SizedBox.shrink();

            final style = AppTextStyles.font10MediumBlack70;

            final index = value.toInt();
            if (index >= 0 && index < groupedData.length) {
              final label = _formatLabelForPeriod(groupedData[index].label);

              return Padding(
                padding: EdgeInsets.only(top: 8.h),
                child: Text(
                  label,
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

  double _calculateLabelInterval() {
    final dataLength = groupedData.length;

    switch (selectedPeriod) {
      case '7 Days':
        return 1.0; // Show every day
      case '90 Days':
        return dataLength > 12
            ? (dataLength / 6).roundToDouble()
            : 2.0; // Show ~6 labels
      case '6 Months':
        return dataLength > 6
            ? (dataLength / 3).roundToDouble()
            : 2.0; // Show ~3 labels
      case '1 Year':
        return dataLength > 4
            ? (dataLength / 4).roundToDouble()
            : 1.0; // Show ~4 labels (quarters)
      case 'All time':
        return dataLength > 8
            ? (dataLength / 8).roundToDouble()
            : 1.0; // Show ~8 labels max
      default:
        return dataLength > 5
            ? (dataLength / 5).roundToDouble()
            : 1.0; // Default to ~5 labels
    }
  }

  String _formatLabelForPeriod(String originalLabel) {
    if (originalLabel.contains(' ')) {
      return originalLabel.split(' ')[0];
    }

    switch (selectedPeriod) {
      case '7 Days':
        return originalLabel;
      case '90 Days':
        return originalLabel;
      case '6 Months':
      case '1 Year':
        return originalLabel;
      case 'All time':
        if (originalLabel.length > 6) {
          return '${originalLabel.substring(0, 6)}..';
        }

        return originalLabel;
      default:
        return originalLabel;
    }
  }

  LineChartBarData _buildLineBarData() {
    return LineChartBarData(
      spots: groupedData.asMap().entries.map((entry) {
        return FlSpot(entry.key.toDouble(), entry.value.weight);
      }).toList(),
      isCurved: true,
      gradient: LinearGradient(
        colors: [Colors.black.withValues(alpha: 0.8), Colors.black],
      ),
      barWidth: 3.w,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: true,
        getDotPainter: (spot, percent, barData, index) {
          return FlDotCirclePainter(
            radius: 4.r,
            color: Colors.black,
            strokeWidth: 2.w,
            strokeColor: Colors.white,
          );
        },
      ),
      belowBarData: BarAreaData(
        show: true,
        gradient: LinearGradient(
          colors: [
            Colors.black.withValues(alpha: 0.1),
            Colors.black.withValues(alpha: 0.05),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }
}
