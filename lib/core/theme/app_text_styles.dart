import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_colors.dart';

class AppTextStyles {
  // Font family - Modern rounded sans-serif
  static const String _fontFamily = 'SF Pro Display';

  // Display headings - Premium hierarchy with rounded font
  static TextStyle get displayLarge => TextStyle(
    fontFamily: _fontFamily,
    fontSize: 36.sp,
    fontWeight: FontWeight.w700, // Bold
    color: AppColors.textPrimary,
    letterSpacing: -0.5,
    height: 1.1,
  );

  static TextStyle get displayMedium => TextStyle(
    fontFamily: _fontFamily,
    fontSize: 32.sp,
    fontWeight: FontWeight.w700, // Bold
    color: AppColors.textPrimary,
    letterSpacing: -0.4,
    height: 1.15,
  );

  // Headings - Clear hierarchy
  static TextStyle get headingLarge => TextStyle(
    fontFamily: _fontFamily,
    fontSize: 24.sp,
    fontWeight: FontWeight.w600, // SemiBold
    color: AppColors.textPrimary,
    letterSpacing: -0.2,
    height: 1.25,
  );

  // Legacy support - Enhanced with font family
  static TextStyle get font32BoldPrimary => displayMedium;
  static TextStyle get font32Bold => displayMedium;
  static TextStyle get font32ExtraBold => TextStyle(
    fontFamily: _fontFamily,
    fontSize: 32.sp,
    fontWeight: FontWeight.w800,
    letterSpacing: -0.6,
    height: 1.05,
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

  // Body Text - Modern and readable
  static TextStyle get bodyLarge => TextStyle(
    fontFamily: _fontFamily,
    fontSize: 17.sp,
    fontWeight: FontWeight.w400, // Regular
    color: AppColors.textPrimary,
    height: 1.5,
    letterSpacing: 0,
  );

  static TextStyle get bodyMedium => TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16.sp,
    fontWeight: FontWeight.w400, // Regular
    color: AppColors.textPrimary,
    height: 1.5,
    letterSpacing: 0,
  );

  static TextStyle get bodySmall => TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14.sp,
    fontWeight: FontWeight.w400, // Regular
    color: AppColors.textSecondary,
    height: 1.4,
    letterSpacing: 0.1,
  );

  // Label styles - Medium weight for UI elements
  static TextStyle get labelLarge => TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16.sp,
    fontWeight: FontWeight.w500, // Medium
    color: AppColors.textPrimary,
    height: 1.4,
    letterSpacing: 0.1,
  );

  static TextStyle get labelMedium => TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14.sp,
    fontWeight: FontWeight.w500, // Medium
    color: AppColors.textPrimary,
    height: 1.4,
    letterSpacing: 0.2,
  );

  static TextStyle get labelSmall => TextStyle(
    fontFamily: _fontFamily,
    fontSize: 12.sp,
    fontWeight: FontWeight.w500, // Medium
    color: AppColors.textSecondary,
    height: 1.3,
    letterSpacing: 0.3,
  );

  // Body Text - Legacy support
  static TextStyle get font17RegularSecondary => TextStyle(
    fontSize: 17.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    height: 1.5,
    letterSpacing: -0.2,
  );

  static TextStyle get font17SemiBoldWhite => TextStyle(
    fontSize: 17.sp,
    fontWeight: FontWeight.w600,
    color: Colors.white,
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

  static TextStyle get font20SemiBoldPrimary => TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
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

  // Analytics specific styles
  static TextStyle get font14RegularGrey => TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    color: Colors.grey,
  );

  static TextStyle get font16SemiBoldBlack87 => TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    color: Colors.black87,
  );

  static TextStyle get font10MediumGrey => TextStyle(
    fontSize: 10.sp,
    fontWeight: FontWeight.w500,
    color: Colors.grey,
  );

  static TextStyle get font10MediumBlack70 => TextStyle(
    fontSize: 10.sp,
    fontWeight: FontWeight.w500,
    color: Colors.black.withValues(alpha: 0.7),
  );

  static TextStyle font12MediumConditional({required bool isSelected}) =>
      TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        color: isSelected ? Colors.white : Colors.grey[700],
      );

  static TextStyle font14MediumConditional({required bool isSelected}) =>
      TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: isSelected ? Colors.white : Colors.grey[700],
      );

  static TextStyle get font16SemiBoldGrey700 => TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    color: Colors.grey[700],
  );

  static TextStyle get font12SemiBoldGreen700 => TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w600,
    color: Colors.green[700],
  );

  static TextStyle get font12RegularGrey600 => TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    color: Colors.grey[600],
  );

  static TextStyle get font18SemiBoldBlack87 => TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.w600,
    color: Colors.black87,
  );

  static TextStyle get font12MediumGrey600 => TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
    color: Colors.grey[600],
  );
}
