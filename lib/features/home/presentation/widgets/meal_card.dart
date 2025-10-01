import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_design_system.dart';
import '../../../../core/helpers/spacing.dart';

class MealCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String mealName;
  final String description;
  final int calories;
  final bool isCompleted;
  final VoidCallback onTap;

  const MealCard({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.mealName,
    required this.description,
    required this.calories,
    this.isCompleted = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: AppDesignSystem.radiusLarge,
      child: Container(
        padding: AppDesignSystem.paddingXLarge,
        decoration: isCompleted
            ? AppDesignSystem.accentCard.copyWith(
                border: Border.all(
                  color: iconColor.withValues(alpha: 0.3),
                  width: 1,
                ),
              )
            : AppDesignSystem.elevatedCard,
        child: Row(
          children: [
            Stack(
              children: [
                Container(
                  padding: AppDesignSystem.paddingMedium,
                  decoration: AppDesignSystem.iconContainerGradient(iconColor),
                  child: Icon(icon, color: iconColor, size: 24.sp),
                ),
                if (isCompleted)
                  Positioned(
                    top: -2,
                    right: -2,
                    child: Container(
                      padding: EdgeInsets.all(2.r),
                      decoration: BoxDecoration(
                        color: AppColors.success,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 12.sp,
                      ),
                    ),
                  ),
              ],
            ),
            horizontalSpace(16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    mealName,
                    style: AppTextStyles.font16MediumBlack.copyWith(
                      color: isCompleted
                          ? AppColors.textPrimary
                          : AppColors.textSecondary,
                    ),
                  ),
                  verticalSpace(4),
                  Text(
                    description,
                    style: AppTextStyles.font14RegularSecondary.copyWith(
                      fontStyle: isCompleted
                          ? FontStyle.normal
                          : FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (calories > 0) ...[
                  Text(
                    calories.toString(),
                    style: AppTextStyles.font18SemiBoldPrimary.copyWith(
                      color: iconColor,
                    ),
                  ),
                  Text('calories', style: AppTextStyles.font12RegularSecondary),
                ] else
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 6.h,
                    ),
                    decoration: BoxDecoration(
                      color: iconColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Text(
                      'Add',
                      style: AppTextStyles.font12MediumPrimary.copyWith(
                        color: iconColor,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
