import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class OnboardingProgressLineIndicator extends StatelessWidget {
  final double progress;
  const OnboardingProgressLineIndicator({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      value: progress,
      backgroundColor: Colors.grey[300],
      valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primaryBlack),
    );
  }
}
