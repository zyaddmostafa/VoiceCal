import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GoalSpeedValue extends StatelessWidget {
  final double value;
  final String unit;
  const GoalSpeedValue({super.key, required this.value, this.unit = 'lbs'});

  @override
  Widget build(BuildContext context) {
    return Text(
      '${value.toStringAsFixed(1)} $unit',
      style: TextStyle(
        fontSize: 32.sp,
        fontWeight: FontWeight.w800,
        letterSpacing: -0.5,
      ),
    );
  }
}
