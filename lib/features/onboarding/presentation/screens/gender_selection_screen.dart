import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/extention.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/widgets/custom_app_button.dart';
import '../../../../core/widgets/onboarding_header.dart';
import '../widgets/gender_selection/gender_card.dart';
import '../widgets/onboarding_progress_header.dart';

class GenderSelectionScreen extends StatefulWidget {
  const GenderSelectionScreen({super.key});

  @override
  State<GenderSelectionScreen> createState() => _GenderSelectionScreenState();
}

class _GenderSelectionScreenState extends State<GenderSelectionScreen> {
  String? selectedGender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              const OnboardingProgressHeader(progress: 1 / 10),
              verticalSpace(60),

              const OnboardingHeader(
                title: 'Tell us about you',
                subtitle:
                    'Choose your gender so we can\npersonalize your plan.',
              ),

              SizedBox(height: 80.h),

              // Gender selection cards
              Column(
                children: [
                  GenderCard(
                    gender: 'Male',
                    icon: Icons.male_outlined,
                    isSelected: selectedGender == 'Male',
                    onTap: () => _selectGender('Male'),
                  ),
                  SizedBox(height: 20.h),
                  GenderCard(
                    gender: 'Female',
                    icon: Icons.female_outlined,
                    isSelected: selectedGender == 'Female',
                    onTap: () => _selectGender('Female'),
                  ),
                ],
              ),

              const Spacer(),

              // Continue button
              CustomAppButton(
                isEnabled: selectedGender != null,
                onPressed: _handleContinue,
              ),

              SizedBox(height: 32.h),
            ],
          ),
        ),
      ),
    );
  }

  void _selectGender(String gender) {
    HapticFeedback.lightImpact();
    setState(() {
      selectedGender = gender;
    });
  }

  void _handleContinue() {
    if (selectedGender == null) return;
    HapticFeedback.lightImpact();
    context.pushNamed(Routes.heightAndWeightScreen);
  }
}
