import 'package:flutter/material.dart';
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
    return SliverAppBar(
      pinned: true,
      title: Row(
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
                color: Colors.green[50],
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.check_circle,
                    color: Colors.green[600],
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
    );
  }
}
