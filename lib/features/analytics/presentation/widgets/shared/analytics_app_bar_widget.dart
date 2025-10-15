import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/theme/app_text_styles.dart';

class AnalyticsAppBarWidget extends StatelessWidget {
  final double? progressPercent;
  final bool showAchievedBadge;

  const AnalyticsAppBarWidget({
    super.key,
    this.progressPercent,
    this.showAchievedBadge = false,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 16.h),
        child: Row(
          children: [
            Text('Goal Progress', style: AppTextStyles.font18SemiBoldBlack),
            const Spacer(),
            if (progressPercent != null)
              Text(
                '${progressPercent!.toStringAsFixed(0)}%',
                style: AppTextStyles.font16SemiBoldGrey700,
              ),
            if (showAchievedBadge) ...[
              horizontalSpace(8),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: CupertinoColors.systemGreen.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      CupertinoIcons.check_mark_circled_solid,
                      color: CupertinoColors.systemGreen,
                      size: 14.sp,
                    ),
                    horizontalSpace(4),
                    Text(
                      'Goal achieved',
                      style: AppTextStyles.font12SemiBoldGreen700,
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
