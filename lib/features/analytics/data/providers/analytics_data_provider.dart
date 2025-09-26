import '../../data/models/analytics_data.dart';
import '../../data/models/weight_entry.dart';
import '../../data/models/daily_nutrition.dart';

class AnalyticsDataProvider {
  static AnalyticsData getSampleData() {
    final now = DateTime.now();
    const days5 = Duration(days: 5);
    final date5DaysAgo = now.subtract(days5);

    return AnalyticsData(
      weightEntries: [
        WeightEntry(
          weight: 75.0,
          date: now.subtract(const Duration(days: 30)),
          isSelected: false,
        ),
        WeightEntry(
          weight: 74.5,
          date: now.subtract(const Duration(days: 25)),
          isSelected: false,
        ),
        WeightEntry(
          weight: 74.0,
          date: now.subtract(const Duration(days: 20)),
          isSelected: false,
        ),
        WeightEntry(
          weight: 73.5,
          date: now.subtract(const Duration(days: 15)),
          isSelected: false,
        ),
        WeightEntry(
          weight: 73.0,
          date: now.subtract(const Duration(days: 10)),
          isSelected: false,
        ),
        WeightEntry(weight: 72.5, date: date5DaysAgo, isSelected: true),
      ],
      dailyNutrition: [
        DailyNutrition(
          date: now.subtract(const Duration(days: 6)),
          protein: 45,
          carbs: 65,
          fats: 25,
        ),
        DailyNutrition(date: date5DaysAgo, protein: 50, carbs: 60, fats: 30),
        DailyNutrition(
          date: now.subtract(const Duration(days: 4)),
          protein: 40,
          carbs: 70,
          fats: 20,
        ),
        DailyNutrition(
          date: now.subtract(const Duration(days: 3)),
          protein: 55,
          carbs: 55,
          fats: 35,
        ),
        DailyNutrition(
          date: now.subtract(const Duration(days: 2)),
          protein: 48,
          carbs: 62,
          fats: 28,
        ),
        DailyNutrition(
          date: now.subtract(const Duration(days: 1)),
          protein: 52,
          carbs: 58,
          fats: 32,
        ),
        DailyNutrition(date: now, protein: 47, carbs: 63, fats: 27),
      ],
    );
  }
}
