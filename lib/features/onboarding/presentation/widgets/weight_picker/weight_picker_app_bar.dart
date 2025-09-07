import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';

/// Custom app bar for weight picker screen
class WeightPickerAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final double progress; // 0..1
  const WeightPickerAppBar({super.key, this.progress = 0.25});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.backgroundPrimary,
      elevation: 0,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: AppColors.textPrimary,
          size: 18.sp,
        ),
        onPressed: () {
          HapticFeedback.lightImpact();
          Navigator.pop(context);
        },
      ),
      title: LayoutBuilder(
        builder: (context, constraints) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(2.r),
            child: Stack(
              children: [
                Container(
                  width: 120.w,
                  height: 4.h,
                  color: AppColors.divider.withValues(alpha: 0.5),
                ),
                Container(
                  width: (120.w * progress.clamp(0.0, 1.0)),
                  height: 4.h,
                  color: AppColors.textPrimary,
                ),
              ],
            ),
          );
        },
      ),
      centerTitle: true,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
