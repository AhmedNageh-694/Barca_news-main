import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// App color constants - Barca Theme
class AppColors {
  AppColors._();

  // Primary colors - Barca Identity
  static const Color primary = Color(0xFF181733); // Deep Navy
  static const Color primaryLight = Color(0xFF2C2B4B); // Lighter Navy
  static const Color primaryDark = Color(0xFF0F0E20); // Darker Navy

  static const Color secondary = Color(0xFFA50044); // Barca Garnet
  static const Color secondaryLight = Color(0xFFC71559);

  static const Color accent = Color(0xFFEDBB00); // Barca Yellow/Gold
  static const Color blue = Color(0xFF004D98); // Barca Blue

  // Neutral colors
  static const Color white = Colors.white;
  static const Color offWhite = Color(0xFFF5F6F8);
  static const Color black = Color(0xFF121212);
  static const Color grey = Color(0xFF9E9E9E);
  static const Color darkGrey = Color(0xFF1E1E1E);
  static const Color lightGrey = Color(0xFFF0F0F0);

  // States
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFE53935);
  static const Color warning = Color(0xFFFFB300);

  // Gradient colors
  static const List<Color> primaryGradient = [
    Color(0xFF181733),
    Color(0xFFA50044),
  ];
  static const List<Color> blueRedGradient = [
    Color(0xFF004D98),
    Color(0xFFA50044),
  ];
  static const List<Color> darkGradient = [primary, primaryDark];
}

/// App dimension constants
class AppDimensions {
  AppDimensions._();

  // Padding
  static const double paddingXS = 4.0;
  static const double paddingS = 8.0;
  static const double paddingM = 16.0;
  static const double paddingL = 24.0;
  static const double paddingXL = 32.0;
  static const double paddingXXL = 48.0;

  // Border radius
  static const double radiusS = 8.0;
  static const double radiusM = 12.0;
  static const double radiusL = 20.0;
  static const double radiusXL = 28.0;

  // Icon sizes
  static const double iconS = 18.0;
  static const double iconM = 24.0;
  static const double iconL = 32.0;
  static const double iconXL = 64.0;
  static const double iconXXL = 80.0;

  // Button height
  static const double buttonHeight = 56.0;

  // Card constraints
  static const double maxCardWidth = 400.0;
  static const double maxContentWidth = 800.0;
}

/// App text style constants
class AppTextStyles {
  AppTextStyles._();

  // Headings - Poppins
  static TextStyle get brandTitle => GoogleFonts.poppins(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    letterSpacing: -0.5,
  );

  static TextStyle get brandTitleMedium =>
      GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w600);

  static TextStyle get brandTitleSmall =>
      GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600);

  static TextStyle get display => GoogleFonts.poppins(
    fontSize: 48,
    fontWeight: FontWeight.bold,
    height: 1.1,
  );

  static TextStyle get headlineLarge =>
      GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold);

  static TextStyle get headlineMedium =>
      GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600);

  // Body - Inter
  static TextStyle get bodyLarge => GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    height: 1.5,
  );

  static TextStyle get bodyMedium => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    height: 1.5,
  );

  static TextStyle get bodySmall => GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: Colors.grey,
  );

  static TextStyle get buttonText => GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    letterSpacing: 0.5,
  );
}

/// App duration constants
class AppDurations {
  AppDurations._();

  static const Duration short = Duration(milliseconds: 200);
  static const Duration medium = Duration(milliseconds: 400);
  static const Duration long = Duration(milliseconds: 800);

  // Animation delays
  static const Duration staggerSmall = Duration(milliseconds: 50);
  static const Duration staggerMedium = Duration(milliseconds: 100);
}

/// App category constants
class AppCategories {
  AppCategories._();

  static const String defaultCategory = 'fcbarcelona';
  static const String barcelona = 'fcbarcelona';
  static const String football = 'football';
  static const String sports = 'sports';
}
