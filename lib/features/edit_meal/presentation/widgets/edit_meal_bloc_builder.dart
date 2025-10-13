import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../home/data/models/meal_data.dart';
import '../cubit/edit_meal_cubit.dart';
import 'bottom_actions.dart';
import 'calories_card.dart';
import 'ingredients_section.dart';
import 'macros_row.dart';
import 'meal_header.dart';

class EditMealBlocBuilder extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final String mealName;
  final String mealQuantity;
  final String calories;
  final String protein;
  final String carbs;
  final String fats;
  final List<Ingredient> ingredients;
  final VoidCallback onQuantityTap;
  final VoidCallback onRemove;
  final VoidCallback onFixResults;
  final VoidCallback onDone;

  const EditMealBlocBuilder({
    super.key,
    required this.formKey,
    required this.mealName,
    required this.mealQuantity,
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fats,
    required this.ingredients,
    required this.onQuantityTap,
    required this.onRemove,
    required this.onFixResults,
    required this.onDone,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditMealCubit, EditMealState>(
      builder: (context, state) {
        if (state is EditMealLoading) {
          return Center(child: CupertinoActivityIndicator(radius: 14.r));
        }

        return Stack(
          children: [
            Form(
              key: formKey,
              child: ListView(
                padding: EdgeInsets.only(
                  left: 20.w,
                  right: 20.w,
                  top: 0,
                  bottom: 100.h, // Space for bottom buttons
                ),
                children: [
                  MealHeader(
                    mealName: mealName,
                    mealQuantity: mealQuantity,
                    onQuantityTap: onQuantityTap,
                    onRemove: onRemove,
                  ),
                  verticalSpace(24),
                  CaloriesCard(calories: calories),
                  verticalSpace(16),
                  MacrosRow(protein: protein, carbs: carbs, fats: fats),
                  verticalSpace(24),
                  IngredientsSection(ingredients: ingredients),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: BottomActions(onFixResults: onFixResults, onDone: onDone),
            ),
          ],
        );
      },
    );
  }
}
