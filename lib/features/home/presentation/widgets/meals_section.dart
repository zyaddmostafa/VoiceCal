import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/helpers/spacing.dart';
import 'meal_card.dart';

class MealsSection extends StatelessWidget {
  const MealsSection({super.key});

  // Sample user meals data - In real app, this would come from state management
  List<Map<String, dynamic>> get _userMeals => [
    {
      'icon': Icons.restaurant_rounded,
      'iconColor': const Color(0xFF66BB6A),
      'name': 'Grilled Salmon',
      'description': 'Salmon with quinoa & vegetables',
      'calories': 520,
      'isCompleted': true,
    },
    {
      'icon': Icons.local_dining_rounded,
      'iconColor': const Color(0xFF42A5F5),
      'name': 'Mediterranean Bowl',
      'description': 'Chickpeas, feta, olives & greens',
      'calories': 380,
      'isCompleted': false,
    },
  ];

  Widget _buildMealsList() {
    if (_userMeals.isEmpty) {
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
      itemCount: _userMeals.length,
      separatorBuilder: (context, index) => verticalSpace(12),
      itemBuilder: (context, index) {
        final meal = _userMeals[index];

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
