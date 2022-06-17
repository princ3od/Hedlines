import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hedlines/src/constants/sign_type.dart';
import 'package:hedlines/src/model/fake_model/social_model.dart';
import 'package:hedlines/src/routes/app_pages.dart';
import 'package:hedlines/src/routes/app_routes.dart';
import 'package:hedlines/src/services/auth_service/firebase_authentication.dart';

class AuthenticationController extends GetxController {
  var isAuthSuccess = false.obs;
  var isLoading = false.obs;
  late Rxn<SocialModel?> socialModel = Rxn<SocialModel?>(null);

  Future onAuthentication(SignInType type) async {
    switch (type) {
      case SignInType.google:
        _signWithGoogle();
        break;

      case SignInType.facebook:
        // TODO: Handle this case.
        break;
      case SignInType.email:
        // TODO: Handle this case.
        break;
      case SignInType.phone:
        // TODO: Handle this case.
        break;
    }
  }

  _signWithGoogle() async {
    isLoading.value = true;
    socialModel.value = await AuthService().signInWithGoogle();
    isLoading.value = false;
    _checkIsUserAuthenticated();
    update();
  }

  _checkIsUserAuthenticated() {
    if (socialModel.value != null) {
      isAuthSuccess.value = true;
      _handelNaviationToHome();
    } else {
      isAuthSuccess.value = false;
    }
  }

  _handelNaviationToHome() {
    if (isAuthSuccess.value) {
      AppNavigator.push(Routes.TOPIC);
    }
  }
}
