import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../core/theme/app_colors.dart';

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
        Container(
          width: double.infinity,
          height: 56,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF007AFF), Color(0xFF5AC8FA)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(28)),
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryBlueShadow,
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: const BorderRadius.all(Radius.circular(28)),
              onTap: () {
                HapticFeedback.lightImpact();
                onGetStarted();
              },
              child: const Center(
                child: Text(
                  'Get Started',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    letterSpacing: -0.2,
                  ),
                ),
              ),
            ),
          ),
        ),
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
              color: Color(0xFF007AFF),
              letterSpacing: -0.2,
            ),
          ),
        ),
      ],
    );
  }
}
