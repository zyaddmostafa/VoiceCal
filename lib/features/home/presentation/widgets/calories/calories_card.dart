import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_design_system.dart';
import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/widgets/app_linear_progress_indicator.dart';
import 'consumed_calories.dart';
import 'remaining_calories.dart';

class CaloriesCard extends StatelessWidget {
  final int consumed;
  final int goal;

  const CaloriesCard({super.key, required this.consumed, required this.goal});

  @override
  Widget build(BuildContext context) {
    final percentage = (consumed / goal).clamp(0.0, 1.0);
    final remaining = goal - consumed;
    final isOverGoal = consumed > goal;

    return Container(
      padding: AppDesignSystem.paddingXXLarge,
      decoration: AppDesignSystem.primaryCard.copyWith(
        borderRadius: AppDesignSystem.radiusXLarge,
        boxShadow: AppDesignSystem.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ConsumedCalories(consumed: consumed, isOverGoal: isOverGoal),

          verticalSpace(20),

          AppLinearProgressIndicator(
            height: 12.h,
            value: percentage,
            backgroundColor: AppColors.backgroundSecondary,
            progressColor: isOverGoal ? AppColors.error : AppColors.primaryDark,
          ),
          verticalSpace(12),

          RemainingCalories(
            remaining: remaining,
            percentage: percentage,
            isOverGoal: isOverGoal,
          ),
        ],
      ),
    );
  }
}
