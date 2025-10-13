import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/helpers/custom_app_bar.dart';
import '../../../../core/helpers/custom_snackbar.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../auth/data/model/user_profile.dart';
import '../cubit/settings_cubit.dart';
import '../widgets/settings/settings_screen_body.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundSecondary,
      appBar: CustomAppBar.build(
        context: context,
        child: const Text('Settings', style: AppTextStyles.font28BoldBlack),
        centerTitle: true,
        hasBackButton: false,
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
            // Create a dummy profile for skeleton loading
            final dummyProfile = UserProfile(
              userId: '',
              fullName: 'Loading...',
              email: 'loading@example.com',
            );

            return Skeletonizer(
              enabled: true,
              child: SettingsScreenBody(
                age: 'N/A',
                height: 'N/A',
                currentWeight: 'N/A',
                profile: dummyProfile,
              ),
            );
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

    // If no profile, create a dummy one
    final currentProfile =
        profile ??
        UserProfile(
          userId: '',
          fullName: 'Unknown',
          email: 'unknown@example.com',
        );

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

    return SettingsScreenBody(
      age: age,
      height: height,
      currentWeight: currentWeight,
      profile: currentProfile,
    );
  }
}
