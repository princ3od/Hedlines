import 'package:get/get.dart';
import 'package:hedlines/src/model/fake_model/account_model.dart';
import 'package:hedlines/src/services/auth_service/firebase_authentication.dart';

import '../../../constants/app_state.dart';
import '../../../routes/app_pages.dart';
import '../../../routes/app_routes.dart';
import '../../app_controller.dart';

class ProfileController extends GetxController {
  late Rx<AccountModel> userModel;

  @override
  void onInit() {
    super.onInit();
    userModel = AccountModel(
      topicPreferences: ["Du lịch", "Giải trí", "Thế thao"],
      avatar: "https://i.imgur.com/dg7LXZT.jpg",
      fullname: "Nguyễn Văn A",
      email: "nguyen.test@gmail.com",
      gender: 0,
    ).obs;
  }

  Future<void> signOut() async {
    await AuthService().signOut();
  }
}
