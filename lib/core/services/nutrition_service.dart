import '../../features/onboarding/data/models/user_informations_model.dart';
import '../nutrition/nutrition_calculator_service.dart';
import '../nutrition/models/nutrition_plan_model.dart';

/// Easy-to-use nutrition service for VoiceCal app
/// Provides a simplified interface for nutrition calculations
class NutritionService {
  /// Calculate complete nutrition plan from user information
  ///
  /// Returns detailed calorie and macro recommendations
  ///
  /// Example usage:
  /// ```dart
  /// final nutritionPlan = NutritionService.calculateForUser(userInfo);
  /// print('Daily calories: ${nutritionPlan.dailyCalories}');
  /// print('Protein: ${nutritionPlan.macros.proteinGrams}g');
  /// ```
  static NutritionPlanModel calculateForUser(UserInformationsModel userInfo) {
    try {
      return NutritionCalculatorService.calculateNutritionPlan(userInfo);
    } catch (e) {
      // Log error and provide fallback
      throw NutritionCalculationException(
        'Failed to calculate nutrition plan: ${e.toString()}',
        userInfo,
      );
    }
  }

  /// Quick calorie calculation without full nutrition plan
  ///
  /// Useful for display purposes where only calories are needed
  static double calculateDailyCalories(UserInformationsModel userInfo) {
    final plan = calculateForUser(userInfo);

    return plan.dailyCalories;
  }

  /// Get macro breakdown as a formatted string
  ///
  /// Example: "Protein: 120g (30%) | Carbs: 150g (40%) | Fat: 67g (30%)"
  static String getMacroSummary(NutritionPlanModel plan) {
    final macros = plan.macros;

    return 'Protein: ${macros.proteinGrams.toInt()}g (${macros.proteinPercent.toInt()}%) | '
        'Carbs: ${macros.carbsGrams.toInt()}g (${macros.carbsPercent.toInt()}%) | '
        'Fat: ${macros.fatGrams.toInt()}g (${macros.fatPercent.toInt()}%)';
  }

  /// Get calorie breakdown by source
  ///
  /// Returns a map with calorie sources and amounts
  static Map<String, double> getCalorieBreakdown(NutritionPlanModel plan) {
    final macros = plan.macros;

    return {
      'protein_calories': macros.proteinGrams * 4,
      'carbs_calories': macros.carbsGrams * 4,
      'fat_calories': macros.fatGrams * 9,
      'total_calories': plan.dailyCalories,
    };
  }

  /// Check if nutrition plan is healthy and achievable
  ///
  /// Returns validation results with warnings if needed
  static NutritionValidation validatePlan(
    NutritionPlanModel plan,
    UserInformationsModel userInfo,
  ) {
    final warnings = <String>[];
    final weightKg = userInfo.weightKg!.toDouble();

    // Check calorie levels
    if (plan.dailyCalories < 1200) {
      warnings.add(
        'Calorie intake is very low. Consider a less aggressive goal.',
      );
    }

    // Check protein levels
    final proteinPerKg = plan.macros.proteinGrams / weightKg;
    if (proteinPerKg < 0.8) {
      warnings.add(
        'Protein intake is below recommended levels (0.8g/kg body weight).',
      );
    }

    // Check weekly weight change
    if (plan.weeklyWeightChangeKg.abs() > 1.0) {
      warnings.add(
        'Weekly weight change goal is aggressive. Consider a more moderate approach.',
      );
    }

    // Check timeline
    if (plan.estimatedWeeksToGoal > 52) {
      warnings.add(
        'Goal timeline is very long. Consider adjusting your target weight or timeline.',
      );
    }

    return NutritionValidation(
      isHealthy: warnings.isEmpty,
      warnings: warnings,
      plan: plan,
    );
  }

  /// Update nutrition plan with new user preferences
  ///
  /// Useful for recalculating when user changes goals
  static NutritionPlanModel updatePlan(
    UserInformationsModel currentUserInfo, {
    String? newGoal,
    double? newDesiredWeight,
    double? newWeeklyGoalKg,
    String? newActivityLevel,
  }) {
    final updatedUserInfo = currentUserInfo.copyWith(
      goal: newGoal,
      desiredWeightKg: newDesiredWeight,
      weeklyGoalInKg: newWeeklyGoalKg,
      activityLevel: newActivityLevel,
    );

    return calculateForUser(updatedUserInfo);
  }
}

/// Exception thrown when nutrition calculation fails
class NutritionCalculationException implements Exception {
  final String message;
  final UserInformationsModel userInfo;

  const NutritionCalculationException(this.message, this.userInfo);

  @override
  String toString() => 'NutritionCalculationException: $message';
}

/// Validation result for nutrition plans
class NutritionValidation {
  final bool isHealthy;
  final List<String> warnings;
  final NutritionPlanModel plan;

  const NutritionValidation({
    required this.isHealthy,
    required this.warnings,
    required this.plan,
  });

  /// Whether the plan has any warnings
  bool get hasWarnings => warnings.isNotEmpty;

  /// Get formatted warning message
  String get warningMessage => warnings.join(' ');
}
