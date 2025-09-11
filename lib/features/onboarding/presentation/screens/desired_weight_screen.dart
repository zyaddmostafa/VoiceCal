import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/helpers/extention.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/widgets/custom_app_button.dart';
import '../../../../core/widgets/onboarding_header.dart';
import '../widgets/desired_weight/desired_weight_screen_body.dart';
import '../widgets/onboarding_progress_header.dart';

class DesiredWeightScreen extends StatelessWidget {
  final String goal;
  const DesiredWeightScreen({super.key, required this.goal});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: OnboardingProgressHeader(progress: 7 / 10),
            ),
            verticalSpace(24),

            // Title
            const OnboardingHeader(
              title: 'What\'s your desired weight?',
              subtitle:
                  'Select your target weight to help us create a personalized plan for you.',
            ),

            const Spacer(),

            DesiredWeightScreenBody(goal: goal),

            const Spacer(flex: 2),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: CustomAppButton(onPressed: () => _handleContinue(context)),
            ),
            verticalSpace(16),
          ],
        ),
      ),
    );
  }

  void _handleContinue(BuildContext context) {
    HapticFeedback.lightImpact();
    context.pushNamed(Routes.goalSpeedScreen);
  }
}
