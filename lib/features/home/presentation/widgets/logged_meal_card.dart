import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../data/models/meal_data.dart';

class LoggedMealCard extends StatelessWidget {
  final MealData meal;

  const LoggedMealCard({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _MealHeaderWidget(meal: meal),
          verticalSpace(12),
          _NutritionSummaryWidget(meal: meal),
          if (meal.ingredients.isNotEmpty) ...[
            verticalSpace(12),
            _IngredientsListWidget(ingredients: meal.ingredients),
          ],
        ],
      ),
    );
  }
}

/// Header with meal name and time
class _MealHeaderWidget extends StatelessWidget {
  final MealData meal;

  const _MealHeaderWidget({required this.meal});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(10.w),
          decoration: BoxDecoration(
            color: AppColors.accent.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Icon(
            Icons.restaurant_rounded,
            color: AppColors.accent,
            size: 24.sp,
          ),
        ),
        horizontalSpace(12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                meal.mealName,
                style: AppTextStyles.font16SemiBoldBlack87,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              verticalSpace(4),
              Text(
                '${meal.mealDate} at ${meal.mealTime}',
                style: AppTextStyles.font12RegularSecondary,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _NutritionSummaryWidget extends StatelessWidget {
  final MealData meal;

  const _NutritionSummaryWidget({required this.meal});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.backgroundSecondary,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _NutrientItem(
            label: 'Calories',
            value: meal.totalCalories.toStringAsFixed(0),
            unit: 'kcal',
          ),
          _NutrientItem(
            label: 'Protein',
            value: meal.totalProtein.toStringAsFixed(1),
            unit: 'g',
          ),
          _NutrientItem(
            label: 'Carbs',
            value: meal.totalCarbs.toStringAsFixed(1),
            unit: 'g',
          ),
          _NutrientItem(
            label: 'Fats',
            value: meal.totalFats.toStringAsFixed(1),
            unit: 'g',
          ),
        ],
      ),
    );
  }
}

/// Single nutrient display item
class _NutrientItem extends StatelessWidget {
  final String label;
  final String value;
  final String unit;

  const _NutrientItem({
    required this.label,
    required this.value,
    required this.unit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: AppTextStyles.font16SemiBoldBlack87),
        Text(unit, style: AppTextStyles.font10MediumGrey),
        Text(label, style: AppTextStyles.font10MediumGrey),
      ],
    );
  }
}

/// List of ingredients
class _IngredientsListWidget extends StatelessWidget {
  final List<Ingredient> ingredients;

  const _IngredientsListWidget({required this.ingredients});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Ingredients', style: AppTextStyles.font14MediumPrimary),
        verticalSpace(8),
        ...ingredients.map(
          (ingredient) => _IngredientItem(ingredient: ingredient),
        ),
      ],
    );
  }
}

/// Single ingredient item
class _IngredientItem extends StatelessWidget {
  final Ingredient ingredient;

  const _IngredientItem({required this.ingredient});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        children: [
          Container(
            width: 6.w,
            height: 6.h,
            decoration: BoxDecoration(
              color: AppColors.accent,
              shape: BoxShape.circle,
            ),
          ),
          horizontalSpace(8),
          Expanded(
            child: Text(
              '${ingredient.name} (${ingredient.quantity})',
              style: AppTextStyles.font12MediumPrimary,
            ),
          ),
          Text(
            '${ingredient.calories.toStringAsFixed(0)} kcal',
            style: AppTextStyles.font12RegularSecondary,
          ),
        ],
      ),
    );
  }
}
