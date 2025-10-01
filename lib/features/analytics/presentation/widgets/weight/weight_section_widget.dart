import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../data/models/weight_entry.dart';
import '../../../data/services/weight_data_processor.dart';
import 'grouped_weight_line_chart_widget.dart';

class WeightSectionWidget extends StatelessWidget {
  final List<WeightEntry> weightData;
  final String selectedPeriod;

  const WeightSectionWidget({
    super.key,
    required this.weightData,
    required this.selectedPeriod,
  });

  @override
  Widget build(BuildContext context) {
    final filteredWeightData = _filterWeightDataByPeriod(
      weightData,
      selectedPeriod,
    );

    final groupedWeight = WeightDataProcessor.processWeightData(
      filteredWeightData,
      selectedPeriod,
    );

    final weights = groupedWeight.isNotEmpty
        ? groupedWeight.map((e) => e.weight).toList()
        : weightData.map((e) => e.weight).toList();

    if (weightData.isEmpty) {
      return Container(
        height: 120.h,
        alignment: Alignment.center,
        child: Text(
          'No weight data available',
          style: AppTextStyles.font14RegularGrey,
        ),
      );
    }

    if (weights.isEmpty) {
      return Container(
        height: 120.h,
        alignment: Alignment.center,
        child: Text(
          'No weight data available',
          style: AppTextStyles.font14RegularGrey,
        ),
      );
    }

    return Column(
      children: [
        Row(
          children: [
            Text('Weight Progress', style: AppTextStyles.font16SemiBoldBlack87),
          ],
        ),

        GroupedWeightLineChartWidget(
          groupedData: groupedWeight,
          selectedPeriod: selectedPeriod,
        ),
      ],
    );
  }

  List<WeightEntry> _filterWeightDataByPeriod(
    List<WeightEntry> data,
    String period,
  ) {
    final now = DateTime.now();
    DateTime startDate;

    switch (period) {
      case '7 Days':
        startDate = now.subtract(const Duration(days: 7));
        break;
      case '90 Days':
        startDate = now.subtract(const Duration(days: 90));
        break;
      case '6 Months':
        startDate = DateTime(now.year, now.month - 6, now.day);
        break;
      case '1 Year':
        startDate = DateTime(now.year - 1, now.month, now.day);
        break;
      case 'All time':
        return data; // Return all data
      default:
        startDate = now.subtract(
          const Duration(days: 30),
        ); // Default to 30 days
    }

    return data.where((entry) => entry.date.isAfter(startDate)).toList();
  }
}
