import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/spacing.dart';
import 'achievement_badge_widget.dart';

class AchievementsSectionWidget extends StatelessWidget {
  const AchievementsSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
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
          verticalSpace(16),
          Row(
            children: [
              const AchievementBadgeWidget(emoji: '🔥', title: '7 Day Streak'),
              horizontalSpace(12),
              const AchievementBadgeWidget(emoji: '🎯', title: 'Goal Achieved'),
              horizontalSpace(12),
              const AchievementBadgeWidget(emoji: '📈', title: '5kg Lost'),
            ],
          ),
        ],
      ),
    );
  }
}
