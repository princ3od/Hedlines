import 'package:get/get.dart';
import 'package:hedlines/src/routes/app_pages.dart';
import 'package:hedlines/src/routes/app_routes.dart';

class TopicController extends GetxController {
  var isNavigate = false.obs;
  void handelNagivateToHome(Set<String> topics) {
    _handelUserTopic(topics);
    _handelSetUpContext();
    AppNavigator.pushNamedAndRemoveUntil(Routes.HOME);
  }

  void _handelUserTopic(Set<String> topics) {}
  void _handelSetUpContext() {}
}
