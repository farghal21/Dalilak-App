import 'package:flutter/material.dart';

import 'app_constants.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    fontFamily: AppConstants.fontFamily,
  );
}
