import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hedlines/src/configs/theme/app_colors.dart';
import 'package:hedlines/src/constants/constants.dart';

class AppTheme {
  AppTheme({
    required this.mode,
    required this.data,
    required this.appColors,
  });

  factory AppTheme.light() {
    const mode = ThemeMode.light;
    final appColors = AppColors.light();
    final themeData = ThemeData(
      pageTransitionsTheme: const PageTransitionsTheme(builders: {
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      }),
      brightness: Brightness.light,
      primaryColor: appColors.primary,
      scaffoldBackgroundColor: appColors.background,
      snackBarTheme: SnackBarThemeData(
        backgroundColor: appColors.error,
        behavior: SnackBarBehavior.floating,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: appColors.background,
        selectedItemColor: colorPrimary,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: appColors.background,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
        ),
        iconTheme: IconThemeData(
          color: appColors.contentText1,
        ),
      ),
      textTheme: TextTheme(
        headline1: TextStyle(color: appColors.header),
        headline2: TextStyle(color: appColors.header),
        bodyText1: TextStyle(color: appColors.contentText1),
        bodyText2: TextStyle(color: appColors.contentText2),
      ),
      dividerColor: appColors.divider,
      fontFamily: HEDLINES_FONT,
    );
    return AppTheme(
      mode: mode,
      data: themeData,
      appColors: appColors,
    );
  }

  factory AppTheme.dark() {
    const mode = ThemeMode.dark;
    final appColors = AppColors.dark();
    final themeData = ThemeData(
      brightness: Brightness.dark,
      primaryColor: appColors.primary,
      scaffoldBackgroundColor: appColors.background,
      snackBarTheme: SnackBarThemeData(
        backgroundColor: appColors.error,
        behavior: SnackBarBehavior.floating,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: appColors.background,
        selectedItemColor: colorPrimary,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: appColors.background,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
        ),
        iconTheme: IconThemeData(
          color: appColors.contentText1,
        ),
      ),
      textTheme: TextTheme(
        headline1: TextStyle(color: appColors.header),
        headline2: TextStyle(color: appColors.header),
        bodyText1: TextStyle(color: appColors.contentText1),
        bodyText2: TextStyle(color: appColors.contentText2),
      ),
      dividerColor: appColors.divider,
      fontFamily: NUNITO_SANS,
    );
    return AppTheme(
      mode: mode,
      data: themeData,
      appColors: appColors,
    );
  }

  final ThemeMode mode;
  final ThemeData data;
  final AppColors appColors;
}
