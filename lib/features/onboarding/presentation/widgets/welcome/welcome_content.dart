import 'package:flutter/material.dart';

/// Welcome screen title and subtitle text
class WelcomeContent extends StatelessWidget {
  const WelcomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Welcome to VoiceCal',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1D1D1F),
            letterSpacing: -0.5,
            height: 1.1,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        const Text(
          'Your personal nutrition assistant.\nTrack your meals, set your goals, and let your voice do the work.',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w400,
            color: Color(0xFF86868B),
            height: 1.4,
            letterSpacing: -0.2,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
