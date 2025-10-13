import 'package:flutter/material.dart';

import '../../../../auth/data/model/user_profile.dart';
import '../../../data/service/settings_buttons_service.dart';
import 'enhanced_settings_item.dart';
import 'enhanced_settings_section.dart';

class CustomizationSection extends StatelessWidget {
  final UserProfile profile;

  const CustomizationSection({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return EnhancedSettingsSection(
      title: 'CUSTOMIZATION',
      children: [
        EnhancedSettingsItem(
          title: 'Personal details',
          hasArrow: true,
          onTap: () =>
              SettingsButtonsService.handlePersonalDetailsTap(context, profile),
        ),
        EnhancedSettingsItem(
          title: 'Adjust goals',
          subtitle: 'Calories, carbs, fats, and protein.',
          hasArrow: true,
          onTap: () => SettingsButtonsService.handleAdjustGoalsTap(context),
        ),
      ],
    );
  }
}
