import 'package:get/get.dart';
import 'package:hedlines/src/model/fake_model/account_model.dart';
import 'package:hedlines/src/services/auth_service/firebase_authentication.dart';

class ProfileController extends GetxController {
  late Rx<UserModel> userModel;

  @override
  void onInit() {
    super.onInit();
    userModel = UserModel(
      preferences: ["Du lịch", "Giải trí", "Thế thao"],
      avatar: "https://i.imgur.com/dg7LXZT.jpg",
      fullname: "Nguyễn Văn A",
      email: "nguyen.test@gmail.com",
    ).obs;
  }

  Future<void> signOut() async {
    await AuthService().signOut();
  }
}
