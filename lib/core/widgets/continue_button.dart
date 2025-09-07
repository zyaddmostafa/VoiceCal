import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';

/// Reusable continue button widget with iOS-style gradient design
class ContinueButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isEnabled;
  final String text;

  const ContinueButton({
    super.key,
    required this.onPressed,
    this.isEnabled = true,
    this.text = 'Continue',
  });

  @override
  Widget build(BuildContext context) {
    final buttonBorderRadius = BorderRadius.circular(28.r);

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 300),
      opacity: isEnabled ? 1.0 : 0.6,
      child: Container(
        width: double.infinity,
        height: 56.h,
        decoration: BoxDecoration(
          gradient: isEnabled
              ? const LinearGradient(
                  colors: [Color(0xFF007AFF), Color(0xFF5AC8FA)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                )
              : null,
          color: isEnabled ? null : const Color(0xFFE5E5E7),
          borderRadius: buttonBorderRadius,
          boxShadow: isEnabled
              ? [
                  BoxShadow(
                    color: AppColors.primaryBlueShadow,
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ]
              : null,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: buttonBorderRadius,
            onTap: isEnabled ? onPressed : null,
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w600,
                  color: isEnabled ? Colors.white : const Color(0xFF8E8E93),
                  letterSpacing: -0.2,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
