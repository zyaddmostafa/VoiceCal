import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/models/user_settings.dart';
import '../widgets/settings_section.dart';
import '../widgets/settings_item.dart';
import '../widgets/settings_toggle_item.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userSettings = _getSampleUserSettings();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F5F5),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Settings',
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 16.h),

            // Account Section
            SettingsSection(
              title: 'ACCOUNT',
              children: [
                SettingsItem(
                  icon: Icons.mail_outline,
                  title: 'Email',
                  trailing: userSettings.email,
                  onTap: () => _handleEmailTap(context),
                ),
                SettingsItem(
                  icon: Icons.person_outline,
                  title: 'Plan',
                  trailing: userSettings.plan,
                  onTap: () => _handlePlanTap(context),
                ),
                SettingsItem(
                  icon: Icons.mic_none,
                  title: 'Voice Records Left',
                  trailing: '${userSettings.voiceRecordsLeft}',
                  onTap: () => _handleVoiceRecordsTap(context),
                ),
              ],
            ),

            // Data & Preferences Section
            SettingsSection(
              title: 'DATA & PREFERENCES',
              children: [
                SettingsItem(
                  icon: Icons.download_outlined,
                  title: 'Export Data',
                  hasArrow: true,
                  onTap: () => _handleExportDataTap(context),
                ),
                SettingsItem(
                  icon: Icons.language_outlined,
                  title: 'Language',
                  trailing: userSettings.language,
                  hasArrow: true,
                  onTap: () => _handleLanguageTap(context),
                ),
                SettingsToggleItem(
                  icon: Icons.notifications_none,
                  title: 'Daily Reminders',
                  value: userSettings.dailyRemindersEnabled,
                  onChanged: (value) => _handleDailyReminderToggle(value),
                ),
              ],
            ),

            // About App Section
            SettingsSection(
              title: 'ABOUT APP',
              children: [
                SettingsItem(
                  icon: Icons.shield_outlined,
                  title: 'Privacy Policy',
                  hasArrow: true,
                  onTap: () => _handlePrivacyPolicyTap(context),
                ),
                SettingsItem(
                  icon: Icons.info_outline,
                  title: 'About App',
                  hasArrow: true,
                  onTap: () => _handleAboutAppTap(context),
                ),
                SettingsItem(
                  icon: Icons.help_outline,
                  title: 'FAQ',
                  hasArrow: true,
                  onTap: () => _handleFAQTap(context),
                ),
              ],
            ),

            // Actions Section
            SettingsSection(
              title: 'ACTIONS',
              children: [
                SettingsItem(
                  icon: Icons.logout,
                  title: 'Sign Out',
                  onTap: () => _handleSignOutTap(context),
                ),
                SettingsItem(
                  icon: Icons.delete_outline,
                  title: 'Delete Account',
                  isDestructive: true,
                  onTap: () => _handleDeleteAccountTap(context),
                ),
              ],
            ),

            SizedBox(height: 100.h), // Bottom padding for navigation bar
          ],
        ),
      ),
    );
  }

  // Handler methods
  void _handleEmailTap(BuildContext context) {
    // TODO: Navigate to email settings
  }

  void _handlePlanTap(BuildContext context) {
    // TODO: Navigate to plan settings
  }

  void _handleVoiceRecordsTap(BuildContext context) {
    // TODO: Navigate to voice records settings
  }

  void _handleExportDataTap(BuildContext context) {
    // TODO: Handle export data
  }

  void _handleLanguageTap(BuildContext context) {
    // TODO: Navigate to language settings
  }

  void _handleDailyReminderToggle(bool value) {
    // TODO: Handle daily reminder toggle
  }

  void _handlePrivacyPolicyTap(BuildContext context) {
    // TODO: Navigate to privacy policy
  }

  void _handleAboutAppTap(BuildContext context) {
    // TODO: Navigate to about app
  }

  void _handleFAQTap(BuildContext context) {
    // TODO: Navigate to FAQ
  }

  void _handleSignOutTap(BuildContext context) {
    // TODO: Handle sign out
  }

  void _handleDeleteAccountTap(BuildContext context) {
    // TODO: Handle delete account
  }

  UserSettings _getSampleUserSettings() {
    return const UserSettings(
      email: 'user@gmail.com',
      plan: 'Free',
      voiceRecordsLeft: 6,
      language: 'English',
      dailyRemindersEnabled: true,
    );
  }
}
