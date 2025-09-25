class Meal {
  final String id;
  final String name;
  final String description;
  final MealType type;
  final double calories;
  final double protein;
  final double carbs;
  final double fat;
  final DateTime consumedAt;

  const Meal({
    required this.id,
    required this.name,
    required this.description,
    required this.type,
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fat,
    required this.consumedAt,
  });
}

enum MealType { breakfast, lunch, dinner, snack }
