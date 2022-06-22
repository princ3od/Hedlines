import 'package:hedlines/src/constants/storage_key.dart';
import 'package:hedlines/src/model/fake_model/account_model.dart';
import 'package:hedlines/src/model/fake_model/account_remember.dart';
import 'package:hive/hive.dart';

import '../../helper/utils/path_helper.dart';

class UserLocal {
  static late Box box;

  static Future<void> initialBox() async {
    var path = await PathHelper.appDir;
    Hive.init(path.path);
    box = await Hive.openBox(StorageKey.BOX_USER);
  }

  static Future<void> clearUserInfo() async {
    // await box.deleteAll([StorageKey.BOX_USER]);
    await box.clear();
  }

  static Future<UserModel?> getUserInfo() async {
    var str = await box.get(StorageKey.BOX_USER);
    if (str != null) {
      return UserModel.fromJson(str);
    }
    return null;
  }

  Future<void> saveUserInfo(dynamic a) async {
    await box.put(StorageKey.BOX_USER, a);
  }

  void saveAccountRemember(String email, String pass, bool isExpert) {
    AccountRemember accountRemember;
    var _userModel = box.get(StorageKey.LIST_ACCOUNT);
    if (_userModel == null) {
      accountRemember = AccountRemember(account: <Account>[]);
    } else {
      accountRemember = AccountRemember.fromJson(_userModel);
    }
    int indexOfRemember = accountRemember.account!.indexWhere((element) => element.email == email);
    if (indexOfRemember == -1) {
      accountRemember.account!.add(Account(
        email: email,
        password: pass,
      ));
      box.put(StorageKey.LIST_ACCOUNT, accountRemember.toJson());
    }
  }

  void deleteAccountRemember(String email) {
    AccountRemember accountRemember;
    var _userModel = box.get(StorageKey.LIST_ACCOUNT);
    if (_userModel == null) {
      accountRemember = AccountRemember(account: <Account>[]);
    } else {
      accountRemember = AccountRemember.fromJson(_userModel);
    }
    int indexOfRemember = accountRemember.account!.indexWhere((account) => account.email == email);
    if (indexOfRemember != -1) {
      accountRemember.account!.removeAt(indexOfRemember);
      box.put(StorageKey.LIST_ACCOUNT, accountRemember.toJson());
    }
  }

  AccountRemember? getAccountRemember() {
    var _accountLocal = box.get(StorageKey.LIST_ACCOUNT);
    if (_accountLocal == null) return null;

    return AccountRemember.fromJson(_accountLocal);
  }

  // System
  bool isSavedDarkMode() {
    return box.get(StorageKey.IS_DARK_MODE) ?? false;
  }

  void setDarkMode(bool value) {
    box.put(StorageKey.IS_DARK_MODE, value);
  }

  String getLocale() {
    return box.get(StorageKey.LOCALE) ?? 'vi';
  }

  Future<void> saveLocale(String locale) async {
    await box.put(StorageKey.LOCALE, locale);
  }

  UserModel getUser() {
    var _accountLocal = box.get(StorageKey.ACCOUNT);
    if (_accountLocal == null) {
      return UserModel(
        id: '',
        fullname: '',
        preferences: [],
      );
    }
    return UserModel.fromJson(_accountLocal);
  }

  void saveAccount(UserModel _userModel) {
    box.put(StorageKey.ACCOUNT, _userModel.toJson());
  }
}
