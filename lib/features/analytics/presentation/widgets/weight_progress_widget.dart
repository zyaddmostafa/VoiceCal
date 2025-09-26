import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/models/weight_entry.dart';
import '../../data/services/weight_data_processor.dart';
import 'weight_change_badge_widget.dart';
import 'weight_chart_legend_widget.dart';
import 'grouped_weight_line_chart_widget.dart';
import 'weight_summary_card_widget.dart';

class WeightProgressWidget extends StatelessWidget {
  final List<WeightEntry> weightData;
  final String selectedPeriod;

  const WeightProgressWidget({
    super.key,
    required this.weightData,
    required this.selectedPeriod,
  });

  @override
  Widget build(BuildContext context) {
    // Process weight data based on selected time period
    final groupedData = WeightDataProcessor.processWeightData(
      weightData,
      selectedPeriod,
    );

    final weights = groupedData.isNotEmpty
        ? groupedData.map((e) => e.weight).toList()
        : weightData.map((e) => e.weight).toList();

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
          GroupedWeightLineChartWidget(
            groupedData: groupedData,
            selectedPeriod: selectedPeriod,
          ),
          SizedBox(height: 16.h),
          WeightSummaryCardWidget(weightData: weightData),
        ],
      ),
    );
  }
}
