import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/extention.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/widgets/custom_app_button.dart';
import '../../../../core/widgets/onboarding_header.dart';
import '../widgets/onboarding_progress_header.dart';
import '../widgets/goal_speed/goal_speed_screen_body.dart';

class GoalSpeedScreen extends StatelessWidget {
  const GoalSpeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const OnboardingProgressHeader(progress: 8 / 10),
              verticalSpace(24),

              const OnboardingHeader(
                title: 'How fast do you want\nto reach your goal?',
                subtitle: 'Select your desired weight loss speed.',
              ),

              const Spacer(),

              const GoalSpeedScreenBody(),

              const Spacer(flex: 2),

              CustomAppButton(onPressed: () => _handleContinue(context)),
              verticalSpace(16),
            ],
          ),
        ),
      ),
    );
  }

  void _handleContinue(BuildContext context) {
    HapticFeedback.lightImpact();
    context.pushNamed(Routes.rolloverExtraCalScreen);
  }
}
