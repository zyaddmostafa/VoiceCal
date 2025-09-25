import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/helpers/spacing.dart';
import 'meal_card.dart';

class MealsSection extends StatelessWidget {
  const MealsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Today\'s Meals', style: AppTextStyles.font18SemiBoldPrimary),
        verticalSpace(16),
        MealCard(
          icon: Icons.wb_sunny_outlined,
          iconColor: const Color(0xFFFFA726),
          mealName: 'Breakfast',
          description: 'Oatmeal with berries',
          calories: 320,
          onTap: () {},
        ),
        verticalSpace(12),
        MealCard(
          icon: Icons.wb_sunny,
          iconColor: const Color(0xFFFFD54F),
          mealName: 'Lunch',
          description: 'Grilled chicken salad',
          calories: 450,
          onTap: () {},
        ),
      ],
    );
  }
}
