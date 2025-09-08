import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/extention.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/widgets/custom_app_button.dart';
import '../widgets/onboarding_progress_header.dart';
import '../widgets/goal_speed/goal_speed_value.dart';
import '../widgets/goal_speed/goal_speed_slider.dart';
import '../widgets/goal_speed/recommended_chip.dart';
import '../widgets/goal_speed/speed_markers_row.dart';
import '../widgets/goal_speed/speed_icons_row.dart';
import '../../../../core/widgets/unit_toggle.dart';

class GoalSpeedScreen extends StatefulWidget {
  const GoalSpeedScreen({super.key});

  @override
  State<GoalSpeedScreen> createState() => _GoalSpeedScreenState();
}

class _GoalSpeedScreenState extends State<GoalSpeedScreen> {
  double speedLbsPerWeek = 1.0; // default selection
  bool isMetric = false; // default to lbs like previous screen

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const OnboardingProgressHeader(progress: 8 / 10),
              verticalSpace(24),

              Text(
                'How fast do you want\nto reach your goal?',
                style: TextStyle(
                  fontSize: 34.sp,
                  height: 1.12,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.5,
                ),
              ),

              const Spacer(),

              Center(
                child: UnitToggle(
                  isMetric: isMetric,
                  onToggle: (v) => setState(() => isMetric = v),
                ),
              ),
              verticalSpace(40),

              Center(
                child: Text(
                  'Loss weight speed per week',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: const Color(0xFF2C2C2E),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              verticalSpace(8),

              Center(
                child: GoalSpeedValue(
                  value: isMetric ? _lbsToKg(speedLbsPerWeek) : speedLbsPerWeek,
                  unit: isMetric ? 'kg' : 'lbs',
                ),
              ),
              verticalSpace(8),

              const SpeedIconsRow(),
              verticalSpace(8),

              GoalSpeedSlider(
                min: isMetric ? 0.1 : 0.2, // roughly converted bounds
                max: isMetric ? 1.4 : 3.0,
                value: isMetric ? _lbsToKg(speedLbsPerWeek) : speedLbsPerWeek,
                onChanged: (v) => setState(
                  () => speedLbsPerWeek = isMetric ? _kgToLbs(v) : v,
                ),
              ),

              verticalSpace(4),
              SpeedMarkersRow(
                left: isMetric ? '0.1 kg' : '0.2 lbs',
                middle: isMetric ? '0.7 kg' : '1.5 lbs',
                right: isMetric ? '1.4 kg' : '3.0 lbs',
              ),

              verticalSpace(24),
              RecommendedChip(
                value: isMetric ? _lbsToKg(speedLbsPerWeek) : speedLbsPerWeek,
                min: isMetric ? 0.1 : 0.2,
                max: isMetric ? 1.4 : 3.0,
              ),

              const Spacer(flex: 2),

              CustomAppButton(onPressed: _handleContinue),
              verticalSpace(16),
            ],
          ),
        ),
      ),
    );
  }

  void _handleContinue() {
    HapticFeedback.lightImpact();
    context.pushNamed(Routes.rolloverExtraCalScreen);
  }

  double _lbsToKg(double lbs) => lbs * 0.45359237;
  double _kgToLbs(double kg) => kg / 0.45359237;
}
