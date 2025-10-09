import 'package:flutter/material.dart';

class AppColors {
  // Primary colors - Modern light theme with premium feel
  static const Color primaryBlack = Color(0xFF0A0A0B);
  static const Color primaryDark = Color(0xFF1A1A1C);
  static final Color primaryBlueShadow = primaryBlack.withValues(alpha: .08);

  // Text colors - Modern hierarchy with excellent readability
  static const Color textPrimary = Color(0xFF0A0A0B);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textTertiary = Color(0xFF9CA3AF);
  static const Color textDisabled = Color(0xFFD1D5DB);

  // Background colors - Pure and soft
  static const Color backgroundPrimary = Color(0xFFFFFFFF);
  static const Color backgroundSecondary = Color(0xFFF9FAFB);
  static const Color backgroundTertiary = Color(0xFFF3F4F6);
  static const Color backgroundCard = Color(0xFFFFFFFF);

  // Premium surface colors - Subtle variations
  static const Color surfaceElevated = Color(0xFFFEFEFE);
  static const Color surfaceContainer = Color(0xFFFCFCFD);
  static const Color surfaceOverlay = Color(0xFFF8F9FA);

  // Modern accent color - Sophisticated teal
  static const Color accent = Color(0xFF0891B2);
  static const Color accentLight = Color(0xFF06B6D4);
  static const Color accentDark = Color(0xFF0E7490);
  static const Color accentSurface = Color(0xFFECFEFF);

  // System colors - Refined and accessible
  static const Color success = Color(0xFF10B981);
  static const Color successLight = Color(0xFF34D399);
  static const Color successSurface = Color(0xFFECFDF5);

  static const Color warning = Color(0xFFF59E0B);
  static const Color warningLight = Color(0xFFFBBF24);
  static const Color warningSurface = Color(0xFFFFFBEB);

  static const Color error = Color(0xFFEF4444);
  static const Color errorLight = Color(0xFFF87171);
  static const Color errorSurface = Color(0xFFFEF2F2);

  static const Color info = Color(0xFF3B82F6);
  static const Color infoLight = Color(0xFF60A5FA);
  static const Color infoSurface = Color(0xFFEFF6FF);

  // Border colors - Soft and modern
  static const Color border = Color(0xFFE5E7EB);
  static const Color borderLight = Color(0xFFF3F4F6);
  static const Color borderSecondary = Color(0xFFD1D5DB);
  static const Color divider = Color(0xFFE5E7EB);

  // Shadow colors - Subtle depth
  static final Color shadowLight = Colors.black.withValues(alpha: 0.02);
  static final Color shadowMedium = Colors.black.withValues(alpha: 0.06);
  static final Color shadowDark = Colors.black.withValues(alpha: 0.10);
  static final Color shadowAccent = accent.withValues(alpha: 0.15);

  // Gradient definitions - Premium and sophisticated
  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFFFFFFF), Color(0xFFFEFEFE)],
    stops: [0.0, 1.0],
  );

  static const LinearGradient accentGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [accent, accentLight],
    stops: [0.0, 1.0],
  );

  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryBlack, primaryDark],
    stops: [0.0, 1.0],
  );

  static const LinearGradient successGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [success, successLight],
    stops: [0.0, 1.0],
  );

  static const LinearGradient surfaceGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [surfaceElevated, backgroundCard],
    stops: [0.0, 1.0],
  );
}
