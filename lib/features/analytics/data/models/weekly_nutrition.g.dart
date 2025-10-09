// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weekly_nutrition.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeeklyNutrition _$WeeklyNutritionFromJson(Map<String, dynamic> json) =>
    WeeklyNutrition(
      startDate: json['start_date'] as String,
      endDate: json['end_date'] as String,
      totalCalories: (json['total_calories'] as num).toDouble(),
      avgDailyCalories: (json['avg_daily_calories'] as num).toDouble(),
      days: (json['days'] as List<dynamic>)
          .map((e) => DayNutrition.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$WeeklyNutritionToJson(WeeklyNutrition instance) =>
    <String, dynamic>{
      'start_date': instance.startDate,
      'end_date': instance.endDate,
      'total_calories': instance.totalCalories,
      'avg_daily_calories': instance.avgDailyCalories,
      'days': instance.days,
    };

DayNutrition _$DayNutritionFromJson(Map<String, dynamic> json) => DayNutrition(
      date: json['date'] as String,
      dayName: json['day_name'] as String,
      totalCalories: (json['total_calories'] as num).toDouble(),
      totalProtein: (json['total_protein'] as num).toDouble(),
      totalCarbs: (json['total_carbs'] as num).toDouble(),
      totalFats: (json['total_fats'] as num).toDouble(),
      mealCount: (json['meal_count'] as num).toInt(),
    );

Map<String, dynamic> _$DayNutritionToJson(DayNutrition instance) =>
    <String, dynamic>{
      'date': instance.date,
      'day_name': instance.dayName,
      'total_calories': instance.totalCalories,
      'total_protein': instance.totalProtein,
      'total_carbs': instance.totalCarbs,
      'total_fats': instance.totalFats,
      'meal_count': instance.mealCount,
    };
