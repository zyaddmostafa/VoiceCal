import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/app_text_styles.dart';

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
          style: AppTextStyles.font32BoldPrimary,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 16.h),
        Text(
          subtitle,
          style: AppTextStyles.font17RegularSecondary,
          textAlign: TextAlign.center,
        ),
      ],
    );

    return fadeAnimation != null
        ? FadeTransition(opacity: fadeAnimation!, child: content)
        : content;
  }
}
