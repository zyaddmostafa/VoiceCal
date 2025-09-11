import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/extention.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/widgets/custom_app_button.dart';
import '../../../../core/widgets/onboarding_header.dart';
import '../../data/models/goal_plan_model.dart';
import '../widgets/goal_plan/goal_card.dart';
import '../widgets/onboarding_progress_header.dart';

class GoalPlanScreen extends StatefulWidget {
  const GoalPlanScreen({super.key});

  @override
  State<GoalPlanScreen> createState() => _GoalPlanScreenState();
}

class _GoalPlanScreenState extends State<GoalPlanScreen> {
  String? selectedGoal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children: [
              const OnboardingProgressHeader(progress: 6 / 10),
              verticalSpace(40),

              const OnboardingHeader(
                title: 'What\'s your goal?',
                subtitle:
                    'Choose the result you want to achieve so we can personalize your plan.',
              ),

              verticalSpace(60),

              Expanded(
                child: Column(
                  children: List.generate(GoalPlanModel.goals.length, (index) {
                    final goal = GoalPlanModel.goals[index];

                    return Padding(
                      padding: EdgeInsets.only(
                        bottom: index == GoalPlanModel.goals.length - 1
                            ? 0
                            : 16.h,
                      ),
                      child: GoalCard(
                        title: goal.title,
                        description: goal.description,
                        icon: goal.icon,
                        isSelected: selectedGoal == goal.id,
                        onTap: () => _selectGoal(goal.id),
                      ),
                    );
                  }),
                ),
              ),

              CustomAppButton(
                isEnabled: selectedGoal != null,
                onPressed: _handleContinue,
              ),

              verticalSpace(32),
            ],
          ),
        ),
      ),
    );
  }

  void _selectGoal(String goalId) {
    HapticFeedback.lightImpact();
    setState(() {
      selectedGoal = goalId;
    });
  }

  void _handleContinue() {
    HapticFeedback.lightImpact();
    context.pushNamed(Routes.desiredWeightScreen, arguments: selectedGoal);
  }
}
