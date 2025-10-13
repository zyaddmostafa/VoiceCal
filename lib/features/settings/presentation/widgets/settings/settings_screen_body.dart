import 'package:flutter/material.dart';

import '../../../../../core/helpers/spacing.dart';
import '../../../../auth/data/model/user_profile.dart';
import 'customization_section.dart';
import 'legal_section.dart';
import 'sign_out_button.dart';
import 'user_metrics_section.dart';

class SettingsScreenBody extends StatelessWidget {
  const SettingsScreenBody({
    super.key,
    required this.age,
    required this.height,
    required this.currentWeight,
    required this.profile,
  });

  final String age;
  final String height;
  final String currentWeight;
  final UserProfile profile;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UserMetricsSection(
            age: age,
            height: height,
            currentWeight: currentWeight,
          ),

          CustomizationSection(profile: profile),

          const LegalSection(),

          const SignOutButton(),

          verticalSpace(40),
        ],
      ),
    );
  }
}
