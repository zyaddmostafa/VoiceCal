import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/extention.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/continue_button.dart';
import '../../../../core/widgets/onboarding_header.dart';
import '../widgets/age_selection/age_selection_app_bar.dart';
import '../widgets/age_selection/birth_date_picker.dart';

/// Screen for selecting birth date and age
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
    // Default to current year - 20 (e.g., 2025 -> 2005)
    final currentYear = DateTime.now().year;
    selectedDate = DateTime(currentYear - 20, 1, 1);
  }

  @override
  Widget build(BuildContext context) {
    final spacing40 = SizedBox(height: 40.h);
    final spacing32 = SizedBox(height: 32.h);

    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      appBar: const AgeSelectionAppBar(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              SizedBox(height: 20.h),
              const OnboardingHeader(
                title: 'When were you born?',
                subtitle: 'This will be used to calibrate your custom plan.',
              ),
              spacing40,
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
              spacing40,
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
    context.pushNamed(Routes.goalSpeedScreen);
    // final age = DateTime.now().year - selectedDate.year;
    // print('Selected birth date: $selectedDate (Age: $age)');
  }
}
