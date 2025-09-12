import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/custom_app_button.dart';

class RolloverActionButtons extends StatelessWidget {
  final VoidCallback? onNoPressed;
  final VoidCallback? onYesPressed;

  const RolloverActionButtons({super.key, this.onNoPressed, this.onYesPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _NoButton(
            onPressed: () {
              HapticFeedback.lightImpact();
              onNoPressed?.call();
            },
          ),
        ),
        horizontalSpace(16),
        Expanded(
          child: CustomAppButton(
            text: 'Yes',
            onPressed: () {
              HapticFeedback.mediumImpact();
              onYesPressed?.call();
            },
          ),
        ),
      ],
    );
  }
}

class _NoButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _NoButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    const borderRadius = 28.0;

    return Container(
      height: 56.h,
      decoration: BoxDecoration(
        color: AppColors.backgroundPrimary,
        borderRadius: BorderRadius.circular(borderRadius.r),
        border: const Border.fromBorderSide(
          BorderSide(color: AppColors.textPrimary, width: 1.5),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(borderRadius.r),
          onTap: onPressed,
          child: Center(
            child: Text(
              'No',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 17.sp,
                fontWeight: FontWeight.w600,
                letterSpacing: -0.2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
