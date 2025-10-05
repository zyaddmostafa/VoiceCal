import 'package:json_annotation/json_annotation.dart';
part 'user_profile.g.dart';

@JsonSerializable()
class UserProfile {
  @JsonKey(name: 'id')
  final String userId;

  @JsonKey(name: 'full_name')
  final String? fullName;

  @JsonKey(name: 'email')
  final String? email;

  @JsonKey(name: 'daily_calorie_goal')
  final int? dailyCalorieGoal;

  @JsonKey(name: 'daily_protein_goal')
  final int? dailyProteinGoal;

  @JsonKey(name: 'daily_carbs_goal')
  final int? dailyCarbGoal;

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
