import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../core/networking/api_error_model.dart';
import '../../data/models/analytics_dashboard.dart';
import '../../data/models/daily_nutrition.dart';
import '../../data/models/goal_progress.dart';
import '../../data/models/weekly_nutrition.dart';
import '../../data/models/weight_progress.dart';
import '../../data/repo/analytics_repo.dart';

part 'analytics_state.dart';

class AnalyticsCubit extends Cubit<AnalyticsState> {
  final AnalyticsRepo analyticsRepo;

  AnalyticsCubit({required this.analyticsRepo}) : super(AnalyticsInitial());

  Future<void> getAnalyticsDashboard({
    required String userId,
    String period = '1_week',
  }) async {
    emit(AnalyticsLoading());

    final result = await analyticsRepo.getAnalyticsDashboard(
      userId: userId,
      period: period,
    );

    result.when(
      onSuccess: (dashboard) {
        emit(AnalyticsDashboardSuccess(dashboard: dashboard));
      },
      onError: (error) {
        emit(AnalyticsError(apiErrorModel: error));
      },
    );
  }

  Future<void> getDailyNutrition({
    required String userId,
    required String date,
  }) async {
    emit(AnalyticsLoading());

    final result = await analyticsRepo.getDailyNutrition(
      userId: userId,
      date: date,
    );

    result.when(
      onSuccess: (dailyNutrition) {
        emit(DailyNutritionSuccess(dailyNutrition: dailyNutrition));
      },
      onError: (error) {
        emit(AnalyticsError(apiErrorModel: error));
      },
    );
  }

  Future<void> getWeeklyNutrition({
    required String userId,
    String? endDate,
  }) async {
    emit(AnalyticsLoading());

    final result = await analyticsRepo.getWeeklyNutrition(
      userId: userId,
      endDate: endDate,
    );

    result.when(
      onSuccess: (weeklyNutrition) {
        emit(WeeklyNutritionSuccess(weeklyNutrition: weeklyNutrition));
      },
      onError: (error) {
        emit(AnalyticsError(apiErrorModel: error));
      },
    );
  }

  Future<void> getWeightProgress({
    required String userId,
    int days = 90,
  }) async {
    emit(AnalyticsLoading());

    final result = await analyticsRepo.getWeightProgress(
      userId: userId,
      days: days,
    );

    result.when(
      onSuccess: (weightProgress) {
        emit(WeightProgressSuccess(weightProgress: weightProgress));
      },
      onError: (error) {
        emit(AnalyticsError(apiErrorModel: error));
      },
    );
  }

  Future<void> getGoalProgress({required String userId, String? date}) async {
    emit(AnalyticsLoading());

    final result = await analyticsRepo.getGoalProgress(
      userId: userId,
      date: date,
    );

    result.when(
      onSuccess: (goalProgress) {
        emit(GoalProgressSuccess(goalProgress: goalProgress));
      },
      onError: (error) {
        emit(AnalyticsError(apiErrorModel: error));
      },
    );
  }
}
