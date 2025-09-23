import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/helpers/constants.dart';
import '../../../../core/helpers/extention.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/custom_app_button.dart';
import '../../../../core/widgets/onboarding_header.dart';
import '../../data/models/user_informations_model.dart';
import '../widgets/age_selection/birth_date_picker.dart';
import '../widgets/onboarding_progress_header.dart';

class BornDateScreen extends StatefulWidget {
  final UserInformationsModel? userInfo;
  const BornDateScreen({super.key, this.userInfo});

  @override
  State<BornDateScreen> createState() => _BornDateScreenState();
}

class _BornDateScreenState extends State<BornDateScreen> {
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
          padding: const EdgeInsets.symmetric(
            horizontal: Constants.paddingHorizontal,
          ),
          child: Column(
            children: [
              verticalSpace(Constants.verticalSpaceAfterSafeArea),

              const OnboardingProgressHeader(
                progress: 3 / Constants.onboardingScreensCount,
              ),
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
    final userInfo = widget.userInfo?.copyWith(
      bornDate: BornDate(
        day: selectedDate.day,
        month: selectedDate.month,
        year: selectedDate.year,
      ),
    );
    log(
      '${userInfo!.bornDate!.day}-${userInfo.bornDate!.month}-${userInfo.bornDate!.year} - ${userInfo.isMale! ? 'Male' : 'Female'} years old',
    );
    context.pushNamed(Routes.workoutFrequencyScreen, arguments: userInfo);
  }
}
