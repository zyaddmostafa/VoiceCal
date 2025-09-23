import 'package:flutter/material.dart';

import '../../../../core/helpers/constants.dart';

class SocialMediaAuthModel {
  final String logoPath;
  final String buttonText;
  final Color backgroundColor;
  final Color textColor;
  final Color? logoColor;

  const SocialMediaAuthModel({
    required this.logoPath,
    required this.buttonText,
    required this.backgroundColor,
    required this.textColor,
    this.logoColor,
  });

  static const List<SocialMediaAuthModel> socialMedia = [
    SocialMediaAuthModel(
      logoPath: Constants.googleLogo,
      buttonText: 'Continue with Google',
      backgroundColor: Colors.white,
      textColor: Colors.black,
    ),

    SocialMediaAuthModel(
      logoPath: Constants.appleLogo,
      buttonText: 'Continue with Apple',
      backgroundColor: Colors.black,
      textColor: Colors.white,
      logoColor: Colors.white,
    ),
  ];
}
