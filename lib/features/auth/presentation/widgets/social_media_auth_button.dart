import 'package:flutter/material.dart';

import '../../../../core/helpers/constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../data/model/social_media_auth_model.dart';
import 'social_media_auth_button_info.dart';

class SocialMediaAuthbutton extends StatelessWidget {
  final SocialMediaAuthModel model;
  final VoidCallback? onPressed;
  const SocialMediaAuthbutton({super.key, required this.model, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        margin: const EdgeInsets.symmetric(horizontal: 12),

        decoration: BoxDecoration(
          color: model.backgroundColor,
          borderRadius: const BorderRadius.all(Radius.circular(50)),
          border: const Border.fromBorderSide(
            BorderSide(color: AppColors.primaryBlack, width: 2),
          ),
        ),
        child: SocialMediaAuthButtonInfo(
          logoPath: model.logoPath,
          buttonText: model.buttonText,
          textColor: model.textColor,
          logoColor: model.logoPath == Constants.appleLogo
              ? model.logoColor
              : null,
        ),
      ),
    );
  }
}
