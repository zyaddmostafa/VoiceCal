import 'package:flutter/material.dart';

import '../../../../auth/data/model/user_profile.dart';
import 'form_divider.dart';
import 'form_text_field.dart';

class BasicInformationSection extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final UserProfile? currentProfile;

  const BasicInformationSection({
    super.key,
    required this.nameController,
    required this.emailController,
    this.currentProfile,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FormTextField(
          controller: nameController,
          label: 'Full Name',
          hint: currentProfile?.fullName ?? 'Enter your name',
          validator: (value) =>
              value?.isEmpty ?? true ? 'Name is required' : null,
        ),
        const FormDivider(),
        FormTextField(
          controller: emailController,
          label: 'Email',
          hint: currentProfile?.email ?? 'Enter your email',
          keyboardType: TextInputType.emailAddress,
          enabled: false,
        ),
      ],
    );
  }
}
