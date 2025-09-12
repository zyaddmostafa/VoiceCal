import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RolloverInfoBadge extends StatelessWidget {
  final int limitCals;
  const RolloverInfoBadge({super.key, required this.limitCals});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F2F7),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: RichText(
        text: TextSpan(
          style: TextStyle(
            fontSize: 14.sp,
            color: const Color(0xFF2C2C2E),
            fontWeight: FontWeight.w600,
          ),
          children: [
            const TextSpan(text: 'Rollover up to '),
            TextSpan(
              text: '$limitCals cals',
              style: const TextStyle(color: Color(0xFF007AFF)),
              recognizer: TapGestureRecognizer()..onTap = () {},
            ),
          ],
        ),
      ),
    );
  }
}
