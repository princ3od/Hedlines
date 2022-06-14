import 'package:askany/src/data/local_data_source/user_local_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum ThemeOptions { light, dark }

class ThemeService extends ChangeNotifier {
  static ThemeOptions themeOptions = ThemeOptions.light;
  static ThemeMode currentTheme = ThemeMode.light;
  static final systemBrightness = SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarBrightness: isSavedDarkMode() ? Brightness.light : Brightness.dark,
    statusBarIconBrightness: isSavedDarkMode() ? Brightness.light : Brightness.dark,
  );

  switchStatusColor() {
    SystemChrome.setSystemUIOverlayStyle(systemBrightness);
  }

  setStatusColor(isDark) {
    SystemChrome.setSystemUIOverlayStyle(
      !isDark ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light,
    );
  }

  ThemeMode getThemeMode() {
    switchStatusColor();
    return isSavedDarkMode() ? ThemeMode.dark : ThemeMode.light;
  }

  static bool isSavedDarkMode() {
    return UserLocal().isSavedDarkMode();
  }

  void saveThemeMode(bool isDarkMode) async {
    UserLocal().setDarkMode(isDarkMode);
  }

  void changeThemeMode() {
    saveThemeMode(!isSavedDarkMode());
    switchStatusColor();
    notifyListeners();
  }
}

ThemeService themeService = ThemeService();
