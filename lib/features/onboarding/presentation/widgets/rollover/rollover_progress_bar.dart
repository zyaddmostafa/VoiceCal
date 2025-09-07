import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Progress bar widget for onboarding flow
class RolloverProgressBar extends StatelessWidget {
  final double progress;

  const RolloverProgressBar({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 4.h,
      decoration: BoxDecoration(
        color: const Color(0xFFE5E5E7),
        borderRadius: BorderRadius.circular(2.r),
      ),
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: progress.clamp(0.0, 1.0),
        child: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF007AFF), Color(0xFF5AC8FA)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(2.r),
          ),
        ),
      ),
    );
  }
}
