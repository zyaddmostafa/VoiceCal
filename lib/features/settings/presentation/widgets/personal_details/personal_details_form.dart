import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/helpers/spacing.dart';
import '../../../../auth/data/model/user_profile.dart';
import 'basic_information_section.dart';
import 'goals_section.dart';
import 'physical_details_section.dart';
import 'save_button.dart';
import 'section_card.dart';
import 'section_header.dart';

class PersonalDetailsForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController heightController;
  final TextEditingController weightController;
  final TextEditingController desiredWeightController;
  final TextEditingController weeklyGoalController;
  final bool? isMale;
  final DateTime? birthDate;
  final String? activityLevel;
  final String? goal;
  final bool rolloverCalories;
  final UserProfile? currentProfile;
  final ValueChanged<bool?> onGenderChanged;
  final ValueChanged<DateTime?> onDateSelected;
  final ValueChanged<String?> onGoalChanged;
  final ValueChanged<String?> onActivityLevelChanged;
  final ValueChanged<bool> onRolloverChanged;
  final VoidCallback onSavePressed;

  const PersonalDetailsForm({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.emailController,
    required this.heightController,
    required this.weightController,
    required this.desiredWeightController,
    required this.weeklyGoalController,
    required this.isMale,
    required this.birthDate,
    required this.activityLevel,
    required this.goal,
    required this.rolloverCalories,
    required this.currentProfile,
    required this.onGenderChanged,
    required this.onDateSelected,
    required this.onGoalChanged,
    required this.onActivityLevelChanged,
    required this.onRolloverChanged,
    required this.onSavePressed,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Basic Information Section
              const SectionHeader(title: 'BASIC INFORMATION'),
              verticalSpace(16),
              SectionCard(
                child: BasicInformationSection(
                  nameController: nameController,
                  emailController: emailController,
                  currentProfile: currentProfile,
                ),
              ),
              verticalSpace(24),

              // Physical Details Section
              const SectionHeader(title: 'PHYSICAL DETAILS'),
              verticalSpace(16),
              SectionCard(
                child: PhysicalDetailsSection(
                  isMale: isMale ?? false,
                  birthDate: birthDate,
                  heightController: heightController,
                  weightController: weightController,
                  currentProfile: currentProfile,
                  onGenderChanged: onGenderChanged,
                  onDateSelected: onDateSelected,
                ),
              ),
              verticalSpace(24),

              // Goals Section
              const SectionHeader(title: 'GOALS'),
              verticalSpace(16),
              SectionCard(
                child: GoalsSection(
                  goal: goal,
                  activityLevel: activityLevel,
                  rolloverCalories: rolloverCalories,
                  desiredWeightController: desiredWeightController,
                  weeklyGoalController: weeklyGoalController,
                  currentProfile: currentProfile,
                  onGoalChanged: onGoalChanged,
                  onActivityLevelChanged: onActivityLevelChanged,
                  onRolloverChanged: onRolloverChanged,
                ),
              ),
              verticalSpace(40),

              // Save Button
              SaveButton(onPressed: onSavePressed),
              verticalSpace(40),
            ],
          ),
        ),
      ),
    );
  }
}
