import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';
import 'user_metrics_display.dart';

class UserMetricsSection extends StatelessWidget {
  final String age;
  final String height;
  final String currentWeight;

  const UserMetricsSection({
    super.key,
    required this.age,
    required this.height,
    required this.currentWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.backgroundPrimary,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.border, width: 0.5),
      ),
      child: UserMetricsDisplay(
        age: age,
        height: height,
        currentWeight: currentWeight,
      ),
    );
  }
}
