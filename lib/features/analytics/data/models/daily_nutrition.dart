import 'package:json_annotation/json_annotation.dart';

part 'daily_nutrition.g.dart';

@JsonSerializable()
class DailyNutrition {
  final DateTime date;
  final double protein;
  final double carbs;
  final double fats;

  const DailyNutrition({
    required this.date,
    required this.protein,
    required this.carbs,
    required this.fats,
  });

  factory DailyNutrition.fromJson(Map<String, dynamic> json) =>
      _$DailyNutritionFromJson(json);

  Map<String, dynamic> toJson() => _$DailyNutritionToJson(this);
}
