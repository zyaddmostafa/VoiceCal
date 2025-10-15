import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color primaryBlack = Color(0xFF0A0A0B);

  /// Darker variant of primary black
  static const Color primaryDark = Color(0xFF1A1A1C);

  /// Subtle shadow color derived from primary black
  static final Color primaryBlueShadow = primaryBlack.withValues(alpha: .08);

  // ============================================================================
  // TEXT COLORS
  // ============================================================================
  /// Primary text color - high contrast
  static const Color textPrimary = Color(0xFF0A0A0B);

  /// Secondary text color - medium contrast
  static const Color textSecondary = Color(0xFF6B7280);

  /// Tertiary text color - low contrast
  static const Color textTertiary = Color(0xFF9CA3AF);

  // ============================================================================
  // BACKGROUND COLORS
  // ============================================================================
  /// Primary background - pure white
  static const Color backgroundPrimary = Color(0xFFFFFFFF);

  /// Secondary background - light gray
  static const Color backgroundSecondary = Color(0xFFF9FAFB);

  /// Tertiary background - slightly darker gray
  static const Color backgroundTertiary = Color(0xFFF3F4F6);

  /// Card background color
  static const Color backgroundCard = Color(0xFFFFFFFF);

  // ============================================================================
  // SURFACE COLORS
  // ============================================================================
  /// Elevated surface color
  static const Color surfaceElevated = Color(0xFFFEFEFE);

  /// Surface color for accent-themed surfaces
  static const Color accentSurface = Color(0xFFECFEFF);

  // ============================================================================
  // ACCENT COLORS
  // ============================================================================
  /// Main accent color - sophisticated teal
  static const Color accent = Color(0xFF0891B2);

  // ============================================================================
  // MACRONUTRIENT COLORS (iOS System Colors)
  // ============================================================================
  /// Protein color - iOS red
  static const Color macroProtein = Color(0xFFFF453A);

  /// Carbohydrates color - iOS orange
  static const Color macroCarbs = Color(0xFFFF9F0A);

  /// Fats color - iOS blue
  static const Color macroFats = Color(0xFF0A84FF);

  // ============================================================================
  // SYSTEM STATUS COLORS
  // ============================================================================
  /// Success/positive state color
  static const Color success = Color(0xFF10B981);

  /// Error/negative state color
  static const Color error = Color(0xFFEF4444);

  /// Info surface color (light blue background)
  static const Color infoSurface = Color(0xFFEFF6FF);

  // ============================================================================
  // BORDER & DIVIDER COLORS
  // ============================================================================
  /// Standard border color
  static const Color border = Color(0xFFE5E7EB);

  /// Light border variant
  static const Color borderLight = Color(0xFFF3F4F6);

  /// Divider color (same as border for consistency)
  static const Color divider = Color(0xFFE5E7EB);

  // ============================================================================
  // SHADOW COLORS
  // ============================================================================
  /// Light shadow - subtle depth
  static final Color shadowLight = Colors.black.withValues(alpha: 0.02);

  /// Medium shadow - moderate depth
  static final Color shadowMedium = Colors.black.withValues(alpha: 0.06);

  /// Dark shadow - strong depth
  static final Color shadowDark = Colors.black.withValues(alpha: 0.10);

  /// Accent shadow - colored depth
  static final Color shadowAccent = accent.withValues(alpha: 0.15);

  // ============================================================================
  // GRADIENTS
  // ============================================================================
  /// Accent gradient - teal gradient (used in design system)
  static const LinearGradient accentGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF0891B2), Color(0xFF06B6D4)],
    stops: [0.0, 1.0],
  );

  /// Surface gradient - subtle white gradient for elevated cards
  static const LinearGradient surfaceGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [surfaceElevated, backgroundCard],
    stops: [0.0, 1.0],
  );
}
