import 'package:flutter/material.dart';

import 'Enums.dart';

mixin ThemesData {
  static final ThemeData light = ThemeData(
      primaryColor: Colors.amber,
      scaffoldBackgroundColor: Colors.white,
      accentColor: Colors.pink,
      brightness: Brightness.light,
      primarySwatch: Colors.yellow);

  static final ThemeData dark = ThemeData(
      primaryColor: Colors.amber,
      scaffoldBackgroundColor: Colors.black,
      accentColor: Colors.pink,
      brightness: Brightness.dark,
      primarySwatch: Colors.yellow);

  static ThemeData getThemeDataFromKey(AppTheme key) {
    ThemeData top;
    switch (key) {
      case AppTheme.light:
        top = light;
        break;
      case AppTheme.dark:
        top = dark;
        break;
      default:
        top = light;
        break;
    }
    return top;
  }
}
