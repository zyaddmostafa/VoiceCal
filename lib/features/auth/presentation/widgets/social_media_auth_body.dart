import 'package:flutter/material.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../data/model/social_media_auth_model.dart';
import 'social_media_auth_button.dart';

class SocialMediaAuthBody extends StatelessWidget {
  const SocialMediaAuthBody({super.key});

  @override
  Widget build(BuildContext context) {
    final socialMediaList = SocialMediaAuthModel.socialMedia;

    return Column(
      children: [
        SocialMediaAuthbutton(
          model: socialMediaList[0],
          onPressed: () {
            // Handle Google sign-in
          },
        ),
        verticalSpace(24),
        SocialMediaAuthbutton(
          model: socialMediaList[1],

          onPressed: () {
            // Handle Apple sign-in
          },
        ),

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
