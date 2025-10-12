import 'package:flutter/widgets.dart';

import '../../../../core/helpers/extention.dart';
import '../../../../core/routing/routes.dart';

class SettingsButtonsService {
  // Handler methods
  static void handlePersonalDetailsTap(BuildContext context) {
    context.pushNamed(Routes.personalDetailsScreen);
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
