import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/di/get_it.dart';
import '../../../../core/helpers/custom_snackbar.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../auth/data/model/user_profile.dart';
import '../../../auth/data/repo/auth_repo.dart';
import '../cubit/settings_cubit.dart';
import '../widgets/personal_details/activity_level_selector.dart';
import '../widgets/personal_details/birth_date_picker.dart';
import '../widgets/personal_details/calorie_rollover_switch.dart';
import '../widgets/personal_details/form_divider.dart';
import '../widgets/personal_details/form_text_field.dart';
import '../widgets/personal_details/gender_selector.dart';
import '../widgets/personal_details/goal_selector.dart';
import '../widgets/personal_details/section_card.dart';
import '../widgets/personal_details/section_header.dart';

class PersonalDetailsScreen extends StatelessWidget {
  const PersonalDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          SettingsCubit(authRepo: getIt<AuthRepo>())
            ..getUserProfile(Supabase.instance.client.auth.currentUser!.id),
      child: const _PersonalDetailsContent(),
    );
  }
}

class _PersonalDetailsContent extends StatefulWidget {
  const _PersonalDetailsContent();

  @override
  State<_PersonalDetailsContent> createState() =>
      _PersonalDetailsContentState();
}

class _PersonalDetailsContentState extends State<_PersonalDetailsContent> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _heightController;
  late TextEditingController _weightController;
  late TextEditingController _desiredWeightController;
  late TextEditingController _weeklyGoalController;

  // State variables
  bool? _isMale;
  DateTime? _birthDate;
  String? _activityLevel;
  String? _goal;
  bool _rolloverCalories = false;

  // Current profile for hints
  UserProfile? _currentProfile;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _heightController = TextEditingController();
    _weightController = TextEditingController();
    _desiredWeightController = TextEditingController();
    _weeklyGoalController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    _desiredWeightController.dispose();
    _weeklyGoalController.dispose();
    super.dispose();
  }

  void _loadProfileData(UserProfile profile) {
    if (_currentProfile == null) {
      _currentProfile = profile;
      _nameController.text = profile.fullName ?? '';
      _emailController.text = profile.email ?? '';
      _heightController.text = profile.height != null
          ? profile.height.toString()
          : '';
      _weightController.text = profile.weight != null
          ? profile.weight.toString()
          : '';
      _desiredWeightController.text = profile.desiredWeightInKg != null
          ? profile.desiredWeightInKg.toString()
          : '';
      _weeklyGoalController.text = profile.weeklyGoalInKg != null
          ? profile.weeklyGoalInKg.toString()
          : '';
      _isMale = profile.isMale;
      _birthDate = profile.bornDate != null
          ? DateTime.tryParse(profile.bornDate!)
          : null;
      _activityLevel = profile.activityLevel;
      _goal = profile.goal;
      _rolloverCalories = profile.rolloverCalories ?? false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundSecondary,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundSecondary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Personal Details',
          style: AppTextStyles.headingLarge.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
        centerTitle: false,
      ),
      body: BlocConsumer<SettingsCubit, SettingsState>(
        listener: (context, state) {
          if (state is SettingsError) {
            CustomSnackbar.showError(
              context,
              state.apiErrorModel.message ?? 'Failed to update profile',
            );
          } else if (state is SettingsProfileUpdated) {
            CustomSnackbar.showSuccess(
              context,
              'Profile updated successfully!',
            );
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          final isLoading = state is SettingsLoading && _currentProfile == null;

          if (state is SettingsProfileLoaded) {
            _loadProfileData(state.profile);
          }

          return Skeletonizer(enabled: isLoading, child: _buildForm());
        },
      ),
    );
  }

  Widget _buildForm() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Basic Information Section
              const SectionHeader(title: 'BASIC INFORMATION'),
              verticalSpace(16),
              SectionCard(
                child: Column(
                  children: [
                    FormTextField(
                      controller: _nameController,
                      label: 'Full Name',
                      hint: _currentProfile?.fullName ?? 'Enter your name',
                      validator: (value) =>
                          value?.isEmpty ?? true ? 'Name is required' : null,
                    ),
                    const FormDivider(),
                    FormTextField(
                      controller: _emailController,
                      label: 'Email',
                      hint: _currentProfile?.email ?? 'Enter your email',
                      keyboardType: TextInputType.emailAddress,
                      enabled: false,
                    ),
                  ],
                ),
              ),
              verticalSpace(24),

              // Physical Details Section
              const SectionHeader(title: 'PHYSICAL DETAILS'),
              verticalSpace(16),
              SectionCard(
                child: Column(
                  children: [
                    GenderSelector(
                      isMale: _isMale,
                      onChanged: (value) => setState(() => _isMale = value),
                    ),
                    const FormDivider(),
                    BirthDatePicker(
                      birthDate: _birthDate,
                      currentBornDate: _currentProfile?.bornDate,
                      onDateSelected: (date) =>
                          setState(() => _birthDate = date),
                    ),
                    const FormDivider(),
                    FormTextField(
                      controller: _heightController,
                      label: 'Height',
                      hint: _currentProfile?.height != null
                          ? '${_currentProfile!.height} cm'
                          : 'Enter height in cm',
                      keyboardType: TextInputType.number,
                      suffix: 'cm',
                      validator: (value) {
                        if (value?.isEmpty ?? true) return 'Height is required';
                        final height = double.tryParse(value!);
                        if (height == null || height <= 0) {
                          return 'Enter valid height';
                        }
                        return null;
                      },
                    ),
                    const FormDivider(),
                    FormTextField(
                      controller: _weightController,
                      label: 'Current Weight',
                      hint: _currentProfile?.weight != null
                          ? '${_currentProfile!.weight} kg'
                          : 'Enter weight in kg',
                      keyboardType: TextInputType.number,
                      suffix: 'kg',
                      validator: (value) {
                        if (value?.isEmpty ?? true) return 'Weight is required';
                        final weight = double.tryParse(value!);
                        if (weight == null || weight <= 0) {
                          return 'Enter valid weight';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              verticalSpace(24),

              // Goals Section
              const SectionHeader(title: 'GOALS'),
              verticalSpace(16),
              SectionCard(
                child: Column(
                  children: [
                    GoalSelector(
                      goal: _goal,
                      currentGoal: _currentProfile?.goal,
                      onChanged: (value) => setState(() => _goal = value),
                    ),
                    const FormDivider(),
                    FormTextField(
                      controller: _desiredWeightController,
                      label: 'Target Weight',
                      hint: _currentProfile?.desiredWeightInKg != null
                          ? '${_currentProfile!.desiredWeightInKg} kg'
                          : 'Enter target weight',
                      keyboardType: TextInputType.number,
                      suffix: 'kg',
                    ),
                    const FormDivider(),
                    FormTextField(
                      controller: _weeklyGoalController,
                      label: 'Weekly Goal',
                      hint: _currentProfile?.weeklyGoalInKg != null
                          ? '${_currentProfile!.weeklyGoalInKg} kg/week'
                          : 'Enter weekly goal',
                      keyboardType: TextInputType.number,
                      suffix: 'kg/week',
                    ),
                    const FormDivider(),
                    ActivityLevelSelector(
                      activityLevel: _activityLevel,
                      currentActivityLevel: _currentProfile?.activityLevel,
                      onChanged: (value) =>
                          setState(() => _activityLevel = value),
                    ),
                    const FormDivider(),
                    CalorieRolloverSwitch(
                      value: _rolloverCalories,
                      onChanged: (value) =>
                          setState(() => _rolloverCalories = value),
                    ),
                  ],
                ),
              ),
              verticalSpace(40),

              // Save Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveChanges,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryBlack,
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    'Save Changes',
                    style: AppTextStyles.labelLarge.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              verticalSpace(40),
            ],
          ),
        ),
      ),
    );
  }

  void _saveChanges() {
    if (_formKey.currentState?.validate() ?? false) {
      final userId = Supabase.instance.client.auth.currentUser?.id;

      if (userId == null) {
        CustomSnackbar.showError(context, 'User not found');

        return;
      }

      context.read<SettingsCubit>().updateProfileFields(
        userId: userId,
        fullName: _nameController.text.trim(),
        email: _emailController.text.trim(),
        height: double.tryParse(_heightController.text),
        weight: double.tryParse(_weightController.text),
        desiredWeightInKg: double.tryParse(_desiredWeightController.text),
        weeklyGoalInKg: double.tryParse(_weeklyGoalController.text),
        isMale: _isMale,
        bornDate: _birthDate?.toIso8601String(),
        activityLevel: _activityLevel,
        goal: _goal,
        rolloverCalories: _rolloverCalories,
      );
    } else {
      CustomSnackbar.showError(context, 'Please fill in all required fields');
    }
  }
}
