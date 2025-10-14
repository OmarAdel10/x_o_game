import 'dart:ui';

class FontSizeManager {
  // Headers
  static const double largeHeader = 32.0; // Main Titles
  static const double mediumHeader = 28.0; // Main Titles
  static const double header = 24.0; // Main Titles
  static const double subheader = 20.0; // "Coin Flip!", "Bot Challenge"
  static const double sectionTitle = 16.0; // Settings Section Titles

  // Body Text
  static const double bodyLarge = 18.0; // Button text (primary actions)
  static const double bodyMedium = 16.0; // Regular body text
  static const double bodySmall = 14.0; // Secondary text, labels

  // Small Text
  static const double caption = 13.0; // Text Fields
  static const double tiny = 12.0; // Stats numbers, dates

  // Numbers/Stats
  static const double largeNumber = 32.0; // Big stats numbers "23", "19"
  static const double mediumNumber = 24.0; // Score display "0"
  static const double smallNumber = 16.0; // Win rate percentages
}

class FontWeightManager {
  static const FontWeight light = FontWeight.w300; // Not used heavily
  static const FontWeight regular = FontWeight.w400; // Body text
  static const FontWeight sectionTitles = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600; // Button text, headers
  static const FontWeight bold = FontWeight.w700; // Large numbers, emphasis
  static const FontWeight extraBold = FontWeight.w800;
}
