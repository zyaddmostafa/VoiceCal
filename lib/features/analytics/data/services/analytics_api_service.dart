import 'package:supabase_flutter/supabase_flutter.dart';

class AnalyticsApiService {
  final SupabaseClient _supabase;

  AnalyticsApiService(this._supabase);

  Future<Map<String, dynamic>> getDailyNutrition({
    required String userId,
    required String date,
  }) async {
    final response = await _supabase.rpc(
      'get_daily_nutrition',
      params: {'p_user_id': userId, 'p_date': date},
    );

    return response as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> getWeeklyNutrition({
    required String userId,
    String? endDate,
  }) async {
    final response = await _supabase.rpc(
      'get_weekly_nutrition',
      params: {'p_user_id': userId, if (endDate != null) 'p_end_date': endDate},
    );

    return response as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> getNutritionDateRange({
    required String userId,
    required String startDate,
    required String endDate,
  }) async {
    final response = await _supabase.rpc(
      'get_nutrition_date_range',
      params: {
        'p_user_id': userId,
        'p_start_date': startDate,
        'p_end_date': endDate,
      },
    );

    return response as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> getWeightProgress({
    required String userId,
    int days = 90,
  }) async {
    final response = await _supabase.rpc(
      'get_weight_progress',
      params: {'p_user_id': userId, 'p_days': days},
    );

    return response as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> getGoalProgress({
    required String userId,
    String? date,
  }) async {
    final response = await _supabase.rpc(
      'get_goal_progress',
      params: {'p_user_id': userId, if (date != null) 'p_date': date},
    );

    return response as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> getAnalyticsDashboard({
    required String userId,
    String period = '1_week',
  }) async {
    final response = await _supabase.rpc(
      'get_analytics_dashboard',
      params: {'p_user_id': userId, 'p_period': period},
    );

    return response as Map<String, dynamic>;
  }
}
