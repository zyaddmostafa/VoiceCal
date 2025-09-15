class CaloriesAndMacrosModel {
  final num? calories;
  final num? protein;
  final num? carbs;
  final num? fats;

  CaloriesAndMacrosModel({
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fats,
  });

  CaloriesAndMacrosModel copyWith({
    num? calories,
    num? protein,
    num? carbs,
    num? fats,
  }) {
    return CaloriesAndMacrosModel(
      calories: calories ?? this.calories,
      protein: protein ?? this.protein,
      carbs: carbs ?? this.carbs,
      fats: fats ?? this.fats,
    );
  }
}
