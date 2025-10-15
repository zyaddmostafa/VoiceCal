import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/helpers/custom_app_bar.dart';
import '../../../../core/helpers/custom_snackbar.dart';
import '../../../../core/helpers/extention.dart';
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

  void _loadProfileData({UserProfile? profile}) {
    final profileData = profile ?? widget.profile;
    _nameController.text = profileData.fullName ?? '';
    _emailController.text = profileData.email ?? '';
    _heightController.text = profileData.height != null
        ? profileData.height.toString()
        : '';
    _weightController.text = profileData.weight != null
        ? profileData.weight.toString()
        : '';
    _desiredWeightController.text = profileData.desiredWeightInKg != null
        ? profileData.desiredWeightInKg.toString()
        : '';
    _weeklyGoalController.text = profileData.weeklyGoalInKg != null
        ? profileData.weeklyGoalInKg.toString()
        : '';

    setState(() {
      _isMale = profileData.isMale;
      _birthDate = profileData.bornDate != null
          ? DateTime.tryParse(profileData.bornDate!)
          : null;
      _activityLevel = profileData.activityLevel;
      _goal = profileData.goal;
      _rolloverCalories = profileData.rolloverCalories ?? false;
    });
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
    return CupertinoPageScaffold(
      backgroundColor: AppColors.backgroundSecondary,
      navigationBar: CustomAppBar.build(
        context: context,
        hasBackButton: true,
        child: const Text(
          'Personal Details',
          style: AppTextStyles.font28BoldBlack,
        ),
      ),
      child: SafeArea(
        child: BlocConsumer<SettingsCubit, SettingsState>(
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
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Future.delayed(const Duration(milliseconds: 300), () {
                  context.pop();
                });
              });
            } else if (state is SettingsProfileLoaded) {
              // Reload the form with updated profile data
              _loadProfileData(profile: state.profile);
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
