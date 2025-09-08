import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/extention.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/widgets/custom_app_button.dart';
import '../../../../core/widgets/onboarding_header.dart';
import '../widgets/goal_plan/goal_card.dart';
import '../widgets/goal_plan/goal_plan_data.dart';
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
    final spacing60 = SizedBox(height: 60.h);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.w),
          child: Column(
            children: [
              const OnboardingProgressHeader(progress: 6 / 10),
              SizedBox(height: 40.h),
              // Title and subtitle
              const OnboardingHeader(
                title: 'What\'s your goal?',
                subtitle:
                    'Choose the result you want to achieve so we can personalize your plan.',
              ),

              spacing60,

              // Goal cards
              Expanded(
                child: Column(
                  children: GoalPlanData.goals.map((goal) {
                    return GoalCard(
                      icon: goal['icon'] as IconData,
                      title: goal['title'] as String,
                      description: goal['description'] as String,
                      isSelected: selectedGoal == goal['id'],
                      onTap: () => _selectGoal(goal['id'] as String),
                    );
                  }).toList(),
                ),
              ),

              // Continue button
              CustomAppButton(
                isEnabled: selectedGoal != null,
                onPressed: _handleContinue,
              ),

              SizedBox(height: 32.h),
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
    if (selectedGoal == null) return;

    HapticFeedback.lightImpact();
    context.pushNamed(Routes.desiredWeightScreen, arguments: selectedGoal);
  }
}
