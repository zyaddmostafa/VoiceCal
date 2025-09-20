import 'package:flutter/material.dart';
import '../../../../core/helpers/constants.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../onboarding/presentation/widgets/onboarding_progress_header.dart';
import '../widgets/auth_bloc_listener.dart';
import '../widgets/social_media_auth_body.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Constants.paddingHorizontal,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpace(Constants.verticalSpaceAfterSafeArea),

              const OnboardingProgressHeader(
                progress: 13 / Constants.onboardingScreensCount,
              ),
              verticalSpace(16),

              Text(
                'Save your progress',
                style: AppTextStyles.font32BoldPrimary,
              ),
              const Spacer(),
              const SocialMediaAuthBody(),
              const Spacer(),
              const AuthBlocListener(),
            ],
          ),
        ),
      ),
    );
  }
}
