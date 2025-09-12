import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GoalLabel extends StatelessWidget {
  final String text;
  const GoalLabel({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16.sp,
          color: const Color(0xFF2C2C2E),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
