import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/constants.dart';
import '../../../../core/helpers/extention.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/widgets/custom_app_button.dart';
import '../../../../core/widgets/onboarding_header.dart';
import '../widgets/onboarding_progress_header.dart';
import '../widgets/goal_speed/goal_speed_screen_body.dart';
import '../../data/models/user_informations_model.dart';

class GoalSpeedScreen extends StatefulWidget {
  const GoalSpeedScreen({super.key, this.userInfo});

  final UserInformationsModel? userInfo;

  @override
  State<GoalSpeedScreen> createState() => _GoalSpeedScreenState();
}

class _GoalSpeedScreenState extends State<GoalSpeedScreen> {
  double weeklyGoal = 0.5;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Constants.paddingHorizontal,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const OnboardingProgressHeader(progress: 8 / 13),
              verticalSpace(24),

              const OnboardingHeader(
                title: 'How fast do you want\nto reach your goal?',
                subtitle: 'Select your desired weight loss speed.',
              ),

              const Spacer(),

              GoalSpeedScreenBody(
                onWeightChanged: (weight) {
                  setState(() {
                    weeklyGoal = weight;
                  });
                },
              ),

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
    final userInfo = widget.userInfo!.copyWith(
      weeklyGoalInKg: weeklyGoal,
      weeklyGoalInLb: (weeklyGoal * 2.20462).floor().toDouble(),
    );
    log(
      'Weekly goal set to: ${userInfo.weeklyGoalInLb} - ${userInfo.weeklyGoalInKg}',
    );
    context.pushNamed(Routes.rolloverExtraCalScreen, arguments: userInfo);
  }
}
