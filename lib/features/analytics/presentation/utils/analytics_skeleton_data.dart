import '../../data/models/daily_nutrition.dart';
import '../../data/models/weight_entry.dart';

class AnalyticsSkeletonData {
  static List<WeightEntry> getSkeletonWeightData() {
    return List.generate(
      7,
      (index) => WeightEntry(
        weight: 75.0,
        date: DateTime.now().subtract(Duration(days: index)),
        isSelected: index == 0,
      ),
    );
  }

  static List<DailyNutrition> getSkeletonNutritionData() {
    return List.generate(
      7,
      (index) => DailyNutrition(
        date: DateTime.now().subtract(Duration(days: index)),
        protein: 150.0,
        carbs: 200.0,
        fats: 60.0,
      ),
    );
  }
}
