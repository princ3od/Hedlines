import 'package:hedlines/src/constants/storage_key.dart';
import 'package:hive/hive.dart';

import '../helper/utils/path_helper.dart';

class LocalStorage {
  static late Box box;

  static Future<void> initialBox() async {
    var path = await PathHelper.appDir;
    Hive.init(path.path);
    box = await Hive.openBox(StorageKey.appBox);
  }

  bool isSavedDarkMode() {
    return box.get(StorageKey.isDarkMode) ?? false;
  }

  void setDarkMode(bool value) {
    box.put(StorageKey.isDarkMode, value);
  }

  static bool isFirstOpen() {
    return box.get(StorageKey.isFirstOpen) ?? true;
  }

  static void setFirstOpen(bool value) {
    box.put(StorageKey.isFirstOpen, value);
  }

  String getLocale() {
    return box.get(StorageKey.locale) ?? 'vi';
  }

  Future<void> saveLocale(String locale) async {
    await box.put(StorageKey.locale, locale);
  }
}
