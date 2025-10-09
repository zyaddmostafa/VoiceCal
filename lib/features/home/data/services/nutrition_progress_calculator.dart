import '../../data/models/meal_data.dart';

class NutritionProgressCalculator {
  static double getTotalCalories(List<MealData> meals) {
    return meals.fold(0.0, (sum, meal) => sum + meal.totalCalories);
  }

  static double getTotalProtein(List<MealData> meals) {
    return meals.fold(0.0, (sum, meal) => sum + meal.totalProtein);
  }

  static double getTotalCarbs(List<MealData> meals) {
    return meals.fold(0.0, (sum, meal) => sum + meal.totalCarbs);
  }

  static double getTotalFats(List<MealData> meals) {
    return meals.fold(0.0, (sum, meal) => sum + meal.totalFats);
  }

  static double calculateProgress(double consumed, double goal) {
    if (goal <= 0) return 0.0;

    return consumed / goal;
  }

  static double calculateRemaining(double consumed, double goal) {
    return goal - consumed;
  }
}
