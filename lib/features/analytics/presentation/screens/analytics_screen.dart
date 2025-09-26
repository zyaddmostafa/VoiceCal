import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/weight_progress_widget.dart';
import '../widgets/nutrition_chart_widget.dart';
import '../widgets/time_period_selector_widget.dart';
import '../widgets/analytics_app_bar_widget.dart';
import '../../data/providers/analytics_data_provider.dart';
import '../../data/services/analytics_data_filter.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  String selectedPeriod = '7 Days';

  @override
  Widget build(BuildContext context) {
    final analyticsData = AnalyticsDataProvider.getSampleData();

    // Filter data based on selected time period
    final filteredWeightData = AnalyticsDataFilter.filterWeightData(
      analyticsData.weightEntries,
      selectedPeriod,
    );

    final filteredNutritionData = AnalyticsDataFilter.filterNutritionData(
      analyticsData.dailyNutrition,
      selectedPeriod,
    );

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const AnalyticsAppBarWidget(),

          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  SizedBox(height: 8.h),

                  TimePeriodSelectorWidget(
                    selectedPeriod: selectedPeriod,
                    onPeriodChanged: (period) =>
                        setState(() => selectedPeriod = period),
                  ),
                  SizedBox(height: 24.h),

                  WeightProgressWidget(
                    weightData: filteredWeightData,
                    selectedPeriod: selectedPeriod,
                  ),
                  SizedBox(height: 20.h),

                  NutritionChartWidget(
                    nutritionData: filteredNutritionData,
                    selectedPeriod: selectedPeriod,
                  ),
                  SizedBox(height: 100.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
