import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/di/get_it.dart';
import '../../../../core/helpers/custom_snackbar.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../auth/data/repo/auth_repo.dart';
import '../../data/service/settings_buttons_service.dart';
import '../cubit/settings_cubit.dart';
import '../widgets/enhanced_settings_item.dart';
import '../widgets/enhanced_settings_section.dart';
import '../widgets/user_metrics_display.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          SettingsCubit(authRepo: getIt<AuthRepo>())
            ..getUserProfile(Supabase.instance.client.auth.currentUser!.id),
      child: const _SettingsScreenContent(),
    );
  }
}

class _SettingsScreenContent extends StatelessWidget {
  const _SettingsScreenContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundSecondary,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundSecondary,
        elevation: 0,
        title: Text(
          'Settings',
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
              state.apiErrorModel.message ?? 'Failed to load profile',
            );
          } else if (state is SettingsProfileUpdated) {
            CustomSnackbar.showSuccess(context, state.message);
          }
        },
        builder: (context, state) {
          if (state is SettingsLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is SettingsProfileLoaded) {
            return _buildContent(context, state);
          }

          // Initial or error state
          return _buildContent(context, null);
        },
      ),
    );
  }

  Widget _buildContent(BuildContext context, SettingsProfileLoaded? state) {
    final profile = state?.profile;

    // Calculate age from bornDate
    String age = 'N/A';
    if (profile?.bornDate != null) {
      try {
        final birthDate = DateTime.parse(profile!.bornDate!);
        final today = DateTime.now();
        age = (today.year - birthDate.year).toString();
      } catch (e) {
        age = 'N/A';
      }
    }

    String height = 'N/A';
    if (profile?.height != null) {
      final heightInCm = profile!.height!;
      if (heightInCm >= 100) {
        final heightInMeters = heightInCm / 100;
        height = '${heightInMeters.toStringAsFixed(2)} m';
      } else {
        height = '${heightInCm.toStringAsFixed(0)} cm';
      }
    }

    String currentWeight = 'N/A';
    if (profile?.weight != null) {
      final weightInKg = profile!.weight!;
      currentWeight = '${weightInKg.toStringAsFixed(1)} kg';
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User Metrics Section
          Container(
            margin: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: AppColors.backgroundPrimary,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: AppColors.border, width: 0.5),
            ),
            child: UserMetricsDisplay(
              age: age,
              height: height,
              currentWeight: currentWeight,
            ),
          ),

          // Customization Section
          EnhancedSettingsSection(
            title: 'CUSTOMIZATION',
            children: [
              EnhancedSettingsItem(
                title: 'Personal details',
                hasArrow: true,
                onTap: () =>
                    SettingsButtonsService.handlePersonalDetailsTap(context),
              ),
              EnhancedSettingsItem(
                title: 'Adjust goals',
                subtitle: 'Calories, carbs, fats, and protein.',
                hasArrow: true,
                onTap: () =>
                    SettingsButtonsService.handleAdjustGoalsTap(context),
              ),
            ],
          ),

          // Legal Section
          EnhancedSettingsSection(
            title: 'LEGAL',
            children: [
              EnhancedSettingsItem(
                title: 'Terms and Conditions',
                hasArrow: true,
                onTap: () =>
                    SettingsButtonsService.handleTermsAndConditionsTap(context),
              ),
              EnhancedSettingsItem(
                title: 'Privacy Policy',
                hasArrow: true,
                onTap: () =>
                    SettingsButtonsService.handlePrivacyPolicyTap(context),
              ),
              EnhancedSettingsItem(
                title: 'Support Email',
                hasArrow: true,
                onTap: () =>
                    SettingsButtonsService.handleSupportEmailTap(context),
              ),
              EnhancedSettingsItem(
                title: 'Delete Account?',
                hasArrow: true,
                onTap: () =>
                    SettingsButtonsService.handleDeleteAccountTap(context),
              ),
            ],
          ),

          // Sign Out Button
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
            child: GestureDetector(
              onTap: () => SettingsButtonsService.handleSignOut(context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Sign Out',
                    style: AppTextStyles.labelLarge.copyWith(
                      color: Colors.red,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  horizontalSpace(8),
                  Icon(Icons.logout, color: Colors.red, size: 20.sp),
                ],
              ),
            ),
          ),

          verticalSpace(40), // Bottom padding
        ],
      ),
    );
  }
}
