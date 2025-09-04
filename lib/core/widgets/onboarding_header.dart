import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Reusable onboarding header widget with title and subtitle
class OnboardingHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final Animation<double>? fadeAnimation;

  const OnboardingHeader({
    super.key,
    required this.title,
    required this.subtitle,
    this.fadeAnimation,
  });

  @override
  Widget build(BuildContext context) {
    final content = Column(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 32.sp,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF1D1D1F),
            letterSpacing: -0.5,
            height: 1.1,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 16.h),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 17.sp,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF86868B),
            height: 1.4,
            letterSpacing: -0.2,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );

    return fadeAnimation != null
        ? FadeTransition(opacity: fadeAnimation!, child: content)
        : content;
  }
}
