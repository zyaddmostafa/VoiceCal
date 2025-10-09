// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goal_progress.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoalProgress _$GoalProgressFromJson(Map<String, dynamic> json) => GoalProgress(
      date: json['date'] as String,
      calories:
          MacroProgress.fromJson(json['calories'] as Map<String, dynamic>),
      protein: MacroProgress.fromJson(json['protein'] as Map<String, dynamic>),
      carbs: MacroProgress.fromJson(json['carbs'] as Map<String, dynamic>),
      fats: MacroProgress.fromJson(json['fats'] as Map<String, dynamic>),
      goalAchieved: json['goal_achieved'] as bool,
    );

Map<String, dynamic> _$GoalProgressToJson(GoalProgress instance) =>
    <String, dynamic>{
      'date': instance.date,
      'calories': instance.calories,
      'protein': instance.protein,
      'carbs': instance.carbs,
      'fats': instance.fats,
      'goal_achieved': instance.goalAchieved,
    };

MacroProgress _$MacroProgressFromJson(Map<String, dynamic> json) =>
    MacroProgress(
      consumed: (json['consumed'] as num).toDouble(),
      goal: (json['goal'] as num).toInt(),
      percentage: (json['percentage'] as num).toDouble(),
      remaining: (json['remaining'] as num).toDouble(),
    );

Map<String, dynamic> _$MacroProgressToJson(MacroProgress instance) =>
    <String, dynamic>{
      'consumed': instance.consumed,
      'goal': instance.goal,
      'percentage': instance.percentage,
      'remaining': instance.remaining,
    };
