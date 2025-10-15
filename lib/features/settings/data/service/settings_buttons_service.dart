import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/helpers/extention.dart';
import '../../../../core/routing/routes.dart';
import '../../../auth/data/model/user_profile.dart';
import '../../presentation/cubit/settings_cubit.dart';

class SettingsButtonsService {
  // Handler methods
  static Future<void> handlePersonalDetailsTap(
    BuildContext context,
    UserProfile profile,
  ) async {
    final result = await context.pushNamed(
      Routes.personalDetailsScreen,
      arguments: profile,
    );

    // If data was updated (result == true), refresh the profile
    if (result == true) {
      final userId = Supabase.instance.client.auth.currentUser?.id;
      if (userId != null && context.mounted) {
        context.read<SettingsCubit>().getUserProfile(userId);
      }
    }
  }

  static void handleAdjustGoalsTap(BuildContext context) {
    // TODO: Navigate to adjust goals screen
  }

  static void handleTermsAndConditionsTap(BuildContext context) {
    // TODO: Navigate to terms and conditions
  }

  static void handlePrivacyPolicyTap(BuildContext context) {
    // TODO: Navigate to privacy policy
  }

  static void handleSupportEmailTap(BuildContext context) {
    // TODO: Open support email
  }

  static void handleDeleteAccountTap(BuildContext context) {
    // TODO: Handle delete account
  }

  static void handleSignOut(BuildContext context) {
    // TODO: Handle sign out
  }
}
