import '../models/daily_nutrition.dart';
import '../models/grouped_nutrition_data.dart';
import 'nutrition_grouping_service.dart';
import 'nutrition_daily_service.dart';
import 'nutrition_calculation_service.dart';

/// Main processor that delegates to specialized services
class NutritionDataProcessor {
  /// Main entry point for processing nutrition data by period
  static List<GroupedNutritionData> processNutritionData(
    List<DailyNutrition> nutritionData,
    String selectedPeriod,
  ) {
    return NutritionGroupingService.groupByPeriod(
      nutritionData,
      selectedPeriod,
    );
  }

  /// Groups entries by anchored days in a month
  static List<GroupedNutritionData> groupByAnchoredDaysInMonth(
    List<DailyNutrition> data,
    DateTime referenceDate,
    List<int> anchors,
  ) {
    return NutritionDailyService.groupByAnchoredDaysInMonth(
      data,
      referenceDate,
      anchors,
    );
  }

  /// Groups entries by last N days
  static List<GroupedNutritionData> groupByLastNDays(
    List<DailyNutrition> data,
    int days,
  ) {
    return NutritionDailyService.groupByLastNDays(data, days);
  }

  /// Computes week-over-week percentage change in calories
  static double computeWeekOverWeekCaloriesPct(List<DailyNutrition> data) {
    return NutritionDailyService.computeWeekOverWeekCaloriesPct(data);
  }

  /// Calculates total calories for entries
  static double calculateTotalCalories(List<DailyNutrition> entries) {
    return NutritionCalculationService.calculateTotalCaloriesForEntries(
      entries,
    );
  }

  /// Calculates daily average calories
  static double calculateDailyAverageCalories(List<DailyNutrition> entries) {
    return NutritionCalculationService.calculateDailyAverageCalories(entries);
  }

  /// Groups entries by weeks for the specified period
  static List<GroupedNutritionData> groupByWeeks(
    List<DailyNutrition> data,
    String period,
  ) {
    return NutritionGroupingService.groupByWeeks(data, period);
  }
}
