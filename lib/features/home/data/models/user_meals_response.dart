import 'package:json_annotation/json_annotation.dart';

import 'meal_data.dart';

part 'user_meals_response.g.dart';

@JsonSerializable()
class UserMealsResponse {
  final bool success;
  final String message;
  final List<MealData>? data;

  UserMealsResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory UserMealsResponse.fromJson(Map<String, dynamic> json) =>
      _$UserMealsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserMealsResponseToJson(this);
}
