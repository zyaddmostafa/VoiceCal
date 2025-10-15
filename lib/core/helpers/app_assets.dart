/// A utility class that holds all asset paths used throughout the app.
/// This class provides a centralized location for managing image and SVG assets.
///
/// Example usage:
/// ```dart
/// SvgPicture.asset(AppAssets.protein)
/// Image.asset(AppAssets.appSplash)
/// ```
class AppAssets {
  // Private constructor to prevent instantiation
  AppAssets._();

  // ==================== SVG Assets ====================

  /// Authentication SVGs
  static const String appleLogo = 'assets/svgs/apple_logo.svg';
  static const String googleLogo = 'assets/svgs/google_logo.svg';

  /// Nutrition SVGs
  static const String protein = 'assets/svgs/protein.svg';
  static const String carbs = 'assets/svgs/carbs.svg';
  static const String fats = 'assets/svgs/fats.svg';
  static const String calories = 'assets/svgs/calories.svg';

  // ==================== Image Assets ====================

  /// App Images
  static const String appSplash = 'assets/app/app_splash.png';
  static const String appSplash12 = 'assets/app/app_splash_12.png';
}
