import 'package:flutter/material.dart';

import '../../../data/service/settings_buttons_service.dart';
import 'enhanced_settings_item.dart';
import 'enhanced_settings_section.dart';

class LegalSection extends StatelessWidget {
  const LegalSection({super.key});

  @override
  Widget build(BuildContext context) {
    return EnhancedSettingsSection(
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
          onTap: () => SettingsButtonsService.handlePrivacyPolicyTap(context),
        ),
        EnhancedSettingsItem(
          title: 'Support Email',
          hasArrow: true,
          onTap: () => SettingsButtonsService.handleSupportEmailTap(context),
        ),
        EnhancedSettingsItem(
          title: 'Delete Account?',
          hasArrow: true,
          onTap: () => SettingsButtonsService.handleDeleteAccountTap(context),
        ),
      ],
    );
  }
}
