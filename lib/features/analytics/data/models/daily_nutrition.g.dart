// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_nutrition.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DailyNutrition _$DailyNutritionFromJson(Map<String, dynamic> json) =>
    DailyNutrition(
      date: DateTime.parse(json['date'] as String),
      protein: (json['protein'] as num).toDouble(),
      carbs: (json['carbs'] as num).toDouble(),
      fats: (json['fats'] as num).toDouble(),
    );

Map<String, dynamic> _$DailyNutritionToJson(DailyNutrition instance) =>
    <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'protein': instance.protein,
      'carbs': instance.carbs,
      'fats': instance.fats,
    };
