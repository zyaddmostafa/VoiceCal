import '../../features/onboarding/data/models/user_informations_model.dart';
import 'models/nutrition_plan_model.dart';
import 'dart:math';

/// Comprehensive nutrition calculation service for VoiceCal app
/// Provides scientifically accurate calorie and macro calculations
class NutritionCalculatorService {
  /// Calculate complete nutrition plan for a user
  ///
  /// Uses the most accurate formulas:
  /// - Mifflin-St Jeor equation for BMR
  /// - Activity multipliers for TDEE
  /// - Safe calorie deficit/surplus for weight goals
  /// - Evidence-based macro distributions
  static NutritionPlanModel calculateNutritionPlan(
    UserInformationsModel userInfo,
  ) {
    // Validate required parameters
    _validateUserInfo(userInfo);

    // Extract common values
    final age = _calculateAge(userInfo.bornDate!);
    final weightKg = userInfo.weightKg!.toDouble();
    final heightCm = userInfo.heightCm!.toDouble();

    // Calculate BMR using Mifflin-St Jeor equation
    final bmr = _calculateBMR(
      isMale: userInfo.isMale!,
      weightKg: weightKg,
      heightCm: heightCm,
      age: age,
    );

    // Calculate TDEE based on activity level
    final activityLevel = ActivityLevel.fromString(userInfo.activityLevel!);
    final tdee = _calculateTDEE(bmr, activityLevel);

    // Determine weight goal type
    final weightGoal = WeightGoal.fromString(userInfo.goal!);

    // Calculate target calories based on goal
    final calorieTarget = _calculateCalorieTarget(
      tdee: tdee,
      weightGoal: weightGoal,
      weeklyGoalKg:
          userInfo.weeklyGoalInKg ?? _getDefaultWeeklyGoal(weightGoal),
      currentWeightKg: weightKg,
      desiredWeightKg: userInfo.desiredWeightKg!,
    );

    // Calculate macro distribution
    final macros = _calculateMacroDistribution(
      dailyCalories: calorieTarget.dailyCalories,
      weightGoal: weightGoal,
      weightKg: weightKg,
    );

    // Calculate time to goal
    final weeksToGoal = _calculateWeeksToGoal(
      currentWeightKg: weightKg,
      desiredWeightKg: userInfo.desiredWeightKg!,
      weeklyChangeKg: calorieTarget.weeklyWeightChangeKg,
    );

    return NutritionPlanModel(
      bmr: bmr,
      tdee: tdee,
      dailyCalories: calorieTarget.dailyCalories,
      macros: macros,
      weeklyWeightChangeKg: calorieTarget.weeklyWeightChangeKg,
      estimatedWeeksToGoal: weeksToGoal,
    );
  }

  /// Calculate Basal Metabolic Rate using Mifflin-St Jeor equation
  /// Most accurate for general population
  static double _calculateBMR({
    required bool isMale,
    required double weightKg,
    required double heightCm,
    required int age,
  }) {
    return isMale
        ? (10 * weightKg) + (6.25 * heightCm) - (5 * age) + 5
        : (10 * weightKg) + (6.25 * heightCm) - (5 * age) - 161;
  }

  /// Calculate Total Daily Energy Expenditure
  static double _calculateTDEE(double bmr, ActivityLevel activityLevel) {
    return bmr * activityLevel.multiplier;
  }

  /// Calculate target calories and weekly weight change
  static ({double dailyCalories, double weeklyWeightChangeKg})
  _calculateCalorieTarget({
    required double tdee,
    required WeightGoal weightGoal,
    required double weeklyGoalKg,
    required double currentWeightKg,
    required double desiredWeightKg,
  }) {
    const caloriesPerKg =
        7700; // Calories in 1kg of body weight (more accurate than 7700)

    switch (weightGoal) {
      case WeightGoal.maintain:
        return (dailyCalories: tdee, weeklyWeightChangeKg: 0.0);

      case WeightGoal.lose:
        // Safe weight loss: 0.25-1kg per week (0.5kg recommended)
        final safeWeeklyLoss = _clampWeeklyGoal(weeklyGoalKg.abs(), 0.25, 1.0);
        final dailyDeficit = (safeWeeklyLoss * caloriesPerKg) / 7;
        final targetCalories = tdee - dailyDeficit;

        // Don't go below 1200 calories for women or 1500 for men
        final minCalories = currentWeightKg < 70 ? 1200.0 : 1500.0;
        final safeCalories = max(targetCalories, minCalories);

        // Recalculate actual weekly loss based on safe calories
        final actualDeficit = tdee - safeCalories;
        final actualWeeklyLoss = (actualDeficit * 7) / caloriesPerKg;

        return (
          dailyCalories: safeCalories,
          weeklyWeightChangeKg: -actualWeeklyLoss,
        );

      case WeightGoal.gain:
        // Safe weight gain: 0.25-0.5kg per week
        final safeWeeklyGain = _clampWeeklyGoal(weeklyGoalKg.abs(), 0.25, 0.5);
        final dailySurplus = (safeWeeklyGain * caloriesPerKg) / 7;
        final targetCalories = tdee + dailySurplus;

        return (
          dailyCalories: targetCalories,
          weeklyWeightChangeKg: safeWeeklyGain,
        );
    }
  }

  /// Calculate macro distribution based on goals and body weight
  static MacroDistribution _calculateMacroDistribution({
    required double dailyCalories,
    required WeightGoal weightGoal,
    required double weightKg,
  }) {
    late double proteinPercent, carbsPercent, fatPercent;

    switch (weightGoal) {
      case WeightGoal.lose:
        // Higher protein to preserve muscle during deficit
        // Protein: 30%, Carbs: 35%, Fat: 35%
        proteinPercent = 30;
        carbsPercent = 35;
        fatPercent = 35;
        break;

      case WeightGoal.maintain:
        // Balanced macro distribution
        // Protein: 25%, Carbs: 45%, Fat: 30%
        proteinPercent = 25;
        carbsPercent = 45;
        fatPercent = 30;
        break;

      case WeightGoal.gain:
        // Higher carbs for energy and muscle building
        // Protein: 25%, Carbs: 50%, Fat: 25%
        proteinPercent = 25;
        carbsPercent = 50;
        fatPercent = 25;
        break;
    }

    // Calculate grams from percentages
    final proteinCalories = dailyCalories * (proteinPercent / 100);
    final carbsCalories = dailyCalories * (carbsPercent / 100);
    final fatCalories = dailyCalories * (fatPercent / 100);

    // Convert calories to grams (4 cal/g for protein & carbs, 9 cal/g for fat)
    final proteinGrams = proteinCalories / 4;
    final carbsGrams = carbsCalories / 4;
    final fatGrams = fatCalories / 9;

    // Ensure minimum protein intake (0.8-1.2g per kg body weight)
    final minProtein = weightKg * 0.8;
    final adjustedProtein = max(proteinGrams, minProtein);

    // Recalculate if protein was adjusted
    if (adjustedProtein > proteinGrams) {
      final proteinCalAdjustment = (adjustedProtein - proteinGrams) * 4;
      final adjustedCarbsCalories = carbsCalories - proteinCalAdjustment;
      final adjustedCarbsGrams = max(
        adjustedCarbsCalories / 4,
        50.0,
      ).toDouble(); // Min 50g carbs

      return MacroDistribution(
        proteinGrams: adjustedProtein,
        carbsGrams: adjustedCarbsGrams,
        fatGrams: fatGrams,
        proteinPercent: (adjustedProtein * 4 / dailyCalories) * 100,
        carbsPercent: (adjustedCarbsGrams * 4 / dailyCalories) * 100,
        fatPercent: (fatGrams * 9 / dailyCalories) * 100,
      );
    }

    return MacroDistribution(
      proteinGrams: proteinGrams,
      carbsGrams: carbsGrams,
      fatGrams: fatGrams,
      proteinPercent: proteinPercent,
      carbsPercent: carbsPercent,
      fatPercent: fatPercent,
    );
  }

  /// Calculate age from birth date
  static int _calculateAge(BornDate bornDate) {
    final now = DateTime.now();
    final birthDate = DateTime(bornDate.year, bornDate.month, bornDate.day);

    int age = now.year - birthDate.year;
    if (now.month < birthDate.month) {
      age--;
    }

    return age;
  }

  /// Calculate estimated weeks to reach goal weight
  static int _calculateWeeksToGoal({
    required double currentWeightKg,
    required double desiredWeightKg,
    required double weeklyChangeKg,
  }) {
    if (weeklyChangeKg == 0) return 0; // Maintenance goal

    final weightDifferenceKg = (desiredWeightKg - currentWeightKg).abs();
    final weeksToGoal = (weightDifferenceKg / weeklyChangeKg.abs()).ceil();

    return max(weeksToGoal, 1); // Minimum 1 week
  }

  /// Validate user information for calculations
  static void _validateUserInfo(UserInformationsModel userInfo) {
    if (userInfo.isMale == null) throw ArgumentError('Gender is required');
    if (userInfo.heightCm == null || userInfo.heightCm! <= 0) {
      throw ArgumentError('Valid height is required');
    }
    if (userInfo.weightKg == null || userInfo.weightKg! <= 0) {
      throw ArgumentError('Valid weight is required');
    }
    if (userInfo.bornDate == null)
      throw ArgumentError('Birth date is required');
    if (userInfo.activityLevel == null)
      throw ArgumentError('Activity level is required');
    if (userInfo.goal == null) throw ArgumentError('Goal is required');
    if (userInfo.desiredWeightKg == null)
      throw ArgumentError('Desired weight is required');
  }

  /// Clamp weekly goal to safe range
  static double _clampWeeklyGoal(double weeklyGoal, double min, double max) {
    return weeklyGoal.clamp(min, max);
  }

  /// Get default weekly goal based on weight goal type
  static double _getDefaultWeeklyGoal(WeightGoal weightGoal) {
    switch (weightGoal) {
      case WeightGoal.lose:
        return 0.5; // 0.5kg per week is safe and sustainable
      case WeightGoal.gain:
        return 0.25; // 0.25kg per week for clean muscle gain
      case WeightGoal.maintain:
        return 0.0;
    }
  }
}
