import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/helpers/extention.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/widgets/custom_app_button.dart';
import '../../../../core/widgets/onboarding_header.dart';
import '../../data/models/user_informations_model.dart';
import '../widgets/onboarding_progress_header.dart';
import '../widgets/workout_frequency/activity_level_card.dart';
import '../widgets/workout_frequency/activity_level_data.dart';

class WorkoutFrequencyScreen extends StatefulWidget {
  final UserInformationsModel? userInfo;
  const WorkoutFrequencyScreen({super.key, this.userInfo});

  @override
  State<WorkoutFrequencyScreen> createState() => _WorkoutFrequencyScreenState();
}

class _WorkoutFrequencyScreenState extends State<WorkoutFrequencyScreen> {
  String? selectedActivityLevel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children: [
              const OnboardingProgressHeader(progress: 5 / 10),
              verticalSpace(40),

              const OnboardingHeader(
                title: 'What\'s your Workout frequency?',
                subtitle:
                    'Select your typical activity level so we can adjust your plan.',
              ),

              verticalSpace(40),

              Expanded(
                child: ListView.builder(
                  itemCount: ActivityLevelData.levels.length,
                  itemBuilder: (context, index) {
                    final level = ActivityLevelData.levels[index];

                    return ActivityLevelCard(
                      activityLevel: level,
                      isSelected: selectedActivityLevel == level.id,
                      onTap: () => _selectActivityLevel(level.id),
                    );
                  },
                ),
              ),

              CustomAppButton(
                isEnabled: selectedActivityLevel != null,
                onPressed: _handleContinue,
              ),

              verticalSpace(32),
            ],
          ),
        ),
      ),
    );
  }

  void _selectActivityLevel(String levelId) {
    HapticFeedback.lightImpact();
    setState(() {
      selectedActivityLevel = levelId;
      log('Selected activity level: $selectedActivityLevel');
    });
  }

  void _handleContinue() {
    if (selectedActivityLevel == null) return;
    final userInfo = widget.userInfo?.copyWith(
      activityLevel: selectedActivityLevel,
    );
    log(
      'User Info: ${userInfo!.activityLevel} - ${userInfo.isMale! ? 'Male' : 'Female'}',
    );
    HapticFeedback.lightImpact();
    context.pushNamed(Routes.goalPlanScreen, arguments: userInfo);
  }
}
