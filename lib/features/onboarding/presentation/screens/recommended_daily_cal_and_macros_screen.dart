import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../../core/helpers/extention.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/widgets/custom_app_button.dart';
import '../../../../core/widgets/onboarding_header.dart';
import '../widgets/daily_recommendation/goal_bubble.dart';
import '../widgets/daily_recommendation/recommended_daily_calories_screen_body.dart';
import '../widgets/onboarding_progress_header.dart';
import '../../data/models/user_informations_model.dart';

class RecommendedDailyCalAndMacrosScreen extends StatelessWidget {
  const RecommendedDailyCalAndMacrosScreen({super.key, this.userInfo});

  final UserInformationsModel? userInfo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children: [
              const OnboardingProgressHeader(progress: 1),
              verticalSpace(12),

              GoalBubble(
                goal:
                    'Your Goal: ${userInfo?.goal}  ${userInfo?.weeklyGoalInKg}  kg Per Week',
              ),

              verticalSpace(24),
              const OnboardingHeader(
                title: 'Your Daily Calories & Macros Plan',
                subtitle: 'You can edit this anytime',
              ),
              verticalSpace(40),
              // Macro cards grid
              const RecommendedDailyCaloriesScreenBody(),

              verticalSpace(40),

              CustomAppButton(
                onPressed: () => _handleGetStarted(context),
                text: 'Let\'s Get Started',
              ),
              verticalSpace(32),
            ],
          ),
        ),
      ),
    );
  }

  void _handleGetStarted(BuildContext context) {
    context.pushNamed(Routes.editGoalScreen);
  }
}
