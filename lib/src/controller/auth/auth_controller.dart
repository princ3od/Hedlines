import 'package:get/get.dart';
import 'package:hedlines/src/constants/sign_type.dart';
import 'package:hedlines/src/controller/app_controller.dart';
import 'package:hedlines/src/model/user_model.dart';
import 'package:hedlines/src/model/social_model.dart';
import 'package:hedlines/src/routes/app_pages.dart';
import 'package:hedlines/src/routes/app_routes.dart';
import 'package:hedlines/src/services/auth_service/firebase_authentication.dart';

import '../../services/storage_service/user_storage.dart';

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
        break;
      case SignInType.email:
        break;
      case SignInType.phone:
        break;
    }
  }

  _signWithGoogle() async {
    isLoading.value = true;
    socialModel.value = await AuthService().signInWithGoogle();
    if (socialModel.value != null) {
      UserModel? userInfo =
          await UserInfoService().getUserInfo(socialModel.value!);
      if (userInfo == null) {
        UserModel userModelInfo = UserModel.fromSocial(socialModel.value!);
        await UserInfoService().addUser(userModelInfo);
        AppController.userInfo.value = userModelInfo;
      } else {
        AppController.userInfo.value = userInfo;
      }
    }
    isLoading.value = false;
    _checkIsUserAuthenticated();
    update();
  }

  _checkIsUserAuthenticated() {
    if (socialModel.value != null) {
      isAuthSuccess.value = true;
      _handelNaviation();
    } else {
      isAuthSuccess.value = false;
    }
  }

  _handelNaviation() {
    if (isAuthSuccess.value && AppController.userInfo.value == null) {
      AppNavigator.push(Routes.topic);
    }
    if (isAuthSuccess.value && AppController.userInfo.value != null) {
      if (AppController.userInfo.value!.preferences.isEmpty) {
        AppNavigator.push(Routes.topic);
      } else {
        AppNavigator.pushNamedAndRemoveUntil(Routes.home);
      }
    }
  }
}
