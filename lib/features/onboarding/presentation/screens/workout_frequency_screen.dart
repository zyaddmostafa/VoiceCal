import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/extention.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/widgets/continue_button.dart';
import '../../../../core/widgets/onboarding_header.dart';
import '../widgets/workout_frequency/activity_level_card.dart';
import '../widgets/workout_frequency/activity_level_data.dart';

class WorkoutFrequencyScreen extends StatefulWidget {
  const WorkoutFrequencyScreen({super.key});

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
          padding: EdgeInsets.symmetric(horizontal: 32.w),
          child: Column(
            children: [
              SizedBox(height: 60.h),

              // Title and subtitle
              const OnboardingHeader(
                title: 'What\'s your Workout frequency?',
                subtitle:
                    'Select your typical activity level so we can adjust your plan.',
              ),

              SizedBox(height: 40.h),

              // Activity level cards
              Expanded(
                child: ListView.builder(
                  itemCount: ActivityLevelData.levels.length,
                  itemBuilder: (context, index) {
                    final level = ActivityLevelData.levels[index];
                    return ActivityLevelCard(
                      emoji: level['emoji']!,
                      title: level['title']!,
                      description: level['description']!,
                      isSelected: selectedActivityLevel == level['id'],
                      onTap: () => _selectActivityLevel(level['id']!),
                    );
                  },
                ),
              ),

              // Continue button
              ContinueButton(
                isEnabled: selectedActivityLevel != null,
                onPressed: _handleContinue,
              ),

              SizedBox(height: 32.h),
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
    });
  }

  void _handleContinue() {
    if (selectedActivityLevel == null) return;

    HapticFeedback.lightImpact();
    log('Selected activity level: $selectedActivityLevel');
    context.pushNamed(Routes.goalPlanScreen);
  }
}
