import 'package:flutter/material.dart';

class Application {
  static bool isShowingError = false;
  Future<void> initialAppLication(BuildContext context) async {
    try {
      // await BaseLocalData.initialBox();
      // await Firebase.initializeApp();

      // Initial language
      // LanguageService().initialLanguage(context);

    } catch (error) {
      debugPrint(error.toString());
    }
  }

  ///Singleton factory
  static final Application _instance = Application._internal();

  factory Application() {
    return _instance;
  }

  Application._internal();
}
