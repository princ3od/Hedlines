import 'package:get/get.dart';
import 'package:hedlines/src/model/fake_model/account_model.dart';

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
}
