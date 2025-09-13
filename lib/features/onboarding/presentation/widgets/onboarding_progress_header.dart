import 'package:flutter/material.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/widgets/app_back_button.dart';
import 'onboarding_progress_line_indicator.dart';

class OnboardingProgressHeader extends StatelessWidget {
  final double progress;
  final Widget? suffixWidget;
  final VoidCallback? onBackPressed;
  const OnboardingProgressHeader({
    super.key,
    required this.progress,
    this.suffixWidget,
    this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppBackButton(onPressed: onBackPressed),
        horizontalSpace(24),
        Expanded(child: OnboardingProgressLineIndicator(progress: progress)),
        if (suffixWidget != null) horizontalSpace(24),
        if (suffixWidget != null) suffixWidget!,
      ],
    );
  }
}
