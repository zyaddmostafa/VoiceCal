import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/weight_progress_widget.dart';
import '../widgets/nutrition_chart_widget.dart';
import '../widgets/time_period_selector_widget.dart';
import '../widgets/achievements_section_widget.dart';
import '../widgets/analytics_app_bar_widget.dart';
import '../../data/providers/analytics_data_provider.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  String selectedPeriod = '7 Days';

  @override
  Widget build(BuildContext context) {
    // Sample data - in real app this would come from a repository/BLoC
    final analyticsData = AnalyticsDataProvider.getSampleData();
    final sectionSpacing = SizedBox(height: 20.h);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: CustomScrollView(
        slivers: [
          // Premium Header with scroll effects
          const AnalyticsAppBarWidget(),

          // Main Content
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  SizedBox(height: 8.h),

                  // Time Period Selector
                  TimePeriodSelectorWidget(
                    selectedPeriod: selectedPeriod,
                    onPeriodChanged: (period) =>
                        setState(() => selectedPeriod = period),
                  ),
                  SizedBox(height: 24.h),

                  // Weight Progress Section
                  WeightProgressWidget(weightData: analyticsData.weightEntries),
                  sectionSpacing,

                  // Nutrition Charts
                  NutritionChartWidget(
                    nutritionData: analyticsData.dailyNutrition,
                  ),
                  sectionSpacing,

                  // Achievements Section
                  const AchievementsSectionWidget(),
                  SizedBox(height: 100.h), // Bottom padding for navigation
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
