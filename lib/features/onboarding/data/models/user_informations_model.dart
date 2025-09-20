import 'package:hive_flutter/hive_flutter.dart';
part 'user_informations_model.g.dart';

@HiveType(typeId: 0)
class UserInformationsModel extends HiveObject {
  @HiveField(0)
  final bool? isMale;
  @HiveField(1)
  final int? heightCm;
  @HiveField(2)
  final double? heightFt;
  @HiveField(3)
  final int? weightKg;
  @HiveField(4)
  final int? weightLb;
  @HiveField(5)
  final BornDate? bornDate;
  @HiveField(6)
  final String? activityLevel;
  @HiveField(7)
  final String? goal;
  @HiveField(8)
  final double? desiredWeightKg;
  @HiveField(9)
  final double? desiredWeightLb;
  @HiveField(10)
  final double? weeklyGoalInKg;
  @HiveField(11)
  final double? weeklyGoalInLb;

  @HiveField(12)
  final bool? rolloverCalories;

  UserInformationsModel({
    this.isMale,
    this.heightCm,
    this.weightKg,
    this.bornDate,
    this.activityLevel,
    this.goal,
    this.desiredWeightKg,
    this.rolloverCalories,
    this.weeklyGoalInKg,
    this.weeklyGoalInLb,
    this.heightFt,
    this.weightLb,
    this.desiredWeightLb,
  });
  UserInformationsModel copyWith({
    bool? isMale,
    int? heightCm,
    int? weightKg,
    BornDate? bornDate,
    String? activityLevel,
    String? goal,
    double? desiredWeightKg,
    double? weeklyGoalInKg,
    bool? rolloverCalories,
    double? heightFt,
    int? weightLb,
    double? desiredWeightLb,
    double? weeklyGoalInLb,
  }) {
    return UserInformationsModel(
      isMale: isMale ?? this.isMale,
      heightCm: heightCm ?? this.heightCm,
      weightKg: weightKg ?? this.weightKg,
      bornDate: bornDate ?? this.bornDate,
      activityLevel: activityLevel ?? this.activityLevel,
      goal: goal ?? this.goal,
      desiredWeightKg: desiredWeightKg ?? this.desiredWeightKg,
      rolloverCalories: rolloverCalories ?? this.rolloverCalories,
      weeklyGoalInKg: weeklyGoalInKg ?? this.weeklyGoalInKg,
      heightFt: heightFt ?? this.heightFt,
      weightLb: weightLb ?? this.weightLb,
      desiredWeightLb: desiredWeightLb ?? this.desiredWeightLb,
      weeklyGoalInLb: weeklyGoalInLb ?? this.weeklyGoalInLb,
    );
  }
}

@HiveType(typeId: 1)
class BornDate {
  @HiveField(0)
  final int day;
  @HiveField(1)
  final int month;
  @HiveField(2)
  final int year;

  BornDate({required this.day, required this.month, required this.year});

  BornDate copyWith({int? day, int? month, int? year}) {
    return BornDate(
      day: day ?? this.day,
      month: month ?? this.month,
      year: year ?? this.year,
    );
  }
}
