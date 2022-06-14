import 'package:flutter/material.dart';
import 'package:hedlines/src/data/local_data_source/user_local_data.dart';
import 'package:hedlines/src/routes/app_pages.dart';
import 'package:i18n_extension/i18n_widget.dart';

class LanguageService {
  ///Default Language
  static final locale = Locale('vi', 'VN');

  ///List Language support in Application
  static List<Locale> supportLanguage = [
    Locale("en"),
    Locale("vi"),
    Locale("da"),
    Locale("de"),
    Locale("el"),
    Locale("fr"),
    Locale("id"),
    Locale("ja"),
    Locale("ko"),
    Locale("nl"),
    Locale("zh"),
    Locale("ru"),
  ];

  switchLanguage() async {
    await UserLocal().saveLocale(((I18n.localeStr == "vi") ? "en" : "vi"));
    I18n.of(AppNavigator.context!).locale = (I18n.localeStr == "vi") ? null : const Locale("vi", "VN");
  }

  changeLanguage({bool isEnglish = false}) async {
    await UserLocal().saveLocale(isEnglish ? "en" : "vi");
    if (isEnglish) {
      I18n.of(AppNavigator.context!).locale = Locale("en", "US");
    } else {
      I18n.of(AppNavigator.context!).locale = Locale("vi", "VN");
    }
  }

  initialLanguage(context) {
    String localeStr = UserLocal().getLocale();
    if (localeStr == "vi") {
      I18n.of(context).locale = Locale("vi", "VN");
    } else {
      I18n.of(context).locale = Locale("en", "US");
    }
  }

  static bool getIsLanguage(String locale) {
    return UserLocal().getLocale() == locale;
  }
}
