import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:hedlines/src/configs/application.dart';
import 'package:hedlines/src/constants/app_state.dart';
import 'package:hedlines/src/constants/constants.dart';
import 'package:hedlines/src/model/fake_model/account_model.dart';
import 'package:hedlines/src/routes/app_pages.dart';
import 'package:hedlines/src/routes/app_routes.dart';

class AppController extends GetxController {
  static Rxn<UserModel> userInfo = Rxn<UserModel>();
  var appState = AppState.loading.obs;
  var isAuthenticated = false.obs;

  Future<void> _setUpData(BuildContext context) async {
    await Application().initialAppLication(context);
    await Future.delayed(ANIMATION_DURATION_4000_MS);
    appState.value = AppState.loaded;
    update();
  }

  void setUpData(BuildContext context) {
    _setUpData(context);
  }

  void signOut() {
    isAuthenticated.value = false;
    AppNavigator.pushNamedAndRemoveUntil(Routes.AUTHENTICATION);
  }

  static final AppController _singleton = AppController._internal();

  factory AppController() {
    return _singleton;
  }

  AppController._internal();
}
