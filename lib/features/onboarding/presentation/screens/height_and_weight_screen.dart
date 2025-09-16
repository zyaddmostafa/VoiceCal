import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/helpers/constants.dart';
import '../../../../core/helpers/extention.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/widgets/custom_app_button.dart';
import '../../../../core/widgets/onboarding_header.dart';
import '../../data/models/user_informations_model.dart';
import '../widgets/height_and_weight/height_picker.dart';
import '../widgets/height_and_weight/picker_section.dart';
import '../../../../core/widgets/unit_toggle.dart';
import '../widgets/height_and_weight/weight_picker.dart';
import '../widgets/onboarding_progress_header.dart';

class HeightAndWeightScreen extends StatefulWidget {
  final UserInformationsModel? userInfo;
  const HeightAndWeightScreen({super.key, this.userInfo});

  @override
  State<HeightAndWeightScreen> createState() => _HeightAndWeightScreenState();
}

class _HeightAndWeightScreenState extends State<HeightAndWeightScreen> {
  bool isMetric = true;
  int selectedHeightCm = 170;
  int selectedWeightKg = 70;

  int selectedHeightFt = 5;
  int selectedHeightIn = 7;
  int selectedWeightLb = 154;

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
            children: [
              verticalSpace(Constants.verticalSpaceAfterSafeArea),

              const OnboardingProgressHeader(
                progress: 2 / Constants.onboardingScreensCount,
              ),
              verticalSpace(40),

              const OnboardingHeader(
                title: 'Height & Weight',
                subtitle: 'This will be used to calibrate\nyour custom plan.',
              ),

              verticalSpace(40),

              UnitToggle(isMetric: isMetric, onToggle: _toggleUnit),

              verticalSpace(40),

              Expanded(
                child: Row(
                  children: [
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
    final userInfo = widget.userInfo!.copyWith(
      heightCm: isMetric
          ? selectedHeightCm
          : (selectedHeightFt * 30.48 + selectedHeightIn * 2.54).round(),
      weightKg: isMetric
          ? selectedWeightKg
          : (selectedWeightLb * 0.453592).round(),
      weightLb: isMetric
          ? (selectedWeightKg * 2.20462).round()
          : selectedWeightLb,
      heightFt: isMetric
          ? (selectedHeightCm / 30.48).floor().toDouble()
          : (selectedHeightFt + (selectedHeightIn / 12)).floor().toDouble(),
    );
    log('Height: ${userInfo.heightCm} cm, height: ${userInfo.heightFt} ft');
    context.pushNamed(Routes.ageSelectionScreen, arguments: userInfo);
  }
}
