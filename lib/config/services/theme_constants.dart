import 'package:flutter/material.dart';

import '../../common/theme/mysaving_themes.dart';

class DarkModeSwitch {
  static bool _isDarkMode = false;

  static bool get isDarkMode => _isDarkMode;

  static void toggleDarkMode() {
    _isDarkMode = !_isDarkMode;
  }
}
