import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_colors.dart';
import 'calorie_display.dart';
import 'calorie_badge.dart';
import 'progress_bar.dart';

class CalorieCard extends StatelessWidget {
  final String title;
  final Color titleColor;
  final int currentCalories;
  final int targetCalories;
  final String badgeText;
  final Color progressColor;
  final bool isAnimated;

  const CalorieCard({
    super.key,
    required this.title,
    required this.titleColor,
    required this.currentCalories,
    required this.targetCalories,
    required this.badgeText,
    required this.progressColor,
    this.isAnimated = true,
  });

  @override
  Widget build(BuildContext context) {
    final progress = currentCalories / targetCalories;
    final spacing16 = SizedBox(height: 16.h);

    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.backgroundPrimary,
        borderRadius: BorderRadius.circular(18.r),
        boxShadow: [
          BoxShadow(
            color: CupertinoColors.systemGrey.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: titleColor,
            ),
          ),
          SizedBox(height: 12.h),
          CalorieDisplay(
            currentCalories: currentCalories,
            targetCalories: targetCalories,
          ),
          spacing16,
          CalorieBadge(text: badgeText),
          spacing16,
          ProgressBar(
            progress: progress,
            color: progressColor,
            isAnimated: isAnimated,
          ),
        ],
      ),
    );
  }
}
