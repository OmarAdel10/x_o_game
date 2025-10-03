import 'package:flutter/material.dart';

class Apptheme {
  // App Colors
  static const Color primary = Color(0xFF1A2A33); // Main background
  static const Color semiDarkNavy = Color(0xFF1F3641); // container background
  static const Color deepDarkNavy = Color(0xFF192A32); // TextField background
  static const Color lightBlue = Color(0xFF31C3BD); // Player 1 Container
  static const Color lightYellow = Color(0xFFF2B137); // Player 2 Container
  static const Color silver = Color(0xFFA8BFC9); // Neutral/Secondary elements
  static const Color lightSilver = Color(
    0xFFDBE8ED,
  ); // Light buttons/inactive states
  static const Color white = Color(0xFFFFFFFF); // White text

  // Text Colors
  static const Color primaryText = Color(0xFFFFFFFF); // White text
  static const Color secondaryText = Color(0xFFA8BFC9); // Silver text
  
  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: primary,
  );
}
