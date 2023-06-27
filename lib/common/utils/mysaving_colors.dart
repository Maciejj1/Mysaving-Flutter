import 'package:flutter/material.dart';

import '../../config/services/theme_constants.dart';

class MySavingColors {
  MySavingColors._();

  static bool _initialized = false;

  static void init(BuildContext context) {
    if (!_initialized) {
      _initialized = true;
    }
  }

  // Colors

  static Color get defaultDarkText =>
      Color(DarkModeSwitch.isDarkMode ? 0xFFFFFFFF : 0xFF202020);
  static Color get defaultBlueButton =>
      Color(DarkModeSwitch.isDarkMode ? 0xFF212121 : 0xFF407AFF);
  static Color get defaultGreyText =>
      Color(DarkModeSwitch.isDarkMode ? 0xFFFFFFFF : 0xFF87898E);
  static Color get defaultGreen =>
      Color(DarkModeSwitch.isDarkMode ? 0xFFFFFFFF : 0xFF91F2C5);
  static Color get defaultRed =>
      Color(DarkModeSwitch.isDarkMode ? 0xFFFF6565 : 0xFFFF6565);
  static Color get defaultInputStroke =>
      Color(DarkModeSwitch.isDarkMode ? 0xFFFFFFFF : 0xFFDADADA);
  static Color get defaultLightBlueBackground =>
      Color(DarkModeSwitch.isDarkMode ? 0xFF212121 : 0xFFE4ECFF);
  static Color get defaultWhite =>
      Color(DarkModeSwitch.isDarkMode ? 0xFF212121 : 0xFFFFFFFF);
  static Color get defaultBackgroundPage =>
      Color(DarkModeSwitch.isDarkMode ? 0xFF1A1A1A : 0xFFFFFFFF);
  static Color get defaultThemeTextDark =>
      Color(DarkModeSwitch.isDarkMode ? 0xFFFFFFFF : 0x33202020);
  static Color get defaultThemeTextLight =>
      Color(DarkModeSwitch.isDarkMode ? 0x33FFFFFF : 0xFF202020);
  static Color get defaultCategories =>
      Color(DarkModeSwitch.isDarkMode ? 0xFF212121 : 0xFFFFFFFF);
  static Color get defaultExpensesText =>
      Color(DarkModeSwitch.isDarkMode ? 0xFF407AFF : 0xFF407AFF);
}
