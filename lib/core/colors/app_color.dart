import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color primary = Color(0xFF007AFF); // Blue
  static const Color secondary = Color(0xFF34C759); // Green

  // Backgrounds
  static const Color background = Color(0xFFF2F2F7); // system background
  static const Color secondaryBackground = Color(0xFFE5E5EA); // secondary bg

  //  translucent colors
  static Color translucentBackground({double opacity = 0.26}) =>
      Colors.white.withOpacity(opacity); // default 26%

  // Text Colors
  static const Color textPrimary = Colors.black;
  static const Color textSecondary = Colors.grey;

  // Shadows / Overlays
  static const Color shadow = Colors.black26;
}
