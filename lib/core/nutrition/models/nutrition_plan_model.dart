class NutritionPlanModel {
  /// Basal Metabolic Rate - calories burned at rest
  final double bmr;

  /// Total Daily Energy Expenditure - calories needed to maintain weight
  final double tdee;

  /// Daily calorie target based on goals
  final double dailyCalories;

  /// Macro distribution breakdown
  final MacroDistribution macros;

  /// Weekly weight change goal (negative = loss, positive = gain)
  final double weeklyWeightChangeKg;

  /// Estimated time to reach goal weight in weeks
  final int estimatedWeeksToGoal;

  const NutritionPlanModel({
    required this.bmr,
    required this.tdee,
    required this.dailyCalories,
    required this.macros,
    required this.weeklyWeightChangeKg,
    required this.estimatedWeeksToGoal,
  });

  /// Create a copy with modified values
  NutritionPlanModel copyWith({
    double? bmr,
    double? tdee,
    double? dailyCalories,
    MacroDistribution? macros,
    double? weeklyWeightChangeKg,
    int? estimatedWeeksToGoal,
  }) {
    return NutritionPlanModel(
      bmr: bmr ?? this.bmr,
      tdee: tdee ?? this.tdee,
      dailyCalories: dailyCalories ?? this.dailyCalories,
      macros: macros ?? this.macros,
      weeklyWeightChangeKg: weeklyWeightChangeKg ?? this.weeklyWeightChangeKg,
      estimatedWeeksToGoal: estimatedWeeksToGoal ?? this.estimatedWeeksToGoal,
    );
  }

  @override
  String toString() {
    return 'NutritionPlan(bmr: $bmr, tdee: $tdee, dailyCalories: $dailyCalories, '
        'macros: $macros, weeklyChange: ${weeklyWeightChangeKg}kg)';
  }
}

/// Represents daily macro nutrient targets
class MacroDistribution {
  /// Daily protein target in grams
  final double proteinGrams;

  /// Daily carbohydrate target in grams
  final double carbsGrams;

  /// Daily fat target in grams
  final double fatGrams;

  /// Protein percentage of total calories
  final double proteinPercent;

  /// Carbs percentage of total calories
  final double carbsPercent;

  /// Fat percentage of total calories
  final double fatPercent;

  const MacroDistribution({
    required this.proteinGrams,
    required this.carbsGrams,
    required this.fatGrams,
    required this.proteinPercent,
    required this.carbsPercent,
    required this.fatPercent,
  });

  /// Total calories from macros (should match daily calorie target)
  double get totalCalories =>
      (proteinGrams * 4) + (carbsGrams * 4) + (fatGrams * 9);

  /// Create a copy with modified values
  MacroDistribution copyWith({
    double? proteinGrams,
    double? carbsGrams,
    double? fatGrams,
    double? proteinPercent,
    double? carbsPercent,
    double? fatPercent,
  }) {
    return MacroDistribution(
      proteinGrams: proteinGrams ?? this.proteinGrams,
      carbsGrams: carbsGrams ?? this.carbsGrams,
      fatGrams: fatGrams ?? this.fatGrams,
      proteinPercent: proteinPercent ?? this.proteinPercent,
      carbsPercent: carbsPercent ?? this.carbsPercent,
      fatPercent: fatPercent ?? this.fatPercent,
    );
  }

  @override
  String toString() {
    return 'MacroDistribution(P: ${proteinGrams.toInt()}g, C: ${carbsGrams.toInt()}g, '
        'F: ${fatGrams.toInt()}g, Total: ${totalCalories.toInt()} cal)';
  }
}

/// Activity level definitions for TDEE calculations
enum ActivityLevel {
  /// Sedentary - little to no exercise
  sedentary(multiplier: 1.2, description: 'Little to no exercise'),

  /// Light - light exercise 1-3 days per week
  light(multiplier: 1.375, description: 'Light exercise 1-3 days/week'),

  /// Moderate - moderate exercise 3-5 days per week
  moderate(multiplier: 1.55, description: 'Moderate exercise 3-5 days/week'),

  /// Very active - hard exercise 6-7 days per week
  veryActive(multiplier: 1.725, description: 'Hard exercise 6-7 days/week'),

  /// Extremely active - very hard exercise, physical job
  extremelyActive(
    multiplier: 1.9,
    description: 'Very hard exercise + physical job',
  );

  const ActivityLevel({required this.multiplier, required this.description});

  /// TDEE multiplier for this activity level
  final double multiplier;

  /// Human-readable description
  final String description;

  /// Convert from string representation used in UserInformationsModel
  static ActivityLevel fromString(String activityString) {
    switch (activityString) {
      case '0':
        return ActivityLevel.sedentary;
      case '1-3':
        return ActivityLevel.light;
      case '3-5':
        return ActivityLevel.moderate;
      case '6+':
        return ActivityLevel.veryActive;
      default:
        return ActivityLevel.sedentary; // Default fallback
    }
  }
}

/// Weight goal types for calorie adjustments
enum WeightGoal {
  /// Maintain current weight
  maintain(description: 'Maintain current weight', calorieAdjustment: 0),

  /// Lose weight
  lose(description: 'Lose weight', calorieAdjustment: -1),

  /// Gain weight/muscle
  gain(description: 'Gain weight', calorieAdjustment: 1);

  const WeightGoal({
    required this.description,
    required this.calorieAdjustment,
  });

  /// Human-readable description
  final String description;

  /// Direction of calorie adjustment (-1 = deficit, 0 = maintain, 1 = surplus)
  final int calorieAdjustment;

  /// Convert from string representation used in UserInformationsModel
  static WeightGoal fromString(String goalString) {
    final goal = goalString.toLowerCase();
    if (goal.contains('lose') || goal.contains('weight loss')) {
      return WeightGoal.lose;
    } else if (goal.contains('gain') || goal.contains('muscle')) {
      return WeightGoal.gain;
    } else {
      return WeightGoal.maintain;
    }
  }
}
