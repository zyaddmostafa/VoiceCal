import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/constants.dart';
import '../../../../core/helpers/extention.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/widgets/custom_app_button.dart';
import '../../../../core/widgets/onboarding_header.dart';
import '../../data/models/user_informations_model.dart';
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
          padding: const EdgeInsets.symmetric(
            horizontal: Constants.paddingHorizontal,
          ),
          child: Column(
            children: [
              verticalSpace(Constants.verticalSpaceAfterSafeArea),
              const OnboardingProgressHeader(
                progress: 1 / Constants.onboardingScreensCount,
              ),
              verticalSpace(60),

              const OnboardingHeader(
                title: 'Tell us about you',
                subtitle:
                    'Choose your gender so we can\npersonalize your plan.',
              ),

              verticalSpace(80),
              Column(
                children: [
                  GenderCard(
                    gender: 'Male',
                    icon: Icons.male_outlined,
                    isSelected: selectedGender == 'Male',
                    onTap: () => _selectGender('Male'),
                  ),
                  verticalSpace(20),
                  GenderCard(
                    gender: 'Female',
                    icon: Icons.female_outlined,
                    isSelected: selectedGender == 'Female',
                    onTap: () => _selectGender('Female'),
                  ),
                ],
              ),

              const Spacer(),

              CustomAppButton(
                isEnabled: selectedGender != null,
                onPressed: _handleContinue,
              ),

              verticalSpace(32),
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
    final userInfo = UserInformationsModel(isMale: selectedGender == 'Male');
    log(userInfo.isMale.toString());
    HapticFeedback.lightImpact();
    context.pushNamed(Routes.heightAndWeightScreen, arguments: userInfo);
  }
}
