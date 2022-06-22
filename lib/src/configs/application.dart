import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../data/local_storage.dart';
import 'lang/language_service.dart';

class Application {
  static bool isShowingError = false;
  Future<void> initialAppLication(BuildContext context) async {
    try {
      await LocalStorage.initialBox();
      await Firebase.initializeApp();
      LanguageService().initialLanguage(context);
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  static final Application _instance = Application._internal();

  factory Application() {
    return _instance;
  }

  Application._internal();
}
