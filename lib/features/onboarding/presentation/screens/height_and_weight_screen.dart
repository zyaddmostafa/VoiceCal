import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/extention.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/widgets/custom_app_button.dart';
import '../../../../core/widgets/onboarding_header.dart';
import '../widgets/height_and_weight/height_picker.dart';
import '../widgets/height_and_weight/picker_section.dart';
import '../../../../core/widgets/unit_toggle.dart';
import '../widgets/height_and_weight/weight_picker.dart';
import '../widgets/onboarding_progress_header.dart';

class HeightAndWeightScreen extends StatefulWidget {
  const HeightAndWeightScreen({super.key});

  @override
  State<HeightAndWeightScreen> createState() => _HeightAndWeightScreenState();
}

class _HeightAndWeightScreenState extends State<HeightAndWeightScreen> {
  bool isMetric = true;

  // Metric values
  int selectedHeightCm = 170;
  int selectedWeightKg = 70;

  // Imperial values
  int selectedHeightFt = 5;
  int selectedHeightIn = 7;
  int selectedWeightLb = 154;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.w),
          child: Column(
            children: [
              const OnboardingProgressHeader(progress: 2 / 10),
              verticalSpace(40),

              // Title and subtitle
              const OnboardingHeader(
                title: 'Height & Weight',
                subtitle: 'This will be used to calibrate\nyour custom plan.',
              ),

              verticalSpace(40),

              // Unit toggle
              UnitToggle(isMetric: isMetric, onToggle: _toggleUnit),

              verticalSpace(40),

              // Pickers
              Expanded(
                child: Row(
                  children: [
                    // Height picker
                    Expanded(
                      child: PickerSection(
                        title: 'Height',
                        child: HeightPicker(
                          isMetric: isMetric,
                          selectedHeightCm: selectedHeightCm,
                          selectedHeightFt: selectedHeightFt,
                          selectedHeightIn: selectedHeightIn,
                          onHeightCmChanged: (value) =>
                              setState(() => selectedHeightCm = value),
                          onHeightFtChanged: (value) =>
                              setState(() => selectedHeightFt = value),
                          onHeightInChanged: (value) =>
                              setState(() => selectedHeightIn = value),
                        ),
                      ),
                    ),
                    horizontalSpace(20),
                    // Weight picker
                    Expanded(
                      child: PickerSection(
                        title: 'Weight',
                        child: WeightPicker(
                          isMetric: isMetric,
                          selectedWeightKg: selectedWeightKg,
                          selectedWeightLb: selectedWeightLb,
                          onWeightKgChanged: (value) =>
                              setState(() => selectedWeightKg = value),
                          onWeightLbChanged: (value) =>
                              setState(() => selectedWeightLb = value),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              verticalSpace(40),

              // Continue button
              CustomAppButton(onPressed: _handleContinue),

              verticalSpace(32),
            ],
          ),
        ),
      ),
    );
  }

  void _toggleUnit(bool value) {
    HapticFeedback.lightImpact();
    setState(() => isMetric = value);
  }

  void _handleContinue() {
    HapticFeedback.lightImpact();
    context.pushNamed(Routes.ageSelectionScreen);
  }
}
