import 'package:flutter/material.dart';

/// AppColors - Centralized color palette for Connect Well Nepal
/// 
/// This class defines the primary colors used throughout the app:
/// - Navy Blue: Represents trust and professionalism in healthcare
/// - Crimson Red: Honors the Nepalese flag
/// - Background colors: Clean and accessible
class AppColors {
  // Primary Color - Deep Navy Blue (Connect Well Blue)
  // Used for primary actions, headers, and branding
  static const Color primaryNavyBlue = Color(0xFF1A2F5A);
  
  // Secondary Color - Crimson Red (Nepal Red)
  // Used for accents, important CTAs, and complementary elements
  static const Color secondaryCrimsonRed = Color(0xFFDC143C);
  
  // Background Colors
  static const Color backgroundWhite = Color(0xFFFFFFFF);
  static const Color backgroundOffWhite = Color(0xFFF8F9FA);
  
  // Additional Utility Colors
  static const Color textPrimary = Color(0xFF212529);
  static const Color textSecondary = Color(0xFF6C757D);
  static const Color dividerGray = Color(0xFFDEE2E6);
  static const Color successGreen = Color(0xFF28A745);
  
  // Private constructor to prevent instantiation
  AppColors._();
}

