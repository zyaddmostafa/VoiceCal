import 'package:flutter/material.dart';
import '../../data/models/meal_data.dart';
import 'logged_meal_card.dart';

/// List view of logged meals
class LoggedMealsList extends StatelessWidget {
  final List<MealData> meals;

  const LoggedMealsList({super.key, required this.meals});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: meals.length,
      itemBuilder: (context, index) {
        return LoggedMealCard(meal: meals[index]);
      },
    );
  }
}
