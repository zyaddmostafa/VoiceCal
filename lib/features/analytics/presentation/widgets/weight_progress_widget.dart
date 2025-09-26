import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/models/weight_entry.dart';
import 'weight_change_badge_widget.dart';
import 'weight_chart_legend_widget.dart';
import 'weight_line_chart_widget.dart';
import 'weight_summary_card_widget.dart';

class WeightProgressWidget extends StatelessWidget {
  final List<WeightEntry> weightData;

  const WeightProgressWidget({super.key, required this.weightData});

  @override
  Widget build(BuildContext context) {
    final weights = weightData.map((e) => e.weight).toList();
    final minWeight = weights.isNotEmpty
        ? weights.reduce((a, b) => a < b ? a : b) - 2
        : 70.0;
    final maxWeight = weights.isNotEmpty
        ? weights.reduce((a, b) => a > b ? a : b) + 2
        : 80.0;

    final weightChange = weights.isNotEmpty && weights.length > 1
        ? weights.last - weights.first
        : 0.0;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Weight Progress',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              WeightChangeBadgeWidget(weightChange: weightChange),
            ],
          ),
          SizedBox(height: 12.h),
          if (weights.isNotEmpty)
            WeightChartLegendWidget(currentWeight: weights.last),
          SizedBox(height: 20.h),
          WeightLineChartWidget(
            weightData: weightData,
            minWeight: minWeight,
            maxWeight: maxWeight,
          ),
          SizedBox(height: 16.h),
          WeightSummaryCardWidget(weightData: weightData),
        ],
      ),
    );
  }
}
