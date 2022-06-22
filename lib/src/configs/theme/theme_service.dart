import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hedlines/src/data/local_storage.dart';

enum ThemeOptions { light, dark }

class ThemeService extends ChangeNotifier {
  static ThemeOptions themeOptions = ThemeOptions.light;
  static ThemeMode currentTheme = ThemeMode.light;
  static final systemBrightness = SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarBrightness: isSavedDarkMode() ? Brightness.light : Brightness.dark,
    statusBarIconBrightness:
        isSavedDarkMode() ? Brightness.light : Brightness.dark,
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
    return LocalStorage().isSavedDarkMode();
  }

  void saveThemeMode(bool isDarkMode) async {
    LocalStorage().setDarkMode(isDarkMode);
  }

  void changeThemeMode() {
    saveThemeMode(!isSavedDarkMode());
    switchStatusColor();
    notifyListeners();
  }
}

ThemeService themeService = ThemeService();
