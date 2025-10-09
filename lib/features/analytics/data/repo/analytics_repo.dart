import '../../../../core/networking/api_error_handler.dart';
import '../../../../core/networking/api_result.dart';
import '../models/analytics_dashboard.dart';
import '../models/daily_nutrition.dart';
import '../models/goal_progress.dart';
import '../models/weekly_nutrition.dart';
import '../models/weight_progress.dart';
import '../services/analytics_api_service.dart';

class AnalyticsRepo {
  final AnalyticsApiService analyticsApiService;

  AnalyticsRepo({required this.analyticsApiService});

  Future<ApiResult<DailyNutrition>> getDailyNutrition({
    required String userId,
    required String date,
  }) async {
    try {
      final response = await analyticsApiService.getDailyNutrition(
        userId: userId,
        date: date,
      );

      final dailyNutrition = DailyNutrition.fromJson(response);

      return ApiResult.success(dailyNutrition);
    } on Exception catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  Future<ApiResult<WeeklyNutrition>> getWeeklyNutrition({
    required String userId,
    String? endDate,
  }) async {
    try {
      final response = await analyticsApiService.getWeeklyNutrition(
        userId: userId,
        endDate: endDate,
      );

      final weeklyNutrition = WeeklyNutrition.fromJson(response);

      return ApiResult.success(weeklyNutrition);
    } on Exception catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  Future<ApiResult<WeightProgress>> getWeightProgress({
    required String userId,
    int days = 90,
  }) async {
    try {
      final response = await analyticsApiService.getWeightProgress(
        userId: userId,
        days: days,
      );

      final weightProgress = WeightProgress.fromJson(response);

      return ApiResult.success(weightProgress);
    } on Exception catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  Future<ApiResult<GoalProgress>> getGoalProgress({
    required String userId,
    String? date,
  }) async {
    try {
      final response = await analyticsApiService.getGoalProgress(
        userId: userId,
        date: date,
      );

      final goalProgress = GoalProgress.fromJson(response);

      return ApiResult.success(goalProgress);
    } on Exception catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  Future<ApiResult<AnalyticsDashboard>> getAnalyticsDashboard({
    required String userId,
    String period = '1_week',
  }) async {
    try {
      final response = await analyticsApiService.getAnalyticsDashboard(
        userId: userId,
        period: period,
      );

      final dashboard = AnalyticsDashboard.fromJson(response);

      return ApiResult.success(dashboard);
    } on Exception catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}
