import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/app_text_styles.dart';
import '../theme/app_colors.dart';
import '../theme/app_design_system.dart';

class CustomAppButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isEnabled;
  final String text;

  const CustomAppButton({
    super.key,
    required this.onPressed,
    this.isEnabled = true,
    this.text = 'Continue',
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: AppDesignSystem.animationNormal,
      opacity: isEnabled ? 1.0 : 0.5,
      child: GestureDetector(
        onTap: isEnabled ? onPressed : null,
        child: Container(
          width: double.infinity,
          height: 56.h,
          decoration: BoxDecoration(
            color: isEnabled ? AppColors.primaryBlack : AppColors.infoSurface,
            borderRadius: const BorderRadius.all(Radius.circular(36)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Center(
            child: Text(
              text,
              style: AppTextStyles.labelLarge.copyWith(
                color: isEnabled ? Colors.white : AppColors.textTertiary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
