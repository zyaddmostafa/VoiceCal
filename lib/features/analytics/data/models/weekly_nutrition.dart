import 'package:json_annotation/json_annotation.dart';

part 'weekly_nutrition.g.dart';

@JsonSerializable()
class WeeklyNutrition {
  @JsonKey(name: 'start_date')
  final String startDate;
  @JsonKey(name: 'end_date')
  final String endDate;
  @JsonKey(name: 'total_calories')
  final double totalCalories;
  @JsonKey(name: 'avg_daily_calories')
  final double avgDailyCalories;
  final List<DayNutrition> days;

  WeeklyNutrition({
    required this.startDate,
    required this.endDate,
    required this.totalCalories,
    required this.avgDailyCalories,
    required this.days,
  });

  factory WeeklyNutrition.fromJson(Map<String, dynamic> json) =>
      _$WeeklyNutritionFromJson(json);

  Map<String, dynamic> toJson() => _$WeeklyNutritionToJson(this);
}

@JsonSerializable()
class DayNutrition {
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

  DayNutrition({
    required this.date,
    required this.dayName,
    required this.totalCalories,
    required this.totalProtein,
    required this.totalCarbs,
    required this.totalFats,
    required this.mealCount,
  });

  factory DayNutrition.fromJson(Map<String, dynamic> json) =>
      _$DayNutritionFromJson(json);

  Map<String, dynamic> toJson() => _$DayNutritionToJson(this);
}
