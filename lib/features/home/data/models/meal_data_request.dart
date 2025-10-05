import 'package:json_annotation/json_annotation.dart';

part 'meal_data_request.g.dart';

@JsonSerializable()
class MealDataRequest {
  final String userId;
  @JsonKey(name: 'meal_text')
  final String mealText;
  @JsonKey(name: 'meal_date')
  final String mealDate;
  @JsonKey(name: 'meal_time')
  final String mealTime;

  MealDataRequest({
    required this.userId,
    required this.mealText,
    required this.mealDate,
    required this.mealTime,
  });

  factory MealDataRequest.fromJson(Map<String, dynamic> json) =>
      _$MealDataRequestFromJson(json);

  Map<String, dynamic> toJson() => _$MealDataRequestToJson(this);
}
