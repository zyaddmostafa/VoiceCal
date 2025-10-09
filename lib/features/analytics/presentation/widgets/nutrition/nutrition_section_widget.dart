import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../data/models/daily_nutrition.dart';
import '../../../data/services/nutrition_data_processor.dart';
import 'nutrition_bar_chart_widget.dart';
import 'nutrition_legend_widget.dart';
import 'nutrition_summary_widget.dart';
import 'sub_period_selector_widget.dart';

class NutritionSectionWidget extends StatefulWidget {
  final List<DailyNutrition> nutritionData;

  const NutritionSectionWidget({super.key, required this.nutritionData});

  @override
  State<NutritionSectionWidget> createState() => _NutritionSectionWidgetState();
}

class _NutritionSectionWidgetState extends State<NutritionSectionWidget> {
  static const _subPeriods = ['1 Week', '2 Weeks', '3 Weeks', '1 Month'];
  String _selectedSubPeriod = '1 Week';

  @override
  Widget build(BuildContext context) {
    if (widget.nutritionData.isEmpty) {
      return Container(
        height: 200.h,
        alignment: Alignment.center,
        child: Text(
          'No nutrition data available',
          style: AppTextStyles.font14RegularGrey,
        ),
      );
    }

    // Process nutrition data based on selected sub-period
    final groupedData =
        (_selectedSubPeriod == '3 Weeks' || _selectedSubPeriod == '1 Month')
        ? NutritionDataProcessor.groupByWeeks(
            widget.nutritionData,
            _selectedSubPeriod,
          )
        : NutritionDataProcessor.groupByLastNDays(
            widget.nutritionData,
            _getDaysForPeriod(_selectedSubPeriod),
          );

    final totalCalories = NutritionDataProcessor.calculateTotalCalories(
      widget.nutritionData,
    );
    final dailyAvg = NutritionDataProcessor.calculateDailyAverageCalories(
      widget.nutritionData,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Nutrition Breakdown', style: AppTextStyles.font16SemiBoldBlack87),
        verticalSpace(16),
        SubPeriodSelectorWidget(
          periods: _subPeriods,
          selectedPeriod: _selectedSubPeriod,
          onPeriodSelected: (period) {
            setState(() => _selectedSubPeriod = period);
          },
        ),
        verticalSpace(16),
        NutritionSummaryWidget(
          dailyAverage: dailyAvg,
          totalCalories: totalCalories,
        ),
        verticalSpace(16),
        SizedBox(
          height: 200.h,
          child: NutritionBarChartWidget(
            groupedData: groupedData,
            selectedPeriod: _selectedSubPeriod,
          ),
        ),
        verticalSpace(8),
        const NutritionLegendWidget(),
      ],
    );
  }

  int _getDaysForPeriod(String period) {
    switch (period) {
      case '1 Week':
        return 7;
      case '2 Weeks':
        return 14;
      case '3 Weeks':
        return 21;
      case '1 Month':
        return 30;
      default:
        return 7;
    }
  }
}
