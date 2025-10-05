// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal_data_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MealDataResponse _$MealDataResponseFromJson(Map<String, dynamic> json) =>
    MealDataResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: json['data'] == null
          ? null
          : MealData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MealDataResponseToJson(MealDataResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };
