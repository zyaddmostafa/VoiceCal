import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/app_colors.dart';

class WelcomeContent extends StatelessWidget {
  const WelcomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Welcome to VoiceCal',
          style: AppTextStyles.displayMedium.copyWith(
            color: AppColors.textPrimary,
            height: 1.05,
          ),
          textAlign: TextAlign.center,
        ),
        verticalSpace(20),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Text(
            'Your personal nutrition assistant.\nTrack your meals, set your goals, and let your voice do the work.',
            style: AppTextStyles.bodyLarge.copyWith(
              color: AppColors.textSecondary,
              height: 1.6,
              letterSpacing: -0.1,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
