// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfile _$UserProfileFromJson(Map<String, dynamic> json) => UserProfile(
      userId: json['id'] as String,
      fullName: json['full_name'] as String?,
      email: json['email'] as String?,
      dailyCalorieGoal: (json['daily_calorie_goal'] as num?)?.toInt(),
      dailyProteinGoal: (json['daily_protein_goal'] as num?)?.toInt(),
      dailyCarbGoal: (json['daily_carbs_goal'] as num?)?.toInt(),
      dailyFatGoal: (json['daily_fats_goal'] as num?)?.toInt(),
    );

Map<String, dynamic> _$UserProfileToJson(UserProfile instance) =>
    <String, dynamic>{
      'id': instance.userId,
      'full_name': instance.fullName,
      'email': instance.email,
      'daily_calorie_goal': instance.dailyCalorieGoal,
      'daily_protein_goal': instance.dailyProteinGoal,
      'daily_carbs_goal': instance.dailyCarbGoal,
      'daily_fats_goal': instance.dailyFatGoal,
    };
