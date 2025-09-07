import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';

/// Main value display for goal speed
class GoalSpeedDisplay extends StatelessWidget {
  final double value;
  final String unit;

  const GoalSpeedDisplay({super.key, required this.value, required this.unit});

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      child: Text(
        '${value.toStringAsFixed(1)} $unit',
        key: ValueKey(value),
        style: TextStyle(
          fontSize: 32.sp,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
          letterSpacing: -0.5,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
