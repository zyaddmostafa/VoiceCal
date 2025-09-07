import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditGoalHeader extends StatelessWidget {
  final String label;

  const EditGoalHeader({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Edit $label Goal',
      style: TextStyle(
        fontSize: 32.sp,
        fontWeight: FontWeight.w700,
        color: const Color(0xFF1D1D1F),
        letterSpacing: -0.5,
      ),
    );
  }
}
