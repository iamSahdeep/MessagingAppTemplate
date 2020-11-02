import 'package:messaging_demo_flutter/Core/Helpers/Constants.dart';
import 'package:messaging_demo_flutter/Core/Helpers/Enums.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static Future<int> getSavedThemeKey() async {
    final SharedPreferences myPrefs = await SharedPreferences.getInstance();
    return myPrefs.getInt(Constants.THEME_KEY) ?? AppTheme.light.index;
  }

  static Future<String> getSavedAuthToken() async {
    final SharedPreferences myPrefs = await SharedPreferences.getInstance();
    return myPrefs.getString(Constants.AUTH_TOKEN_KEY) ?? "";
  }

  static void saveAuthToken(String token) async {
    final SharedPreferences myPrefs = await SharedPreferences.getInstance();
    myPrefs.setString(Constants.AUTH_TOKEN_KEY, token);
  }

  static void saveThemeKey(int index) async {
    final SharedPreferences myPrefs = await SharedPreferences.getInstance();
    myPrefs.setInt(Constants.THEME_KEY, index);
  }
}
