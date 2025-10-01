import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/helpers/spacing.dart';

class MacroItem extends StatelessWidget {
  final String label;
  final String value;
  final String sublabel;
  final Color color;
  final double progress;

  const MacroItem({
    super.key,
    required this.label,
    required this.value,
    required this.sublabel,
    required this.color,
    this.progress = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 6.w),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.backgroundPrimary,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: AppColors.divider.withValues(alpha: 0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: Offset(0, 3.h),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 8.w,
                height: 8.h,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
              horizontalSpace(8),
              Text(label, style: AppTextStyles.font12MediumPrimary),
            ],
          ),
          verticalSpace(12),
          Text(
            value,
            style: AppTextStyles.font18SemiBoldPrimary.copyWith(color: color),
          ),
          verticalSpace(4),
          Text(sublabel, style: AppTextStyles.font12RegularSecondary),
          verticalSpace(12),
          Container(
            height: 6.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3.r),
              color: AppColors.backgroundSecondary,
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: progress.clamp(0.0, 1.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3.r),
                  color: color,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
