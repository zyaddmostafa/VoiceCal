import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

class SocialMediaAuthButtonInfo extends StatelessWidget {
  final String logoPath;
  final String buttonText;
  final Color textColor;
  final Color? logoColor;
  const SocialMediaAuthButtonInfo({
    super.key,
    required this.logoPath,
    required this.buttonText,
    required this.textColor,
    this.logoColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          logoPath,
          width: 32,
          height: 32,
          colorFilter: logoColor != null
              ? ColorFilter.mode(logoColor!, BlendMode.srcIn)
              : null,
        ),
        horizontalSpace(16),
        Text(
          buttonText,
          style: AppTextStyles.font18SemiBoldPrimary.copyWith(color: textColor),
        ),
      ],
    );
  }
}
