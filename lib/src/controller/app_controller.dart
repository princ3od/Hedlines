import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:hedlines/src/configs/application.dart';
import 'package:hedlines/src/constants/app_state.dart';
import 'package:hedlines/src/constants/constants.dart';
import 'package:hedlines/src/data/local_data_source/user_local_data.dart';
import 'package:hedlines/src/model/user_model.dart';
import 'package:hedlines/src/routes/app_pages.dart';
import 'package:hedlines/src/routes/app_routes.dart';

class AppController extends GetxController {
  static Rxn<UserModel> userInfo = Rxn<UserModel>();
  var appState = AppState.loading.obs;
  static var isAuthenticated = false.obs;

  Future<void> _setUpData(BuildContext context) async {
    await Application().initialAppLication(context);
    await Future.delayed(ANIMATION_DURATION_4000_MS);
    await getUserLocalStorageInfo();
    appState.value = AppState.loaded;
    update();
  }

  Future getUserLocalStorageInfo() async {
    UserModel? userModel = await UserLocal.getUserInfo();
    if (userModel != null) {
      userInfo.value = userModel;
      isAuthenticated.value = true;
    }
    update();
  }

  static Future<void> saveUserInfo() async {
    if (userInfo.value != null) {
      await UserLocal().saveUserInfo(userInfo.value?.toJson());
    }
  }

  void setUpData(BuildContext context) {
    _setUpData(context);
  }

  Future<void> signOut() async {
    await UserLocal.clearUserInfo();
    isAuthenticated.value = false;
    update();
    AppNavigator.pushNamedAndRemoveUntil(Routes.authentication);
  }

  static final AppController _singleton = AppController._internal();

  factory AppController() {
    return _singleton;
  }

  AppController._internal();
}
