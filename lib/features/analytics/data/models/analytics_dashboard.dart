import 'package:json_annotation/json_annotation.dart';
import 'daily_nutrition.dart';
import 'goal_progress.dart';
import 'weight_progress.dart';

part 'analytics_dashboard.g.dart';

@JsonSerializable()
class AnalyticsDashboard {
  final String period;
  @JsonKey(name: 'start_date')
  final String startDate;
  @JsonKey(name: 'end_date')
  final String endDate;
  @JsonKey(name: 'goal_progress')
  final GoalProgress goalProgress;
  @JsonKey(name: 'weight_progress')
  final WeightProgress weightProgress;
  @JsonKey(name: 'nutrition_breakdown')
  final NutritionBreakdown nutritionBreakdown;

  AnalyticsDashboard({
    required this.period,
    required this.startDate,
    required this.endDate,
    required this.goalProgress,
    required this.weightProgress,
    required this.nutritionBreakdown,
  });

  factory AnalyticsDashboard.fromJson(Map<String, dynamic> json) =>
      _$AnalyticsDashboardFromJson(json);

  Map<String, dynamic> toJson() => _$AnalyticsDashboardToJson(this);
}

@JsonSerializable()
class NutritionBreakdown {
  @JsonKey(name: 'start_date')
  final String startDate;
  @JsonKey(name: 'end_date')
  final String endDate;
  @JsonKey(name: 'total_calories')
  final double totalCalories;
  @JsonKey(name: 'avg_daily_calories')
  final double avgDailyCalories;
  @JsonKey(name: 'total_protein')
  final double totalProtein;
  @JsonKey(name: 'total_carbs')
  final double totalCarbs;
  @JsonKey(name: 'total_fats')
  final double totalFats;
  final List<DayBreakdown> days;

  NutritionBreakdown({
    required this.startDate,
    required this.endDate,
    required this.totalCalories,
    required this.avgDailyCalories,
    required this.totalProtein,
    required this.totalCarbs,
    required this.totalFats,
    required this.days,
  });

  factory NutritionBreakdown.fromJson(Map<String, dynamic> json) =>
      _$NutritionBreakdownFromJson(json);

  Map<String, dynamic> toJson() => _$NutritionBreakdownToJson(this);
}

@JsonSerializable()
class DayBreakdown {
  final String date;
  @JsonKey(name: 'day_name')
  final String dayName;
  @JsonKey(name: 'total_calories')
  final double totalCalories;
  @JsonKey(name: 'total_protein')
  final double totalProtein;
  @JsonKey(name: 'total_carbs')
  final double totalCarbs;
  @JsonKey(name: 'total_fats')
  final double totalFats;
  @JsonKey(name: 'meal_count')
  final int mealCount;

  DayBreakdown({
    required this.date,
    required this.dayName,
    required this.totalCalories,
    required this.totalProtein,
    required this.totalCarbs,
    required this.totalFats,
    required this.mealCount,
  });

  factory DayBreakdown.fromJson(Map<String, dynamic> json) =>
      _$DayBreakdownFromJson(json);

  Map<String, dynamic> toJson() => _$DayBreakdownToJson(this);

  DailyNutrition toDailyNutrition() {
    return DailyNutrition(
      date: DateTime.parse(date),
      protein: totalProtein,
      carbs: totalCarbs,
      fats: totalFats,
    );
  }
}
