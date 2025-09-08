import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/extention.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/widgets/custom_app_button.dart';
import '../widgets/onboarding_progress_header.dart';
import '../widgets/weight_picker/goal_label.dart';
import '../widgets/weight_picker/weight_value_display.dart';
import '../widgets/weight_picker/weight_ruler.dart';
import '../../../../core/widgets/unit_toggle.dart';

class DesiredWeightScreen extends StatefulWidget {
  final String goal;
  const DesiredWeightScreen({super.key, required this.goal});

  @override
  State<DesiredWeightScreen> createState() => _DesiredWeightScreenState();
}

class _DesiredWeightScreenState extends State<DesiredWeightScreen> {
  bool isMetric = false; // default visually to lbs as in mock
  double selectedWeightLbs = 105.0;

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
              const OnboardingProgressHeader(progress: 7 / 10),
              verticalSpace(24),

              // Title
              Text(
                'What is your\ndesired weight?',
                style: TextStyle(
                  fontSize: 34.sp,
                  height: 1.12,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.5,
                ),
              ),

              const Spacer(),

              // Unit toggle
              Center(
                child: UnitToggle(
                  isMetric: isMetric,
                  onToggle: (v) => setState(() => isMetric = v),
                ),
              ),
              verticalSpace(40),

              GoalLabel(text: widget.goal),
              verticalSpace(8),

              Center(
                child: WeightValueDisplay(
                  value: isMetric
                      ? _lbsToKg(selectedWeightLbs)
                      : selectedWeightLbs,
                  unit: isMetric ? 'kg' : 'lbs',
                ),
              ),

              verticalSpace(16),

              // Ruler
              WeightRuler(
                min: isMetric ? 30 : 60,
                max: isMetric ? 200 : 300,
                initial: isMetric
                    ? _lbsToKg(selectedWeightLbs)
                    : selectedWeightLbs,
                onChanged: (v) => setState(
                  () => selectedWeightLbs = isMetric ? _kgToLbs(v) : v,
                ),
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
    context.pushNamed(Routes.goalSpeedScreen);
  }

  double _lbsToKg(double lbs) => lbs * 0.45359237;
  double _kgToLbs(double kg) => kg / 0.45359237;
}
