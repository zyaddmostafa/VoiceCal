import 'package:flutter/cupertino.dart';
import '../../../../core/helpers/constants.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/nutrition/nutrition_calculator_service.dart';
import '../../../onboarding/data/models/user_informations_model.dart';
import '../../../onboarding/presentation/widgets/onboarding_progress_header.dart';
import '../widgets/auth_bloc_listener.dart';
import '../widgets/social_media_auth_body.dart';

class AuthScreen extends StatelessWidget {
  final UserInformationsModel? userInfo;
  const AuthScreen({super.key, this.userInfo});

  @override
  Widget build(BuildContext context) {
    // Calculate nutrition goals from user info
    final nutritionPlan = userInfo != null
        ? NutritionCalculatorService.calculateNutritionPlan(userInfo!)
        : null;

    return CupertinoPageScaffold(
      backgroundColor: AppColors.backgroundPrimary,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Constants.paddingHorizontal,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpace(Constants.verticalSpaceAfterSafeArea),

              const OnboardingProgressHeader(
                progress: 13 / Constants.onboardingScreensCount,
              ),
              verticalSpace(16),

              Text(
                'Save your progress',
                style: AppTextStyles.font32BoldPrimary,
              ),
              const Spacer(),
              SocialMediaAuthBody(
                nutritionPlan: nutritionPlan,
                userInfo: userInfo,
              ),
              const Spacer(),
              AuthBlocListener(userInfo: userInfo),
            ],
          ),
        ),
      ),
    );
  }
}
