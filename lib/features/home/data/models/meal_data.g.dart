// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MealData _$MealDataFromJson(Map<String, dynamic> json) => MealData(
      id: json['id'] as String,
      mealText: json['meal_text'] as String,
      mealName: json['meal_name'] as String,
      mealDate: json['meal_date'] as String,
      mealTime: json['meal_time'] as String,
      totalCalories: (json['total_calories'] as num).toDouble(),
      totalProtein: (json['total_protein'] as num).toDouble(),
      totalCarbs: (json['total_carbs'] as num).toDouble(),
      totalFats: (json['total_fats'] as num).toDouble(),
      ingredients: (json['ingredients'] as List<dynamic>)
          .map((e) => Ingredient.fromJson(e as Map<String, dynamic>))
          .toList(),
      quantity: (json['Qty'] as num).toInt(),
    );

Map<String, dynamic> _$MealDataToJson(MealData instance) => <String, dynamic>{
      'id': instance.id,
      'meal_text': instance.mealText,
      'meal_name': instance.mealName,
      'meal_date': instance.mealDate,
      'meal_time': instance.mealTime,
      'total_calories': instance.totalCalories,
      'total_protein': instance.totalProtein,
      'total_carbs': instance.totalCarbs,
      'total_fats': instance.totalFats,
      'ingredients': instance.ingredients,
      'Qty': instance.quantity,
    };

Ingredient _$IngredientFromJson(Map<String, dynamic> json) => Ingredient(
      name: json['name'] as String,
      quantity: json['quantity'] as String,
      calories: (json['calories'] as num).toDouble(),
      protein: (json['protein'] as num).toDouble(),
      carbs: (json['carbs'] as num).toDouble(),
      fats: (json['fats'] as num).toDouble(),
    );

Map<String, dynamic> _$IngredientToJson(Ingredient instance) =>
    <String, dynamic>{
      'name': instance.name,
      'quantity': instance.quantity,
      'calories': instance.calories,
      'protein': instance.protein,
      'carbs': instance.carbs,
      'fats': instance.fats,
    };
