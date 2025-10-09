import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user_profile.g.dart';

@HiveType(typeId: 2)
@JsonSerializable()
class UserProfile {
  @HiveField(0)
  @JsonKey(name: 'id')
  final String? userId;

  @HiveField(1)
  @JsonKey(name: 'full_name')
  final String? fullName;

  @HiveField(2)
  @JsonKey(name: 'email')
  final String? email;

  @HiveField(3)
  @JsonKey(name: 'daily_calorie_goal')
  final int? dailyCalorieGoal;

  @HiveField(4)
  @JsonKey(name: 'daily_protein_goal')
  final int? dailyProteinGoal;

  @HiveField(5)
  @JsonKey(name: 'daily_carbs_goal')
  final int? dailyCarbGoal;

  @HiveField(6)
  @JsonKey(name: 'daily_fats_goal')
  final int? dailyFatGoal;

  @HiveField(7)
  @JsonKey(name: 'height')
  final double? height;

  @HiveField(8)
  @JsonKey(name: 'weight')
  final double? weight;

  @HiveField(9)
  @JsonKey(name: 'is_male')
  final bool? isMale;

  @HiveField(10)
  @JsonKey(name: 'born_date')
  final String? bornDate;

  @HiveField(11)
  @JsonKey(name: 'activity_level')
  final String? activityLevel;

  @HiveField(12)
  @JsonKey(name: 'weekly_goal_in_kg')
  final double? weeklyGoalInKg;

  @HiveField(13)
  @JsonKey(name: 'rollover_calories')
  final bool? rolloverCalories;

  @HiveField(14)
  @JsonKey(name: 'goal')
  final String? goal;
  @HiveField(15)
  @JsonKey(name: 'desired_weight')
  final double? desiredWeightInKg;

  UserProfile({
    this.userId,
    this.fullName,
    this.email,
    this.dailyCalorieGoal,
    this.dailyProteinGoal,
    this.dailyCarbGoal,
    this.dailyFatGoal,
    this.height,
    this.weight,
    this.isMale,
    this.bornDate,
    this.activityLevel,
    this.weeklyGoalInKg,
    this.rolloverCalories,
    this.goal,
    this.desiredWeightInKg,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);

  Map<String, dynamic> toJson() => _$UserProfileToJson(this);

  UserProfile copyWith({
    String? userId,
    String? fullName,
    String? email,
    int? dailyCalorieGoal,
    int? dailyProteinGoal,
    int? dailyCarbGoal,
    int? dailyFatGoal,
    double? height,
    double? weight,
    bool? isMale,
    String? bornDate,
    String? activityLevel,
    double? weeklyGoalInKg,
    bool? rolloverCalories,
    String? goal,
    double? desiredWeightInKg,
  }) {
    return UserProfile(
      userId: userId ?? this.userId,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      dailyCalorieGoal: dailyCalorieGoal ?? this.dailyCalorieGoal,
      dailyProteinGoal: dailyProteinGoal ?? this.dailyProteinGoal,
      dailyCarbGoal: dailyCarbGoal ?? this.dailyCarbGoal,
      dailyFatGoal: dailyFatGoal ?? this.dailyFatGoal,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      isMale: isMale ?? this.isMale,
      bornDate: bornDate ?? this.bornDate,
      activityLevel: activityLevel ?? this.activityLevel,
      weeklyGoalInKg: weeklyGoalInKg ?? this.weeklyGoalInKg,
      rolloverCalories: rolloverCalories ?? this.rolloverCalories,
      goal: goal ?? this.goal,
      desiredWeightInKg: desiredWeightInKg ?? this.desiredWeightInKg,
    );
  }
}
