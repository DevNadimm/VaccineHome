import 'package:flutter/material.dart';

class AppColors {
  AppColors._();
  // Base Colors
  static const Color backgroundColor = Color(0xFFF9F9F9);
  static const Color cardColor = Color(0xFFFFFFFF); // Pure white cards
  // static const Color cardColor = Color(0xFFEEEEEE);
  static const Color cardColorBold = Color(0xFFE0E0E0);

  // Primary Theme Colors
  static const Color primaryColor = Color(0xff6a1b9a);
  static const Color buttonFontColor = Color(0xFFFFFFFF);
  static const Color primaryFontColor = Color(0xFF222222);
  static const Color secondaryFontColor = Color(0xFF555555);

  // Additional Colors
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color grey = Colors.grey;

  // Status Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFF44336);
  static const Color warning = Color(0xFFF57C00);
  static const Color info = Color(0xFF2196F3);

  // Transparent Variants
  static const Color primaryColorTransparent = Color(0x80a54fd8);
  static const Color cardOverlay = Color(0x11CCCCCC);

  // Input Border Color
  static const Color inputBorderColor = Color(0xFFCCCCCC);
  static const Color inputBorderFocusedColor = primaryColor;
}
