import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class MealHeader extends StatelessWidget {
  final String mealName;
  final String mealQuantity;
  final VoidCallback? onQuantityTap;
  final VoidCallback? onRemove;

  const MealHeader({
    super.key,
    required this.mealName,
    required this.mealQuantity,
    this.onQuantityTap,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: Row(
        children: [
          Expanded(
            child: Text(
              mealName,
              style: AppTextStyles.font20SemiBoldPrimary.copyWith(
                fontSize: 22.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          horizontalSpace(12),
          GestureDetector(
            onTap: onQuantityTap,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.border, width: 1.5),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(mealQuantity, style: AppTextStyles.font16MediumBlack),
                  horizontalSpace(4),
                  Icon(Icons.edit, size: 16.sp, color: AppColors.textPrimary),
                ],
              ),
            ),
          ),
          horizontalSpace(12),
          GestureDetector(
            onTap: onRemove,
            child: Container(
              padding: EdgeInsets.all(8.r),
              decoration: BoxDecoration(
                color: Colors.red.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Icon(Icons.delete_outline, size: 20.sp, color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
