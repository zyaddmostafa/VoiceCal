import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/extention.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/widgets/continue_button.dart';
import '../../../../core/widgets/onboarding_header.dart';
import '../widgets/weight_picker/goal_indicator.dart';
import '../widgets/weight_picker/horizontal_weight_picker.dart';
import '../widgets/weight_picker/weight_display.dart';
import '../widgets/weight_picker/weight_picker_app_bar.dart';

/// Weight picker screen for goal weight selection
class WeightPickerScreen extends StatefulWidget {
  const WeightPickerScreen({super.key});

  @override
  State<WeightPickerScreen> createState() => _WeightPickerScreenState();
}

class _WeightPickerScreenState extends State<WeightPickerScreen> {
  double selectedWeight = 105.0; // Default goal weight
  final double minWeight = 60.0;
  final double maxWeight = 350.0;
  final String unit = 'lbs';

  @override
  Widget build(BuildContext context) {
    final spacing40 = SizedBox(height: 40.h);
    final spacing20 = SizedBox(height: 20.h);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const WeightPickerAppBar(progress: 0.3),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              spacing20,
              const OnboardingHeader(
                title: 'What is your desired weight?',
                subtitle: '',
              ),
              spacing40,
              const GoalIndicator(goalType: 'Lose weight'),
              spacing40,
              WeightDisplay(weight: selectedWeight, unit: unit),
              spacing40,
              Expanded(
                child: HorizontalWeightPicker(
                  initialWeight: selectedWeight,
                  minWeight: minWeight,
                  maxWeight: maxWeight,
                  unit: unit,
                  onWeightChanged: _onWeightChanged,
                ),
              ),
              spacing40,
              ContinueButton(onPressed: _handleContinue),
              SizedBox(height: 32.h),
            ],
          ),
        ),
      ),
    );
  }

  void _onWeightChanged(int weight) {
    setState(() {
      selectedWeight = weight.toDouble();
    });
  }

  void _handleContinue() {
    HapticFeedback.lightImpact();
    // TODO: Navigate to next screen
    // print('Selected goal weight: $selectedWeight $unit');

    // Navigate to next screen
    context.pushNamed(Routes.goalSpeedScreen);
  }
}
