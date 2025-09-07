import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/extention.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/continue_button.dart';
import '../../../../core/widgets/onboarding_header.dart';
import '../widgets/goal_speed/goal_speed_app_bar.dart';
import '../widgets/goal_speed/goal_speed_display.dart';
import '../widgets/goal_speed/goal_speed_slider.dart';
import '../widgets/goal_speed/slider_labels.dart';

/// Screen for selecting goal weight change speed
class GoalSpeedScreen extends StatefulWidget {
  const GoalSpeedScreen({super.key});

  @override
  State<GoalSpeedScreen> createState() => _GoalSpeedScreenState();
}

class _GoalSpeedScreenState extends State<GoalSpeedScreen> {
  double selectedSpeed = 1.0; // Default recommended speed
  final double minSpeed = 0.2;
  final double maxSpeed = 3.0;
  final String unit = 'lbs';

  bool get isRecommendedRange => selectedSpeed >= 1.0 && selectedSpeed <= 1.5;

  @override
  Widget build(BuildContext context) {
    final spacing40 = SizedBox(height: 40.h);
    final spacing32 = SizedBox(height: 32.h);

    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      appBar: const GoalSpeedAppBar(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              SizedBox(height: 20.h),
              const OnboardingHeader(
                title: 'How fast do you want to reach your goal?',
                subtitle: 'Weight change speed per week',
              ),
              spacing40,
              GoalSpeedDisplay(value: selectedSpeed, unit: unit),
              spacing40,
              GoalSpeedSlider(
                value: selectedSpeed,
                min: minSpeed,
                max: maxSpeed,
                showRecommendedBadge: isRecommendedRange,
                onChanged: (value) => setState(() => selectedSpeed = value),
              ),
              spacing32,
              SliderLabels(minValue: minSpeed, maxValue: maxSpeed, unit: unit),
              const Spacer(),
              ContinueButton(onPressed: _handleContinue),
              spacing32,
            ],
          ),
        ),
      ),
    );
  }

  void _handleContinue() {
    HapticFeedback.lightImpact();
    context.pushNamed(Routes.rolloverExtraCalScreen);
    // print('Selected speed: $selectedSpeed $unit per week');
  }
}
