import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:hedlines/src/configs/application.dart';
import 'package:hedlines/src/constants/app_state.dart';
import 'package:hedlines/src/constants/constants.dart';

class AppController extends GetxController {
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
}
