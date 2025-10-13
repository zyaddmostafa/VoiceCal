import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_design_system.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../home/data/models/meal_data.dart';
import 'ingredient_card.dart';

class IngredientsSection extends StatelessWidget {
  final List<Ingredient> ingredients;

  const IngredientsSection({super.key, required this.ingredients});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: AppColors.backgroundPrimary,
        borderRadius: AppDesignSystem.radiusMedium,
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 8,
            offset: Offset(0, 2.h),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Ingredients',
            style: AppTextStyles.font16MediumBlack.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          verticalSpace(16),
          if (ingredients.isEmpty)
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h),
                child: Text(
                  'No ingredients',
                  style: AppTextStyles.font14RegularSecondary,
                ),
              ),
            )
          else
            ...ingredients.map((ingredient) {
              return Padding(
                padding: EdgeInsets.only(bottom: 12.h),
                child: IngredientCard(ingredient: ingredient),
              );
            }).toList(),
        ],
      ),
    );
  }
}
