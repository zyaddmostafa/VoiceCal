import 'package:flutter/material.dart';

import '../../../../core/helpers/extention.dart';
import '../../../../core/routing/routes.dart';
import '../widgets/welcome/app_logo.dart';
import '../widgets/welcome/welcome_actions.dart';
import '../widgets/welcome/welcome_content.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            children: [
              const Spacer(flex: 2),

              // App Logo
              const AppLogo(),
              const SizedBox(height: 48),

              // Welcome Content
              const WelcomeContent(),
              const Spacer(flex: 3),

              // Action Buttons
              WelcomeActions(
                onGetStarted: () => _handleGetStarted(context),
                onSignIn: _handleSignIn,
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  void _handleGetStarted(BuildContext context) {
    context.pushNamed(Routes.genderSelectionScreen);
  }

  void _handleSignIn() {
    print('Sign in tapped');
  }
}
