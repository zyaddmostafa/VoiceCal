class GroupedNutritionData {
  final String label;
  final double protein;
  final double carbs;
  final double fats;
  final DateTime startDate;
  final DateTime endDate;

  GroupedNutritionData({
    required this.label,
    required this.protein,
    required this.carbs,
    required this.fats,
    required this.startDate,
    required this.endDate,
  });

  double get totalCalories => (protein * 4) + (carbs * 4) + (fats * 9);
}
