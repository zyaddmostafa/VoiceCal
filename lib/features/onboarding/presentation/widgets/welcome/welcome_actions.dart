import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../../core/widgets/custom_app_button.dart';
import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/theme/app_text_styles.dart';

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
        CustomAppButton(onPressed: onGetStarted, text: 'Get Started'),
        verticalSpace(16),
        TextButton(
          onPressed: () {
            HapticFeedback.lightImpact();
            onSignIn();
          },

          child: Text(
            'I already have an account ?',
            style: AppTextStyles.font16MediumBlack,
          ),
        ),
      ],
    );
  }
}
