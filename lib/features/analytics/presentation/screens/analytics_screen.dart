import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/di/get_it.dart';
import '../../../../core/helpers/custom_snackbar.dart';
import '../../../../core/helpers/spacing.dart';
import '../../data/repo/analytics_repo.dart';
import '../cubit/analytics_cubit.dart';
import '../utils/analytics_skeleton_data.dart';
import '../widgets/analytics_combined_card_widget.dart';
import '../widgets/shared/time_period_selector_widget.dart';
import '../widgets/shared/analytics_app_bar_widget.dart';
import '../widgets/shared/analytics_empty_state_widget.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AnalyticsCubit(analyticsRepo: getIt<AnalyticsRepo>()),
      child: const _AnalyticsScreenContent(),
    );
  }
}

class _AnalyticsScreenContent extends StatefulWidget {
  const _AnalyticsScreenContent();

  @override
  State<_AnalyticsScreenContent> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<_AnalyticsScreenContent> {
  String selectedPeriod = '90 Days';

  @override
  void initState() {
    super.initState();
    _loadAnalyticsData();
  }

  void _loadAnalyticsData() {
    final userId = Supabase.instance.client.auth.currentUser?.id;

    // Map UI period to API period format
    final apiPeriod = _mapPeriodToApiFormat(selectedPeriod);

    context.read<AnalyticsCubit>().getAnalyticsDashboard(
      userId: userId!,
      period: apiPeriod,
    );
  }

  String _mapPeriodToApiFormat(String uiPeriod) {
    switch (uiPeriod) {
      case '7 Days':
        return '1_week';
      case '14 Days':
        return '2_weeks';
      case '30 Days':
        return '1_month';
      case '90 Days':
        return '90_days';
      case '6 Months':
        return '6_months';
      case '1 Year':
        return '1_year';
      default:
        return '90_days';
    }
  }

  bool _hasData(AnalyticsDashboardSuccess state) {
    return state.dashboard.weightProgress.entries.isNotEmpty ||
        state.dashboard.nutritionBreakdown.days.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AnalyticsCubit, AnalyticsState>(
        listener: (context, state) {
          if (state is AnalyticsError) {
            final errorMessage = state.apiErrorModel.message ?? '';
            final isEmptyDataError =
                errorMessage.contains('No data') ||
                errorMessage.contains('not found') ||
                errorMessage.isEmpty;

            if (!isEmptyDataError) {
              CustomSnackbar.showError(
                context,
                errorMessage.isNotEmpty
                    ? errorMessage
                    : 'Failed to load analytics',
              );
            }
          }
        },
        builder: (context, state) {
          return CustomScrollView(
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
                        onPeriodChanged: (period) {
                          setState(() => selectedPeriod = period);
                          _loadAnalyticsData();
                        },
                      ),
                      verticalSpace(24),

                      // Loading state with Skeletonizer
                      if (state is AnalyticsLoading)
                        _analyticsLoading()
                      // Success state with data check
                      else if (state is AnalyticsDashboardSuccess)
                        _analyticsDashboardSuccess(state)
                      // Initial or error state
                      else
                        const AnalyticsEmptyStateWidget(),
                      verticalSpace(100),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Skeletonizer _analyticsLoading() {
    return Skeletonizer(
      enabled: true,
      child: AnalyticsCombinedCardWidget(
        weightData: AnalyticsSkeletonData.getSkeletonWeightData(),
        nutritionData: AnalyticsSkeletonData.getSkeletonNutritionData(),
        selectedPeriod: selectedPeriod,
      ),
    );
  }

  StatelessWidget _analyticsDashboardSuccess(AnalyticsDashboardSuccess state) {
    return _hasData(state)
        ? AnalyticsCombinedCardWidget(
            weightData: state.dashboard.weightProgress.entries
                .asMap()
                .entries
                .map(
                  (entry) => entry.value.toOldWeightEntry(
                    isSelected:
                        entry.key ==
                        state.dashboard.weightProgress.entries.length - 1,
                  ),
                )
                .toList(),
            nutritionData: state.dashboard.nutritionBreakdown.days
                .map((day) => day.toDailyNutrition())
                .toList(),
            selectedPeriod: selectedPeriod,
          )
        : const AnalyticsEmptyStateWidget();
  }
}
