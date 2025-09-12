import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/helpers/extention.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/widgets/custom_app_button.dart';
import '../../../../core/widgets/onboarding_header.dart';
import '../../data/models/user_informations_model.dart';
import '../widgets/desired_weight/desired_weight_screen_body.dart';
import '../widgets/onboarding_progress_header.dart';

class DesiredWeightScreen extends StatefulWidget {
  final UserInformationsModel? userInfo;
  const DesiredWeightScreen({super.key, required this.userInfo});

  @override
  State<DesiredWeightScreen> createState() => _DesiredWeightScreenState();
}

class _DesiredWeightScreenState extends State<DesiredWeightScreen> {
  double selectedWeight = 47.6;
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

            DesiredWeightScreenBody(
              goal: widget.userInfo?.goal ?? '',
              onWeightChanged: (weight) {
                setState(() {
                  selectedWeight = weight;
                });
                log('Desired weight changed: $selectedWeight');
              },
            ),

            const Spacer(flex: 2),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: CustomAppButton(
                onPressed: () => _handleContinue(context, widget.userInfo!),
                text: 'Continue',
              ),
            ),
            verticalSpace(16),
          ],
        ),
      ),
    );
  }

  void _handleContinue(
    BuildContext context,
    UserInformationsModel userInformation,
  ) {
    final userInfo = userInformation.copyWith(desiredWeightKg: selectedWeight);

    log('user desired weight: ${userInfo.desiredWeightKg} - ${userInfo.goal}');
    HapticFeedback.lightImpact();

    context.pushNamed(Routes.goalSpeedScreen, arguments: userInfo);
  }
}
