import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/extention.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/custom_app_button.dart';
import '../../../../core/widgets/onboarding_header.dart';
import '../widgets/age_selection/birth_date_picker.dart';
import '../widgets/onboarding_progress_header.dart';

class AgeSelectionScreen extends StatefulWidget {
  const AgeSelectionScreen({super.key});

  @override
  State<AgeSelectionScreen> createState() => _AgeSelectionScreenState();
}

class _AgeSelectionScreenState extends State<AgeSelectionScreen> {
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    final currentYear = DateTime.now().year;
    selectedDate = DateTime(currentYear - 20, 1, 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              const OnboardingProgressHeader(progress: 3 / 10),
              verticalSpace(40),
              const OnboardingHeader(
                title: 'When were you born?',
                subtitle: 'This will be used to calibrate your custom plan.',
              ),
              verticalSpace(40),
              Expanded(
                child: Center(
                  child: BirthDatePicker(
                    initialDate: selectedDate,
                    onDateChanged: (date) {
                      setState(() {
                        selectedDate = date;
                      });
                    },
                  ),
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

  void _handleContinue() {
    HapticFeedback.lightImpact();
    context.pushNamed(Routes.workoutFrequencyScreen);
  }
}
