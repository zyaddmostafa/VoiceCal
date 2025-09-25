import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/helpers/spacing.dart';

class MealCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String mealName;
  final String description;
  final int calories;
  final VoidCallback onTap;

  const MealCard({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.mealName,
    required this.description,
    required this.calories,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: AppColors.backgroundPrimary,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10.r),
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(icon, color: iconColor, size: 24.sp),
            ),
            horizontalSpace(16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(mealName, style: AppTextStyles.font16MediumBlack),
                  verticalSpace(4),
                  Text(
                    description,
                    style: AppTextStyles.font14RegularSecondary,
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  calories.toString(),
                  style: AppTextStyles.font18SemiBoldPrimary,
                ),
                Text('calories', style: AppTextStyles.font12RegularSecondary),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
