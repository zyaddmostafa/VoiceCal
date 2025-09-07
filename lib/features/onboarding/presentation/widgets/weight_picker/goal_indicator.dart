import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';

/// Goal indicator widget showing the current goal type
class GoalIndicator extends StatelessWidget {
  final String goalType;

  const GoalIndicator({super.key, required this.goalType});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Goal: $goalType',
      style: TextStyle(
        fontSize: 17.sp,
        color: AppColors.textSecondary,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
