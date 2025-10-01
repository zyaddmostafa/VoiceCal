import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_colors.dart';

class AppDesignSystem {
  static List<BoxShadow> get cardShadow => [
    BoxShadow(
      color: AppColors.shadowMedium,
      blurRadius: 24,
      offset: Offset(0, 6.h),
      spreadRadius: -2,
    ),
    BoxShadow(
      color: AppColors.shadowLight,
      blurRadius: 8,
      offset: Offset(0, 2.h),
      spreadRadius: 0,
    ),
  ];

  static List<BoxShadow> get cardShadowSmall => [
    BoxShadow(
      color: AppColors.shadowMedium,
      blurRadius: 16,
      offset: Offset(0, 4.h),
      spreadRadius: -1,
    ),
    BoxShadow(
      color: AppColors.shadowLight,
      blurRadius: 4,
      offset: Offset(0, 1.h),
      spreadRadius: 0,
    ),
  ];

  static List<BoxShadow> get cardShadowLarge => [
    BoxShadow(
      color: AppColors.shadowDark,
      blurRadius: 40,
      offset: Offset(0, 12.h),
      spreadRadius: -4,
    ),
    BoxShadow(
      color: AppColors.shadowMedium,
      blurRadius: 16,
      offset: Offset(0, 6.h),
      spreadRadius: -2,
    ),
  ];

  // Button shadows with accent color
  static List<BoxShadow> get buttonShadow => [
    BoxShadow(
      color: AppColors.shadowAccent,
      blurRadius: 20,
      offset: Offset(0, 4.h),
      spreadRadius: 0,
    ),
    BoxShadow(
      color: AppColors.shadowLight,
      blurRadius: 8,
      offset: Offset(0, 2.h),
      spreadRadius: 0,
    ),
  ];

  // Elevated surface shadow
  static List<BoxShadow> get elevatedShadow => [
    BoxShadow(
      color: AppColors.shadowLight,
      blurRadius: 8,
      offset: Offset(0, 2.h),
      spreadRadius: 0,
    ),
  ];

  // Border radius constants - Modern and soft
  static BorderRadius get radiusTiny => BorderRadius.circular(6.r);
  static BorderRadius get radiusSmall => BorderRadius.circular(10.r);
  static BorderRadius get radiusMedium => BorderRadius.circular(14.r);
  static BorderRadius get radiusLarge => BorderRadius.circular(18.r);
  static BorderRadius get radiusXLarge => BorderRadius.circular(22.r);
  static BorderRadius get radiusXXLarge => BorderRadius.circular(28.r);
  static BorderRadius get radiusRound => BorderRadius.circular(50.r);

  // Standard spacing values
  static EdgeInsets get paddingTiny => EdgeInsets.all(4.r);
  static EdgeInsets get paddingSmall => EdgeInsets.all(8.r);
  static EdgeInsets get paddingMedium => EdgeInsets.all(12.r);
  static EdgeInsets get paddingLarge => EdgeInsets.all(16.r);
  static EdgeInsets get paddingXLarge => EdgeInsets.all(20.r);
  static EdgeInsets get paddingXXLarge => EdgeInsets.all(24.r);

  // Card decorations - Premium and modern
  static BoxDecoration get primaryCard => BoxDecoration(
    color: AppColors.backgroundCard,
    borderRadius: radiusLarge,
    border: const Border.fromBorderSide(
      BorderSide(color: AppColors.border, width: 1),
    ),
    boxShadow: cardShadow,
  );

  static BoxDecoration get elevatedCard => BoxDecoration(
    gradient: AppColors.surfaceGradient,
    borderRadius: radiusLarge,
    border: const Border.fromBorderSide(
      BorderSide(color: AppColors.borderLight, width: 1),
    ),
    boxShadow: cardShadowSmall,
  );

  static BoxDecoration get surfaceCard => BoxDecoration(
    color: AppColors.surfaceElevated,
    borderRadius: radiusMedium,
    border: const Border.fromBorderSide(
      BorderSide(color: AppColors.borderLight, width: 1),
    ),
    boxShadow: elevatedShadow,
  );

  static BoxDecoration get accentCard => BoxDecoration(
    color: AppColors.accentSurface,
    borderRadius: radiusLarge,
    border: Border.all(
      color: AppColors.accent.withValues(alpha: 0.2),
      width: 1,
    ),
    boxShadow: [
      BoxShadow(
        color: AppColors.accent.withValues(alpha: 0.1),
        blurRadius: 16,
        offset: Offset(0, 4.h),
        spreadRadius: 0,
      ),
    ],
  );

  // Icon container decorations - Modern and soft
  static BoxDecoration iconContainer(Color color) => BoxDecoration(
    color: color.withValues(alpha: 0.08),
    borderRadius: radiusSmall,
  );

  static BoxDecoration iconContainerGradient(Color color) => BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [color.withValues(alpha: 0.12), color.withValues(alpha: 0.06)],
    ),
    borderRadius: radiusSmall,
    border: Border.all(color: color.withValues(alpha: 0.1), width: 0.5),
  );

  // Button decorations - Modern accent-based design
  static BoxDecoration get primaryButton => BoxDecoration(
    gradient: AppColors.accentGradient,
    borderRadius: radiusXXLarge,
    boxShadow: buttonShadow,
  );

  static BoxDecoration get secondaryButton => BoxDecoration(
    color: AppColors.backgroundSecondary,
    borderRadius: radiusXXLarge,
    border: const Border.fromBorderSide(
      BorderSide(color: AppColors.border, width: 1),
    ),
    boxShadow: elevatedShadow,
  );

  static BoxDecoration get tertiaryButton => BoxDecoration(
    color: AppColors.backgroundCard,
    borderRadius: radiusXXLarge,
    border: const Border.fromBorderSide(
      BorderSide(color: AppColors.borderLight, width: 1),
    ),
  );

  // Progress indicator styles
  static BoxDecoration get progressTrack => BoxDecoration(
    color: AppColors.backgroundTertiary,
    borderRadius: BorderRadius.circular(8.r),
  );

  static BoxDecoration progressFill(Color color) => BoxDecoration(
    gradient: LinearGradient(colors: [color, color.withValues(alpha: 0.8)]),
    borderRadius: BorderRadius.circular(8.r),
    boxShadow: [
      BoxShadow(
        color: color.withValues(alpha: 0.3),
        blurRadius: 4,
        offset: Offset(0, 2.h),
      ),
    ],
  );

  // Animation durations
  static const Duration animationFast = Duration(milliseconds: 200);
  static const Duration animationNormal = Duration(milliseconds: 300);
  static const Duration animationSlow = Duration(milliseconds: 500);

  // Animation curves
  static const Curve curveSmooth = Curves.easeOutCubic;
  static const Curve curveBounce = Curves.elasticOut;
  static const Curve curveSharp = Curves.easeInOutCubic;
}
