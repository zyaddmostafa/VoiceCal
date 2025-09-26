import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'achievement_badge_widget.dart';

class AchievementsSectionWidget extends StatelessWidget {
  const AchievementsSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final spacingWidth = 12.w;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Achievements',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              const AchievementBadgeWidget(emoji: '🔥', title: '7 Day Streak'),
              SizedBox(width: spacingWidth),
              const AchievementBadgeWidget(emoji: '🎯', title: 'Goal Achieved'),
              SizedBox(width: spacingWidth),
              const AchievementBadgeWidget(emoji: '📈', title: '5kg Lost'),
            ],
          ),
        ],
      ),
    );
  }
}
