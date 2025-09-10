import 'package:flutter/material.dart';

import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/theme/app_text_styles.dart';

class WelcomeContent extends StatelessWidget {
  const WelcomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Welcome to VoiceCal',
          style: AppTextStyles.font32Bold,
          textAlign: TextAlign.center,
        ),
        verticalSpace(16),
        Text(
          'Your personal nutrition assistant.\nTrack your meals, set your goals, and let your voice do the work.',
          style: AppTextStyles.font17RegularSecondary,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
