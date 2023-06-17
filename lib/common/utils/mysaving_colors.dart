import 'package:flutter/material.dart';

class MySavingColors {
  MySavingColors._();

  static BuildContext? _context;
  static bool _initialized = false;

  static void init(BuildContext context) {
    if (!_initialized) {
      _context = context;
      _initialized = true;
    }
  }

  static bool get dark =>
      _initialized &&
      MediaQuery.of(_context!).platformBrightness == Brightness.dark;

  // Colors

  static Color get defaultDarkText => Color(dark ? 0xFF061D00 : 0xFF202020);
  static Color get defaultBlueButton => Color(dark ? 0xFFFFFFFF : 0xFF407AFF);
  static Color get defaultGreyText => Color(dark ? 0xFFFFFFFF : 0xFF87898E);
  static Color get defaultGreen => Color(dark ? 0xFFFFFFFF : 0xFF91F2C5);
  static Color get defaultRed => Color(dark ? 0xFFFFFFFF : 0xFFFF6565);
}
