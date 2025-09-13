import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/helpers/extention.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_app_button.dart';
import '../../data/models/user_informations_model.dart';
import '../widgets/onboarding_progress_header.dart';
import '../widgets/thank_you/privacy_security_card.dart';

class ThankYouScreen extends StatelessWidget {
  final UserInformationsModel? userInfo;

  const ThankYouScreen({super.key, this.userInfo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children: [
              const OnboardingProgressHeader(progress: 9.5 / 10),
              verticalSpace(40),

              const Spacer(),

              Center(
                child: Lottie.asset(
                  'assets/lottie/Love hands.json',
                  repeat: true,
                  animate: true,
                ),
              ),

              verticalSpace(32),

              Text(
                'Thank you for\ntrusting us',
                style: AppTextStyles.font32ExtraBold.copyWith(
                  color: AppColors.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),

              verticalSpace(16),

              Text(
                'Now let\'s personalize Voice Cal for you...',
                style: AppTextStyles.font17RegularSecondary,
                textAlign: TextAlign.center,
              ),

              verticalSpace(32),

              const PrivacySecurityCard(),

              const Spacer(flex: 2),

              CustomAppButton(
                text: 'Continue',
                onPressed: () {
                  context.pushNamed(
                    Routes.resultLoadingScreen,
                    arguments: userInfo,
                  );
                },
              ),

              verticalSpace(16),
            ],
          ),
        ),
      ),
    );
  }
}
