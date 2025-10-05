import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user_profile.g.dart';

@HiveType(typeId: 2)
@JsonSerializable()
class UserProfile {
  @HiveField(0)
  @JsonKey(name: 'id')
  final String userId;

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

  UserProfile({
    required this.userId,
    this.fullName,
    this.email,
    this.dailyCalorieGoal,
    this.dailyProteinGoal,
    this.dailyCarbGoal,
    this.dailyFatGoal,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);

  Map<String, dynamic> toJson() => _$UserProfileToJson(this);
}
