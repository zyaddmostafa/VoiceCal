import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/helpers/spacing.dart';
import 'meal_card.dart';

class MealsSection extends StatelessWidget {
  final List<Map<String, dynamic>> meals;

  const MealsSection({super.key, required this.meals});

  Widget _buildMealsList() {
    if (meals.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(20.r),
              decoration: BoxDecoration(
                color: AppColors.backgroundSecondary,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Icon(
                Icons.restaurant_menu_rounded,
                size: 48.sp,
                color: AppColors.primaryBlack.withValues(alpha: 0.3),
              ),
            ),
            verticalSpace(16),
            Text(
              'No meals added yet',
              style: AppTextStyles.font16MediumBlack.copyWith(
                color: AppColors.primaryBlack.withValues(alpha: 0.6),
              ),
            ),
            verticalSpace(8),
            Text(
              'Start tracking your nutrition',
              style: AppTextStyles.font14RegularSecondary.copyWith(
                color: AppColors.primaryBlack.withValues(alpha: 0.4),
              ),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      itemCount: meals.length,
      separatorBuilder: (context, index) => verticalSpace(12),
      itemBuilder: (context, index) {
        final meal = meals[index];

        return MealCard(
          icon: meal['icon'],
          iconColor: meal['iconColor'],
          mealName: meal['name'],
          description: meal['description'],
          calories: meal['calories'],
          isCompleted: meal['isCompleted'],
          onTap: () {
            // Handle meal tap - view details, edit, etc.
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Recently Logged Meals', style: AppTextStyles.font16MediumBlack),
        verticalSpace(20),
        Expanded(
          child: Column(
            children: [
              // User's added meals
              Expanded(child: _buildMealsList()),
            ],
          ),
        ),
      ],
    );
  }
}
