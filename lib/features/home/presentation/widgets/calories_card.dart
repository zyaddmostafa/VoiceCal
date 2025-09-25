import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/helpers/spacing.dart';

class CaloriesCard extends StatelessWidget {
  final int consumed;
  final int goal;

  const CaloriesCard({super.key, required this.consumed, required this.goal});

  @override
  Widget build(BuildContext context) {
    final percentage = (consumed / goal).clamp(0.0, 1.0);
    final remaining = goal - consumed;

    return Container(
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: AppColors.backgroundPrimary,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Calories', style: AppTextStyles.font18SemiBoldPrimary),
              Text(
                'Daily Goal: ${goal.toStringAsFixed(0)}',
                style: AppTextStyles.font12RegularSecondary,
              ),
            ],
          ),
          verticalSpace(16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                consumed.toStringAsFixed(0),
                style: AppTextStyles.font32BoldPrimary,
              ),
              horizontalSpace(8),
              Text(
                'calories consumed',
                style: AppTextStyles.font12RegularSecondary,
              ),
            ],
          ),
          verticalSpace(16),
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: LinearProgressIndicator(
              value: percentage,
              backgroundColor: AppColors.divider,
              valueColor: const AlwaysStoppedAnimation<Color>(
                AppColors.primaryBlack,
              ),
              minHeight: 8.h,
            ),
          ),
          verticalSpace(8),
          Text(
            '${remaining > 0 ? remaining : 0} calories remaining',
            style: AppTextStyles.font12RegularSecondary,
          ),
        ],
      ),
    );
  }
}
