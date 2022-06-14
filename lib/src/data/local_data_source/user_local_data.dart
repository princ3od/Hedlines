import 'package:hedlines/src/constants/storage_key.dart';
import 'package:hedlines/src/model/fake_model/account_model.dart';
import 'package:hedlines/src/model/fake_model/account_remember.dart';
import 'package:hive/hive.dart';

class UserLocal {
  var box = Hive.box(StorageKey.BOX_USER);
  void saveAccountRemember(String email, String pass, bool isExpert) {
    AccountRemember accountRemember;
    var _accountModel = box.get(StorageKey.LIST_ACCOUNT);
    if (_accountModel == null) {
      accountRemember = AccountRemember(account: <Account>[]);
    } else {
      accountRemember = AccountRemember.fromJson(_accountModel);
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
    var _accountModel = box.get(StorageKey.LIST_ACCOUNT);
    if (_accountModel == null) {
      accountRemember = AccountRemember(account: <Account>[]);
    } else {
      accountRemember = AccountRemember.fromJson(_accountModel);
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

  // User
  String getAccessToken() {
    return box.get(StorageKey.TOKEN) ?? '';
  }

  String getBackupToken() {
    return box.get(StorageKey.BACKUP_TOKEN) ?? '';
  }

  bool getIsExpert() {
    return box.get(StorageKey.IS_EXPERT) ?? false;
  }

  bool getIsVerifyPhone() {
    return box.get(StorageKey.IS_VERIFY_PHONE) ?? false;
  }

  AccountModel getUser() {
    var _accountLocal = box.get(StorageKey.ACCOUNT);
    if (_accountLocal == null) {
      return AccountModel(
        id: '',
        fullname: '',
      );
    }
    return AccountModel.fromJson(_accountLocal);
  }

  void saveAccessToken(String token) async {
    box.put(StorageKey.TOKEN, token);
  }

  void saveBackupToken(String token) async {
    box.put(StorageKey.BACKUP_TOKEN, token);
  }

  void saveIsExpert(bool value) async {
    box.put(StorageKey.IS_EXPERT, value);
  }

  void clearAccessToken() async {
    box.delete(StorageKey.TOKEN);
  }

  void clearBackupToken() async {
    box.delete(StorageKey.BACKUP_TOKEN);
  }

  void clearUser() async {
    box.delete(StorageKey.ACCOUNT);
  }

  void saveAccount(AccountModel _accountModel) {
    box.put(StorageKey.ACCOUNT, _accountModel.toJson());
  }

  bool getShouldShowTutorial() {
    return box.get(StorageKey.SHOULD_SHOWN_TUTORIAL) ?? true;
  }

  void showedTutorial() {
    box.put(StorageKey.SHOULD_SHOWN_TUTORIAL, false);
  }
}
