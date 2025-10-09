import 'package:json_annotation/json_annotation.dart';

import 'meal_data.dart';

part 'meal_data_response.g.dart';

@JsonSerializable()
class MealDataResponse {
  final bool success;
  final String message;
  final MealData? data;

  MealDataResponse({required this.success, required this.message, this.data});

  factory MealDataResponse.fromJson(Map<String, dynamic> json) =>
      _$MealDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MealDataResponseToJson(this);
}
