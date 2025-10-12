import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class BottomActions extends StatelessWidget {
  final VoidCallback onFixResults;
  final VoidCallback onDone;

  const BottomActions({
    super.key,
    required this.onFixResults,
    required this.onDone,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColors.backgroundPrimary,
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 12,
            offset: Offset(0, -2.h),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            // Fix Results button
            Expanded(
              child: InkWell(
                onTap: onFixResults,
                borderRadius: BorderRadius.circular(22.r),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  decoration: BoxDecoration(
                    color: AppColors.backgroundPrimary,
                    border: Border.all(color: AppColors.border, width: 1.5),
                    borderRadius: BorderRadius.circular(22.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.auto_fix_high,
                        color: AppColors.textPrimary,
                        size: 18.sp,
                      ),
                      horizontalSpace(6),
                      Text(
                        'Fix Results',
                        style: AppTextStyles.font14MediumPrimary,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            horizontalSpace(10),
            // Done button
            Expanded(
              child: InkWell(
                onTap: onDone,
                borderRadius: BorderRadius.circular(22.r),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  decoration: BoxDecoration(
                    color: AppColors.primaryBlack,
                    borderRadius: BorderRadius.circular(22.r),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primaryBlack.withValues(alpha: 0.2),
                        blurRadius: 8,
                        offset: Offset(0, 2.h),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      'Done',
                      style: AppTextStyles.font14SemiBoldWhite.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
