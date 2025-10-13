import 'package:flutter/material.dart';

import '../../../../auth/data/model/user_profile.dart';
import 'activity_level_selector.dart';
import 'calorie_rollover_switch.dart';
import 'form_divider.dart';
import 'form_text_field.dart';
import 'goal_selector.dart';

class GoalsSection extends StatelessWidget {
  final String? goal;
  final String? activityLevel;
  final bool rolloverCalories;
  final TextEditingController desiredWeightController;
  final TextEditingController weeklyGoalController;
  final UserProfile? currentProfile;
  final ValueChanged<String?> onGoalChanged;
  final ValueChanged<String?> onActivityLevelChanged;
  final ValueChanged<bool> onRolloverChanged;

  const GoalsSection({
    super.key,
    required this.goal,
    required this.activityLevel,
    required this.rolloverCalories,
    required this.desiredWeightController,
    required this.weeklyGoalController,
    this.currentProfile,
    required this.onGoalChanged,
    required this.onActivityLevelChanged,
    required this.onRolloverChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GoalSelector(
          goal: goal,
          currentGoal: currentProfile?.goal,
          onChanged: onGoalChanged,
        ),
        const FormDivider(),
        FormTextField(
          controller: desiredWeightController,
          label: 'Target Weight',
          hint: currentProfile?.desiredWeightInKg != null
              ? '${currentProfile!.desiredWeightInKg} kg'
              : 'Enter target weight',
          keyboardType: TextInputType.number,
          suffix: 'kg',
        ),
        const FormDivider(),
        FormTextField(
          controller: weeklyGoalController,
          label: 'Weekly Goal',
          hint: currentProfile?.weeklyGoalInKg != null
              ? '${currentProfile!.weeklyGoalInKg} kg/week'
              : 'Enter weekly goal',
          keyboardType: TextInputType.number,
          suffix: 'kg/week',
        ),
        const FormDivider(),
        ActivityLevelSelector(
          activityLevel: activityLevel,
          currentActivityLevel: currentProfile?.activityLevel,
          onChanged: onActivityLevelChanged,
        ),
        const FormDivider(),
        CalorieRolloverSwitch(
          value: rolloverCalories,
          onChanged: onRolloverChanged,
        ),
      ],
    );
  }
}
