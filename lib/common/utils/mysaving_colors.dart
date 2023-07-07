import 'package:flutter/material.dart';

import '../theme/theme_constants.dart';

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
      DarkModeSwitch.isDarkMode ? Color(0xFFFFFFFF) : Color(0xFF202020);
  static Color get defaultBlueButton =>
      DarkModeSwitch.isDarkMode ? Color(0xFF212121) : Color(0xFF407AFF);
  static Color get defaultGreyText =>
      DarkModeSwitch.isDarkMode ? Color(0xFFFFFFFF) : Color(0xFF87898E);
  static Color get defaultGreen =>
      DarkModeSwitch.isDarkMode ? Color(0xFFFFFFFF) : Color(0xFF91F2C5);
  static Color get defaultRed =>
      DarkModeSwitch.isDarkMode ? Color(0xFFFF6565) : Color(0xFFFF6565);
  static Color get defaultInputStroke =>
      DarkModeSwitch.isDarkMode ? Color(0xFFFFFFFF) : Color(0xFFDADADA);
  static Color get defaultLightBlueBackground =>
      DarkModeSwitch.isDarkMode ? Color(0xFF212121) : Color(0xFFE4ECFF);
  static Color get defaultWhite =>
      DarkModeSwitch.isDarkMode ? Color(0xFF212121) : Color(0xFFFFFFFF);
  static Color get defaultBackgroundPage =>
      DarkModeSwitch.isDarkMode ? Color(0xFF1A1A1A) : Color(0xFFFFFFFF);
  static Color get defaultThemeTextDark =>
      DarkModeSwitch.isDarkMode ? Color(0xFFFFFFFF) : Color(0x33202020);
  static Color get defaultThemeTextLight =>
      DarkModeSwitch.isDarkMode ? Color(0x33FFFFFF) : Color(0xFF202020);
  static Color get defaultCategories =>
      DarkModeSwitch.isDarkMode ? Color(0xFF212121) : Color(0xFFFFFFFF);
  static Color get defaultExpensesText =>
      DarkModeSwitch.isDarkMode ? Color(0xFF407AFF) : Color(0xFF407AFF);
}
