import 'weight_entry.dart';
import 'daily_nutrition.dart';

class AnalyticsData {
  final List<WeightEntry> weightEntries;
  final List<DailyNutrition> dailyNutrition;

  const AnalyticsData({
    required this.weightEntries,
    required this.dailyNutrition,
  });
}
