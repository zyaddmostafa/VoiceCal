// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analytics_dashboard.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnalyticsDashboard _$AnalyticsDashboardFromJson(Map<String, dynamic> json) =>
    AnalyticsDashboard(
      period: json['period'] as String,
      startDate: json['start_date'] as String,
      endDate: json['end_date'] as String,
      goalProgress:
          GoalProgress.fromJson(json['goal_progress'] as Map<String, dynamic>),
      weightProgress: WeightProgress.fromJson(
          json['weight_progress'] as Map<String, dynamic>),
      nutritionBreakdown: NutritionBreakdown.fromJson(
          json['nutrition_breakdown'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AnalyticsDashboardToJson(AnalyticsDashboard instance) =>
    <String, dynamic>{
      'period': instance.period,
      'start_date': instance.startDate,
      'end_date': instance.endDate,
      'goal_progress': instance.goalProgress,
      'weight_progress': instance.weightProgress,
      'nutrition_breakdown': instance.nutritionBreakdown,
    };

NutritionBreakdown _$NutritionBreakdownFromJson(Map<String, dynamic> json) =>
    NutritionBreakdown(
      startDate: json['start_date'] as String,
      endDate: json['end_date'] as String,
      totalCalories: (json['total_calories'] as num).toDouble(),
      avgDailyCalories: (json['avg_daily_calories'] as num).toDouble(),
      totalProtein: (json['total_protein'] as num).toDouble(),
      totalCarbs: (json['total_carbs'] as num).toDouble(),
      totalFats: (json['total_fats'] as num).toDouble(),
      days: (json['days'] as List<dynamic>)
          .map((e) => DayBreakdown.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$NutritionBreakdownToJson(NutritionBreakdown instance) =>
    <String, dynamic>{
      'start_date': instance.startDate,
      'end_date': instance.endDate,
      'total_calories': instance.totalCalories,
      'avg_daily_calories': instance.avgDailyCalories,
      'total_protein': instance.totalProtein,
      'total_carbs': instance.totalCarbs,
      'total_fats': instance.totalFats,
      'days': instance.days,
    };

DayBreakdown _$DayBreakdownFromJson(Map<String, dynamic> json) => DayBreakdown(
      date: json['date'] as String,
      dayName: json['day_name'] as String,
      totalCalories: (json['total_calories'] as num).toDouble(),
      totalProtein: (json['total_protein'] as num).toDouble(),
      totalCarbs: (json['total_carbs'] as num).toDouble(),
      totalFats: (json['total_fats'] as num).toDouble(),
      mealCount: (json['meal_count'] as num).toInt(),
    );

Map<String, dynamic> _$DayBreakdownToJson(DayBreakdown instance) =>
    <String, dynamic>{
      'date': instance.date,
      'day_name': instance.dayName,
      'total_calories': instance.totalCalories,
      'total_protein': instance.totalProtein,
      'total_carbs': instance.totalCarbs,
      'total_fats': instance.totalFats,
      'meal_count': instance.mealCount,
    };
