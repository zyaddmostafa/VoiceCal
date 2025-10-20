import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/nutrition/models/nutrition_plan_model.dart';
import '../../../onboarding/data/models/user_informations_model.dart';
import '../../data/model/social_media_auth_model.dart';
import '../../data/model/user_profile.dart';
import '../cubit/auth_cubit.dart';
import 'social_media_auth_button.dart';

class SocialMediaAuthBody extends StatelessWidget {
  final NutritionPlanModel? nutritionPlan;
  final UserInformationsModel? userInfo;

  const SocialMediaAuthBody({super.key, this.nutritionPlan, this.userInfo});

  @override
  Widget build(BuildContext context) {
    final socialMediaList = SocialMediaAuthModel.socialMedia;

    return Column(
      children: [
        SocialMediaAuthbutton(
          model: socialMediaList[0],
          onPressed: () {
            _googleSigninWithUserData(context);
          },
        ),
        verticalSpace(24),
        SocialMediaAuthbutton(model: socialMediaList[1], onPressed: () => {}),

        verticalSpace(32),
        RichText(
          text: TextSpan(
            text: 'Would your like to sign in later?  ',
            style: AppTextStyles.font12RegularSecondary.copyWith(
              color: AppColors.primaryBlack,
            ),
            children: [
              TextSpan(
                text: 'Skip',
                style: AppTextStyles.font12SemiBoldWhite.copyWith(
                  color: AppColors.primaryBlack,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _googleSigninWithUserData(BuildContext context) {
    // Case 1: Existing user (from "I already have an account")
    // userInfo is null, just sign in and fetch their data from DB
    if (userInfo == null) {
      context.read<AuthCubit>().googleSignInExistingUser();
      return;
    }

    // Case 2: New user (from "Get Started" -> onboarding completed)
    // userInfo is provided, create profile with their data
    final DateTime birthDate = DateTime(
      userInfo?.bornDate?.year ?? 0,
      userInfo?.bornDate?.month ?? 0,
      userInfo?.bornDate?.day ?? 0,
    );
    final String formattedDate = DateFormat('yyyy-MM-dd').format(birthDate);
    final userProfile = UserProfile(
      dailyCalorieGoal: nutritionPlan?.dailyCalories.round() ?? 0,
      dailyProteinGoal: nutritionPlan?.macros.proteinGrams.round() ?? 0,
      dailyCarbGoal: nutritionPlan?.macros.carbsGrams.round() ?? 0,
      dailyFatGoal: nutritionPlan?.macros.fatGrams.round() ?? 0,
      height: userInfo?.heightCm?.toDouble() ?? 0,
      weight: userInfo?.weightKg?.toDouble() ?? 0,
      isMale: userInfo?.isMale ?? true,
      bornDate: formattedDate,
      activityLevel: userInfo?.activityLevel ?? '',
      weeklyGoalInKg: userInfo?.weeklyGoalInKg ?? 0,
      rolloverCalories: userInfo?.rolloverCalories ?? false,
      goal: userInfo?.goal ?? '',
      desiredWeightInKg: userInfo?.desiredWeightKg ?? 0,
    );

    log('Creating new user profile: ${userProfile.bornDate ?? 'no date'}');
    context.read<AuthCubit>().googleSignIn(userProfile: userProfile);
  }
}
