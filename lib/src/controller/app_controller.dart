import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hedlines/src/configs/application.dart';
import 'package:hedlines/src/constants/app_state.dart';
import 'package:hedlines/src/constants/constants.dart';
import 'package:hedlines/src/model/user_model.dart';
import 'package:hedlines/src/routes/app_pages.dart';
import 'package:hedlines/src/routes/app_routes.dart';

import '../services/storage_service/user_storage.dart';

class AppController extends GetxController {
  static Rxn<UserModel> userInfo = Rxn<UserModel>();
  var appState = AppState.loading.obs;
  static var isAuthenticated = false.obs;

  Future<void> _setUpData(BuildContext context) async {
    await Application().initialAppLication(context);
    await Future.delayed(ANIMATION_DURATION_3000_MS);
    await checkLogin();
    appState.value = AppState.loaded;
    update();
  }

  Future checkLogin() async {
    if (FirebaseAuth.instance.currentUser != null) {
      var userModel = await UserInfoService()
          .getUser(FirebaseAuth.instance.currentUser!.uid);
      userInfo.value = userModel;
      isAuthenticated.value = true;
    }
    update();
  }

  void setUpData(BuildContext context) {
    _setUpData(context);
  }

  Future<void> signOut() async {
    isAuthenticated.value = false;
    update();
    Get.deleteAll(force: true);
    AppNavigator.pushNamedAndRemoveUntil(Routes.authentication);
  }

  static final AppController _singleton = AppController._internal();

  factory AppController() {
    return _singleton;
  }

  AppController._internal();
}
