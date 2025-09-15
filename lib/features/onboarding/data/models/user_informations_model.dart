class UserInformationsModel {
  final bool? isMale;
  final int? heightCm;
  final double? heightFt;
  final int? weightKg;
  final int? weightLb;
  final BornDate? bornDate;
  final String? activityLevel;
  final String? goal;
  final double? desiredWeightKg;
  final double? desiredWeightLb;
  final double? weeklyGoalInKg;
  final double? weeklyGoalInLb;

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

class BornDate {
  final int day;
  final int month;
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
