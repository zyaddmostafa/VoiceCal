import 'package:json_annotation/json_annotation.dart';

part 'goal_progress.g.dart';

@JsonSerializable()
class GoalProgress {
  final String date;
  final MacroProgress calories;
  final MacroProgress protein;
  final MacroProgress carbs;
  final MacroProgress fats;
  @JsonKey(name: 'goal_achieved')
  final bool goalAchieved;

  GoalProgress({
    required this.date,
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fats,
    required this.goalAchieved,
  });

  factory GoalProgress.fromJson(Map<String, dynamic> json) =>
      _$GoalProgressFromJson(json);

  Map<String, dynamic> toJson() => _$GoalProgressToJson(this);
}

@JsonSerializable()
class MacroProgress {
  final double consumed;
  final int goal;
  final double percentage;
  final double remaining;

  MacroProgress({
    required this.consumed,
    required this.goal,
    required this.percentage,
    required this.remaining,
  });

  factory MacroProgress.fromJson(Map<String, dynamic> json) =>
      _$MacroProgressFromJson(json);

  Map<String, dynamic> toJson() => _$MacroProgressToJson(this);
}
