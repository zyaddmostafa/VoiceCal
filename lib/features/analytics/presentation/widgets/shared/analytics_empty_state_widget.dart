import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';

class AnalyticsEmptyStateWidget extends StatelessWidget {
  const AnalyticsEmptyStateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(48.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.analytics_outlined,
              size: 80.sp,
              color: AppColors.textSecondary,
            ),
            verticalSpace(24),
            Text(
              'No Analytics Data Yet',
              style: AppTextStyles.font18SemiBoldBlack,
            ),
            verticalSpace(8),
            Text(
              'Start logging your meals to see\nyour nutrition analytics here',
              textAlign: TextAlign.center,
              style: AppTextStyles.font14RegularSecondary,
            ),
            verticalSpace(24),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.add_circle_outline),
              label: const Text('Log Your First Meal'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
