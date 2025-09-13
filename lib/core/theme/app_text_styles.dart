import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_colors.dart';

class AppTextStyles {
  // Large Headings
  static TextStyle get font32BoldPrimary => TextStyle(
    fontSize: 32.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    letterSpacing: -0.5,
    height: 1.1,
  );

  static TextStyle get font32Bold => TextStyle(
    fontSize: 32.sp,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.5,
  );

  static TextStyle get font32ExtraBold => TextStyle(
    fontSize: 32.sp,
    fontWeight: FontWeight.w800,
    letterSpacing: -0.5,
  );

  static const TextStyle font28BoldBlack = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  // Medium Headings
  static TextStyle get font20RegularPrimary => TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
  );
  static TextStyle get font18SemiBoldPrimary => TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static TextStyle get font18SemiBoldBlack => TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.primaryBlack,
  );

  // Body Text
  static TextStyle get font17RegularSecondary => TextStyle(
    fontSize: 17.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    height: 1.4,
    letterSpacing: -0.2,
  );

  static TextStyle get font17SemiBoldWhite => TextStyle(
    fontSize: 17.sp,
    fontWeight: FontWeight.w600,
    color: Colors.white,
    letterSpacing: -0.2,
  );

  static TextStyle get font17SemiBoldDisabled => TextStyle(
    fontSize: 17.sp,
    fontWeight: FontWeight.w600,
    color: const Color(0xFF8E8E93),
    letterSpacing: -0.2,
  );

  static TextStyle get font16MediumBlack => TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.primaryBlack,
    letterSpacing: -0.2,
  );
  static TextStyle get font18MediumBlack => TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.primaryBlack,
    letterSpacing: -0.2,
  );

  static TextStyle get font16RegularSecondary => TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    letterSpacing: -0.2,
  );

  static TextStyle get font16MediumWhite => TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
    color: Colors.white,
    letterSpacing: -0.2,
  );

  static TextStyle get font18SemiBoldWhite => TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  // Small Text
  static TextStyle get font14RegularSecondary => TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  static TextStyle get font14MediumPrimary => TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );

  static TextStyle get font14SemiBoldWhite => TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
  static TextStyle get font12SemiBoldWhite => TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
  static TextStyle get font12RegularSecondary => TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    letterSpacing: -0.1,
  );

  static TextStyle get font12MediumPrimary => TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    letterSpacing: -0.1,
  );
  static TextStyle get font12MediumWhite => TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
    color: Colors.white,
    letterSpacing: -0.1,
  );
  // Special Purpose
  static TextStyle get fontBlueLink =>
      const TextStyle(color: Color(0xFF007AFF));

  static TextStyle get font15MediumBlack => TextStyle(
    fontSize: 15.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.primaryBlack,
  );

  static TextStyle get font20SemiBoldPrimary => TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static TextStyle get fontPicker => TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
  );

  static TextStyle get fontPickerSelected => TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.primaryBlack,
  );

  // Conditional styles with parameters
  static TextStyle font18SemiBoldConditional({required bool isSelected}) =>
      TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
        color: isSelected ? AppColors.primaryBlack : AppColors.textPrimary,
      );

  static TextStyle font17SemiBoldConditional({required bool isEnabled}) =>
      TextStyle(
        fontSize: 17.sp,
        fontWeight: FontWeight.w600,
        color: isEnabled ? Colors.white : const Color(0xFF8E8E93),
        letterSpacing: -0.2,
      );

  static TextStyle font16MediumConditional({required bool isSelected}) =>
      TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        color: isSelected ? AppColors.primaryBlack : AppColors.textSecondary,
        letterSpacing: -0.2,
      );

  // Loading screen specific styles
  static TextStyle get font48ExtraBoldPrimary => TextStyle(
    fontSize: 48.sp,
    fontWeight: FontWeight.w800,
    color: AppColors.textPrimary,
    letterSpacing: -1.0,
  );

  static TextStyle get font30SemiBoldPrimary => TextStyle(
    fontSize: 30.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.primaryBlack,
  );

  static TextStyle get font18BoldPrimary => TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  static TextStyle font16MediumSuccess({required bool isComplete}) => TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
    color: isComplete ? AppColors.success : AppColors.textSecondary,
  );
}
