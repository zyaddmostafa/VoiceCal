import 'package:json_annotation/json_annotation.dart';
part 'meal_data.g.dart';

@JsonSerializable()
class MealData {
  final String id;
  @JsonKey(name: 'meal_text')
  final String mealText;
  @JsonKey(name: 'meal_name')
  final String mealName;
  @JsonKey(name: 'meal_date')
  final String mealDate;
  @JsonKey(name: 'meal_time')
  final String mealTime;
  @JsonKey(name: 'total_calories')
  final double totalCalories;
  @JsonKey(name: 'total_protein')
  final double totalProtein;
  @JsonKey(name: 'total_carbs')
  final double totalCarbs;
  @JsonKey(name: 'total_fats')
  final double totalFats;
  final List<Ingredient> ingredients;

  MealData({
    required this.id,
    required this.mealText,
    required this.mealName,
    required this.mealDate,
    required this.mealTime,
    required this.totalCalories,
    required this.totalProtein,
    required this.totalCarbs,
    required this.totalFats,
    required this.ingredients,
  });

  factory MealData.fromJson(Map<String, dynamic> json) =>
      _$MealDataFromJson(json);

  Map<String, dynamic> toJson() => _$MealDataToJson(this);
}

@JsonSerializable()
class Ingredient {
  final String name;
  final String quantity;
  final double calories;
  final double protein;
  final double carbs;
  final double fats;

  Ingredient({
    required this.name,
    required this.quantity,
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fats,
  });

  factory Ingredient.fromJson(Map<String, dynamic> json) =>
      _$IngredientFromJson(json);

  Map<String, dynamic> toJson() => _$IngredientToJson(this);
}
