import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/custom_app_button.dart';

/// Welcome screen action buttons (Get Started and Sign In)
class WelcomeActions extends StatelessWidget {
  final VoidCallback onGetStarted;
  final VoidCallback onSignIn;

  const WelcomeActions({
    super.key,
    required this.onGetStarted,
    required this.onSignIn,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Get Started Button
        CustomAppButton(onPressed: onGetStarted, text: 'Get Started'),
        const SizedBox(height: 16),
        // Already have account button
        TextButton(
          onPressed: () {
            HapticFeedback.lightImpact();
            onSignIn();
          },
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            minimumSize: const Size(0, 44),
          ),
          child: const Text(
            'I already have an account',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColors.primaryBlack,
              letterSpacing: -0.2,
            ),
          ),
        ),
      ],
    );
  }
}
