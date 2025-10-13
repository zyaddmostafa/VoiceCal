import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/helpers/custom_app_bar.dart';
import '../../../../core/helpers/custom_snackbar.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../auth/data/model/user_profile.dart';
import '../cubit/settings_cubit.dart';
import '../widgets/personal_details/personal_details_form.dart';

class PersonalDetailsScreen extends StatefulWidget {
  final UserProfile profile;

  const PersonalDetailsScreen({super.key, required this.profile});

  @override
  State<PersonalDetailsScreen> createState() => _PersonalDetailsScreenState();
}

class _PersonalDetailsScreenState extends State<PersonalDetailsScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _heightController;
  late TextEditingController _weightController;
  late TextEditingController _desiredWeightController;
  late TextEditingController _weeklyGoalController;

  bool? _isMale;
  DateTime? _birthDate;
  String? _activityLevel;
  String? _goal;
  bool _rolloverCalories = false;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
    _loadProfileData();
  }

  void _initializeControllers() {
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _heightController = TextEditingController();
    _weightController = TextEditingController();
    _desiredWeightController = TextEditingController();
    _weeklyGoalController = TextEditingController();
  }

  void _loadProfileData() {
    final profile = widget.profile;
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

  @override
  void dispose() {
    _disposeControllers();
    super.dispose();
  }

  void _disposeControllers() {
    _nameController.dispose();
    _emailController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    _desiredWeightController.dispose();
    _weeklyGoalController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundSecondary,
      appBar: CustomAppBar.build(
        context: context,
        child: const Text(
          'Personal Details',
          style: AppTextStyles.font28BoldBlack,
        ),
        hasBackButton: true,
        centerTitle: true,
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
          return PersonalDetailsForm(
            formKey: _formKey,
            nameController: _nameController,
            emailController: _emailController,
            heightController: _heightController,
            weightController: _weightController,
            desiredWeightController: _desiredWeightController,
            weeklyGoalController: _weeklyGoalController,
            isMale: _isMale,
            birthDate: _birthDate,
            activityLevel: _activityLevel,
            goal: _goal,
            rolloverCalories: _rolloverCalories,
            currentProfile: widget.profile,
            onGenderChanged: (value) => setState(() => _isMale = value),
            onDateSelected: (date) => setState(() => _birthDate = date),
            onGoalChanged: (value) => setState(() => _goal = value),
            onActivityLevelChanged: (value) =>
                setState(() => _activityLevel = value),
            onRolloverChanged: (value) =>
                setState(() => _rolloverCalories = value),
            onSavePressed: _saveChanges,
          );
        },
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
