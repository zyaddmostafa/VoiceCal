import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_icons.dart';
import '../theme/app_colors.dart';

class CustomAppBar {
  static ObstructingPreferredSizeWidget build({
    required BuildContext context,
    required Widget child,
    VoidCallback? onBackPressed,
    bool hasBackButton = true,
  }) {
    return CupertinoNavigationBar(
      backgroundColor: AppColors.backgroundSecondary,
      border: null,
      leading: hasBackButton
          ? CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: onBackPressed ?? () => Navigator.of(context).pop(),
              child: Icon(
                AppIcons.backArrow,
                color: AppColors.textPrimary,
                size: 16.sp,
              ),
            )
          : child, // Title on the left when no back button
      middle: hasBackButton
          ? child
          : null, // Title in center when has back button
    );
  }
}
