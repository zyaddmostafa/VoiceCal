part of 'analytics_cubit.dart';

@immutable
sealed class AnalyticsState {}

final class AnalyticsInitial extends AnalyticsState {}

final class AnalyticsLoading extends AnalyticsState {}

final class AnalyticsDashboardSuccess extends AnalyticsState {
  final AnalyticsDashboard dashboard;

  AnalyticsDashboardSuccess({required this.dashboard});
}

final class DailyNutritionSuccess extends AnalyticsState {
  final DailyNutrition dailyNutrition;

  DailyNutritionSuccess({required this.dailyNutrition});
}

final class WeeklyNutritionSuccess extends AnalyticsState {
  final WeeklyNutrition weeklyNutrition;

  WeeklyNutritionSuccess({required this.weeklyNutrition});
}

final class WeightProgressSuccess extends AnalyticsState {
  final WeightProgress weightProgress;

  WeightProgressSuccess({required this.weightProgress});
}

final class GoalProgressSuccess extends AnalyticsState {
  final GoalProgress goalProgress;

  GoalProgressSuccess({required this.goalProgress});
}

final class WeightEntryAddedSuccess extends AnalyticsState {}

final class WeightEntryUpdatedSuccess extends AnalyticsState {}

final class WeightEntryDeletedSuccess extends AnalyticsState {}

final class AnalyticsError extends AnalyticsState {
  final ApiErrorModel apiErrorModel;

  AnalyticsError({required this.apiErrorModel});
}
