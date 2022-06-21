import 'package:get/get.dart';
import 'package:hedlines/src/routes/app_pages.dart';
import 'package:hedlines/src/routes/app_routes.dart';

import '../../services/storage_service/user_storage.dart';

class TopicController extends GetxController {
  var isNavigate = false.obs;
  Future<void> handelNagivateToHome(Set<String> topics) async {
    await _handelUserTopic(topics);
    _handelSetUpContext();
    AppNavigator.pushNamedAndRemoveUntil(Routes.HOME);
  }

  Future<void> _handelUserTopic(Set<String> topics) async {
    await UserInfoService().setUserTopics(topics);
  }

  void _handelSetUpContext() {}
  @override
  void onInit() {
    super.onInit();
  }
}
