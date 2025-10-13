import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/app_colors.dart';

class CustomAppBar {
  static PreferredSizeWidget build({
    required BuildContext context,
    required Widget child,
    VoidCallback? onBackPressed,
    bool centerTitle = false,
    bool hasBackButton = true,
  }) {
    return PreferredSize(
      preferredSize: Size.fromHeight(44.h),
      child: CupertinoNavigationBar(
        backgroundColor: AppColors.backgroundSecondary,
        border: null,
        leading: hasBackButton
            ? CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: onBackPressed ?? () => Navigator.of(context).pop(),
                child: Icon(
                  CupertinoIcons.back,
                  color: AppColors.textPrimary,
                  size: 28.sp,
                ),
              )
            : null,
        middle: centerTitle ? child : null,
        trailing: !centerTitle ? child : null,
      ),
    );
  }
}
