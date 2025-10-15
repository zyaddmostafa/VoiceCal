import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/widgets/app_linear_progress_indicator.dart';

class MacroItem extends StatelessWidget {
  final String label;
  final String value;
  final String sublabel;
  final Color color;
  final double progress;
  final String svgAsset;

  const MacroItem({
    super.key,
    required this.label,
    required this.value,
    required this.sublabel,
    required this.color,
    required this.svgAsset,
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
            color: CupertinoColors.black.withOpacity(0.06),
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
              SvgPicture.asset(
                svgAsset,
                width: 16.w,
                height: 16.h,
                colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
              ),
              horizontalSpace(8),
              Text(label, style: AppTextStyles.font12MediumPrimary),
            ],
          ),
          verticalSpace(12),
          Text(value, style: AppTextStyles.font18SemiBoldPrimary),
          verticalSpace(4),
          Text(sublabel, style: AppTextStyles.font12RegularSecondary),

          verticalSpace(12),

          AppLinearProgressIndicator(
            value: progress,
            backgroundColor: AppColors.backgroundSecondary,
            progressColor: color,
            height: 6.h,
            borderRadius: BorderRadius.circular(6.r),
          ),
        ],
      ),
    );
  }
}
