import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../data/local_data_source/user_local_data.dart';
import 'lang/language_service.dart';

class Application {
  static bool isShowingError = false;
  Future<void> initialAppLication(BuildContext context) async {
    try {
      await UserLocal.initialBox();
      await Firebase.initializeApp();
      // Initial language
      LanguageService().initialLanguage(context);
    } catch (error) {
      print(error);
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
