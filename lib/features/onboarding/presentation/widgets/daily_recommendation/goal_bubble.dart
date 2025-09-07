import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Goal bubble widget displaying the user's target goal with date
class GoalBubble extends StatelessWidget {
  final String goal;

  const GoalBubble({super.key, required this.goal});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F2F7),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        goal,
        style: TextStyle(
          fontSize: 15.sp,
          fontWeight: FontWeight.w500,
          color: const Color(0xFF1D1D1F),
          letterSpacing: -0.2,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
