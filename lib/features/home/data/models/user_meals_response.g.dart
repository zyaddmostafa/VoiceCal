// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_meals_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserMealsResponse _$UserMealsResponseFromJson(Map<String, dynamic> json) =>
    UserMealsResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => MealData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserMealsResponseToJson(UserMealsResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };
