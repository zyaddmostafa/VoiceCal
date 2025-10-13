import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_design_system.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../home/data/models/meal_data.dart';

class IngredientCard extends StatelessWidget {
  final Ingredient ingredient;

  const IngredientCard({super.key, required this.ingredient});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColors.backgroundSecondary,
        borderRadius: AppDesignSystem.radiusSmall,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(ingredient.name, style: AppTextStyles.font14MediumPrimary),
                verticalSpace(4),
                Text(
                  ingredient.quantity,
                  style: AppTextStyles.font12RegularSecondary,
                ),
              ],
            ),
          ),
          horizontalSpace(12),
          Text(
            '${ingredient.calories.toStringAsFixed(0)} cal',
            style: AppTextStyles.font14RegularSecondary,
          ),
        ],
      ),
    );
  }
}
