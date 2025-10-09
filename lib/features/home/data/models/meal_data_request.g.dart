// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal_data_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MealDataRequest _$MealDataRequestFromJson(Map<String, dynamic> json) =>
    MealDataRequest(
      userId: json['userId'] as String,
      mealText: json['meal_text'] as String,
      mealDate: json['meal_date'] as String,
      mealTime: json['meal_time'] as String,
    );

Map<String, dynamic> _$MealDataRequestToJson(MealDataRequest instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'meal_text': instance.mealText,
      'meal_date': instance.mealDate,
      'meal_time': instance.mealTime,
    };
