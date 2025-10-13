import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../data/service/settings_buttons_service.dart';

class SignOutButton extends StatelessWidget {
  const SignOutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: () => SettingsButtonsService.handleSignOut(context),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Sign Out',
              style: AppTextStyles.labelLarge.copyWith(
                color: CupertinoColors.systemRed,
                fontWeight: FontWeight.w600,
              ),
            ),
            horizontalSpace(8),
            Icon(
              CupertinoIcons.square_arrow_right,
              color: CupertinoColors.systemRed,
              size: 20.sp,
            ),
          ],
        ),
      ),
    );
  }
}
