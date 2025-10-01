import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_design_system.dart';
import '../../../../core/helpers/spacing.dart';

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
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                consumed.toStringAsFixed(0),
                style: AppTextStyles.font32BoldPrimary.copyWith(
                  color: isOverGoal ? AppColors.error : AppColors.textPrimary,
                ),
              ),
              horizontalSpace(8),
              Text(
                'calories consumed',
                style: AppTextStyles.font12RegularSecondary,
              ),
            ],
          ),
          verticalSpace(20),
          Container(
            height: 12.h,
            decoration: BoxDecoration(
              color: AppColors.backgroundSecondary,
              borderRadius: BorderRadius.circular(6.r),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6.r),
              child: LinearProgressIndicator(
                value: percentage,
                backgroundColor: Colors.transparent,
                valueColor: AlwaysStoppedAnimation<Color>(
                  isOverGoal ? AppColors.error : AppColors.success,
                ),
              ),
            ),
          ),
          verticalSpace(12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${remaining > 0 ? remaining : 0} calories remaining',
                style: AppTextStyles.font12RegularSecondary,
              ),
              Text(
                '${(percentage * 100).toInt()}%',
                style: AppTextStyles.font12MediumPrimary.copyWith(
                  color: isOverGoal ? AppColors.error : AppColors.success,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
