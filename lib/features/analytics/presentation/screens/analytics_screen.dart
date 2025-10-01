import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/spacing.dart';
import '../widgets/analytics_combined_card_widget.dart';
import '../widgets/shared/time_period_selector_widget.dart';
import '../widgets/shared/analytics_app_bar_widget.dart';
import '../../data/providers/analytics_data_provider.dart';
import '../../data/services/analytics_data_filter.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  String selectedPeriod = '90 Days';

  @override
  Widget build(BuildContext context) {
    // Fetch sample data (replace with real data fetching logic)
    final analyticsData = AnalyticsDataProvider.getSampleData();

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
          const AnalyticsAppBarWidget(
            progressPercent: 80.0,
            showAchievedBadge: true,
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  verticalSpace(8),

                  TimePeriodSelectorWidget(
                    selectedPeriod: selectedPeriod,
                    onPeriodChanged: (period) =>
                        setState(() => selectedPeriod = period),
                  ),
                  verticalSpace(24),

                  AnalyticsCombinedCardWidget(
                    weightData: filteredWeightData,
                    nutritionData: filteredNutritionData,
                    selectedPeriod: selectedPeriod,
                  ),
                  verticalSpace(100),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
