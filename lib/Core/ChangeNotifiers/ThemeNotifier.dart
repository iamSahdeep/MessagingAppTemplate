import 'package:flutter/material.dart';
import 'package:messaging_demo_flutter/Core/Data/SharedPrefs.dart';
import 'package:messaging_demo_flutter/Core/Helpers/Enums.dart';
import 'package:messaging_demo_flutter/Core/Helpers/ThemeData.dart';

class ThemeNotifier extends ChangeNotifier {
  ThemeData currentThemeData = ThemesData.light;

  ThemeNotifier() {
    init();
  }

  init() async {
    setCurrentTheme(AppTheme.values[await SharedPrefs.getSavedThemeKey()]);
  }

  bool isDarkMode() {
    return currentThemeData == ThemesData.dark;
  }

  void setCurrentTheme(AppTheme appTheme) {
    SharedPrefs.saveThemeKey(appTheme.index);
    currentThemeData = ThemesData.getThemeDataFromKey(appTheme);
    print(currentThemeData);
    notifyListeners();
  }

  void onSwitchChanged(bool value) {
    print(value);
    setCurrentTheme(value ? AppTheme.dark : AppTheme.light);
    notifyListeners();
  }
}
