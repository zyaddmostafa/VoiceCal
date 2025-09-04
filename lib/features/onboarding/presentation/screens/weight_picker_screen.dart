import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
  int selectedWeight = 70; // Default goal weight
  final int minWeight = 40;
  final int maxWeight = 150;
  final String unit = 'kg';

  @override
  Widget build(BuildContext context) {
    final spacing40 = SizedBox(height: 40.h);
    final spacing20 = SizedBox(height: 20.h);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const WeightPickerAppBar(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              spacing20,
              const OnboardingHeader(
                title: 'What\'s your goal weight?',
                subtitle: 'Set a realistic target that works for you.',
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
      selectedWeight = weight;
    });
  }

  void _handleContinue() {
    HapticFeedback.lightImpact();
    // TODO: Navigate to next screen
    // print('Selected goal weight: $selectedWeight $unit');

    // Navigate to next screen
    // context.pushNamed(Routes.nextScreen);
  }
}
