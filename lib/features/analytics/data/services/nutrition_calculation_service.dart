import '../models/daily_nutrition.dart';

class NutritionCalculationService {
  static double calculateTotalCalories(DailyNutrition nutrition) {
    return (nutrition.protein * 4) +
        (nutrition.carbs * 4) +
        (nutrition.fats * 9);
  }

  static double calculateTotalCaloriesForEntries(List<DailyNutrition> entries) {
    return entries.fold(
      0.0,
      (sum, entry) => sum + calculateTotalCalories(entry),
    );
  }

  static double calculateDailyAverageCalories(List<DailyNutrition> entries) {
    if (entries.isEmpty) return 0;

    return calculateTotalCaloriesForEntries(entries) / entries.length;
  }

  static Map<String, double> calculateMacronutrientTotals(
    List<DailyNutrition> entries,
  ) {
    if (entries.isEmpty) {
      return {'protein': 0, 'carbs': 0, 'fats': 0, 'calories': 0};
    }

    double totalProtein = 0;
    double totalCarbs = 0;
    double totalFats = 0;

    for (final entry in entries) {
      totalProtein += entry.protein;
      totalCarbs += entry.carbs;
      totalFats += entry.fats;
    }

    return {
      'protein': totalProtein,
      'carbs': totalCarbs,
      'fats': totalFats,
      'calories': (totalProtein * 4) + (totalCarbs * 4) + (totalFats * 9),
    };
  }

  static Map<String, double> calculateMacronutrientAverages(
    List<DailyNutrition> entries,
  ) {
    if (entries.isEmpty) {
      return {'protein': 0, 'carbs': 0, 'fats': 0, 'calories': 0};
    }

    final totals = calculateMacronutrientTotals(entries);
    final count = entries.length.toDouble();

    return {
      'protein': totals['protein']! / count,
      'carbs': totals['carbs']! / count,
      'fats': totals['fats']! / count,
      'calories': totals['calories']! / count,
    };
  }

  static double calculatePercentageChange(double oldValue, double newValue) {
    if (oldValue == 0) return 0;

    return ((newValue - oldValue) / oldValue) * 100;
  }

  static DailyNutrition? findHighestCalorieDay(List<DailyNutrition> entries) {
    if (entries.isEmpty) return null;

    DailyNutrition highest = entries.first;
    double highestCalories = calculateTotalCalories(highest);

    for (final entry in entries) {
      final calories = calculateTotalCalories(entry);
      if (calories > highestCalories) {
        highest = entry;
        highestCalories = calories;
      }
    }

    return highest;
  }

  static DailyNutrition? findLowestCalorieDay(List<DailyNutrition> entries) {
    if (entries.isEmpty) return null;

    DailyNutrition lowest = entries.first;
    double lowestCalories = calculateTotalCalories(lowest);

    for (final entry in entries) {
      final calories = calculateTotalCalories(entry);
      if (calories < lowestCalories) {
        lowest = entry;
        lowestCalories = calories;
      }
    }

    return lowest;
  }
}
