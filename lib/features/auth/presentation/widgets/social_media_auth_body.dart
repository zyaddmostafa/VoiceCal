import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/nutrition/models/nutrition_plan_model.dart';
import '../../data/model/social_media_auth_model.dart';
import '../cubit/auth_cubit.dart';
import 'social_media_auth_button.dart';

class SocialMediaAuthBody extends StatelessWidget {
  final NutritionPlanModel? nutritionPlan;

  const SocialMediaAuthBody({super.key, this.nutritionPlan});

  @override
  Widget build(BuildContext context) {
    final socialMediaList = SocialMediaAuthModel.socialMedia;

    return Column(
      children: [
        SocialMediaAuthbutton(
          model: socialMediaList[0],
          onPressed: () {
            if (nutritionPlan != null) {
              context.read<AuthCubit>().googleSignIn(
                dailyCalorieGoal: nutritionPlan!.dailyCalories.round(),
                dailyProteinGoal: nutritionPlan!.macros.proteinGrams.round(),
                dailyCarbGoal: nutritionPlan!.macros.carbsGrams.round(),
                dailyFatGoal: nutritionPlan!.macros.fatGrams.round(),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Please complete onboarding first'),
                  backgroundColor: Colors.red,
                ),
              );
            }
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
}
