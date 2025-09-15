import 'package:flutter/material.dart';

import '../../../../core/helpers/constants.dart';
import '../../../../core/helpers/extention.dart';
import '../../../../core/helpers/spacing.dart';
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
          padding: const EdgeInsets.symmetric(
            horizontal: Constants.paddingHorizontal,
          ),
          child: Column(
            children: [
              const Spacer(flex: 2),

              const AppLogo(),

              verticalSpace(48),

              const WelcomeContent(),

              const Spacer(flex: 3),

              WelcomeActions(
                onGetStarted: () => _handleGetStarted(context),
                onSignIn: _handleSignIn,
              ),

              verticalSpace(32),
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
    // TODO: Implement sign-in navigation
    print('Sign in tapped');
  }
}
