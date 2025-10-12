import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_design_system.dart';
import '../../../../core/theme/app_text_styles.dart';

class MacroCard extends StatelessWidget {
  final String label;
  final String value;
  final String emoji;
  final Color color;

  const MacroCard({
    super.key,
    required this.label,
    required this.value,
    required this.emoji,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
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
          Row(
            children: [
              Text(emoji, style: TextStyle(fontSize: 16.sp)),
              horizontalSpace(4),
              Text(
                label,
                style: AppTextStyles.font12RegularSecondary.copyWith(
                  fontSize: 11.sp,
                ),
              ),
            ],
          ),
          verticalSpace(8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value,
                style: AppTextStyles.font20SemiBoldPrimary.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text('g', style: AppTextStyles.font14RegularSecondary),
            ],
          ),
        ],
      ),
    );
  }
}
