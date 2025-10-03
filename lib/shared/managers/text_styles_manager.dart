import 'package:flutter/material.dart';
import 'package:x_o_game/shared/apptheme.dart';
import 'package:x_o_game/shared/managers/font_manager.dart';

class TextStylesManager {
  // Headers
  static const TextStyle header = TextStyle(
    fontSize: FontSizeManager.header,
    fontWeight: FontWeightManager.semiBold,
    color: Apptheme.white,
    letterSpacing: 0.5,
  );
  
  // Button Text
  static const TextStyle button = TextStyle(
    fontSize: FontSizeManager.bodyLarge,
    fontWeight: FontWeightManager.semiBold,
    color: Apptheme.primary,
    letterSpacing: 0.3,
  );
  
  // Body Text
  static const TextStyle body = TextStyle(
    fontSize: FontSizeManager.bodyMedium,
    fontWeight: FontWeightManager.regular,
    color: Apptheme.silver,
  );
  
  // Caption/Small
  static const TextStyle caption = TextStyle(
    fontSize: FontSizeManager.caption,
    fontWeight: FontWeightManager.regular,
    color: Apptheme.silver,
  );
  
  // Large Stats Numbers
  static const TextStyle statsNumber = TextStyle(
    fontSize: FontSizeManager.largeNumber,
    fontWeight: FontWeightManager.bold,
    color: Apptheme.white,
  );
}

