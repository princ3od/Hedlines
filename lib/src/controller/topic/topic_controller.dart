import 'package:get/get.dart';
import 'package:hedlines/src/routes/app_pages.dart';
import 'package:hedlines/src/routes/app_routes.dart';
import 'package:hedlines/src/services/storage_service/topic_storage.dart';

import '../../model/topic.dart';
import '../../services/storage_service/user_storage.dart';

class TopicController extends GetxController {
  var isNavigating = false.obs;
  var isLoading = false.obs;
  var isError = false.obs;
  var topics = <Topic>[].obs;
  var selectedTopics = <String>[].obs;
  var showNextButton = false.obs;
  @override
  Future<void> onInit() async {
    isLoading.value = true;
    topics.value = await TopicService().getTopics();
    isLoading.value = false;
    super.onInit();
  }

  selectTopic(Topic topic) {
    if (selectedTopics.contains(topic.id)) {
      selectedTopics.remove(topic.id);
    } else {
      selectedTopics.add(topic.id);
    }
    isError.value = selectedTopics.length < 2;
    showNextButton.value = !isError.value && !isLoading.value;
  }

  Future<void> handelNagivateToHome() async {
    isNavigating.value = true;
    await _handelUserTopic();
    isNavigating.value = false;
    AppNavigator.pushNamedAndRemoveUntil(Routes.home);
  }

  Future<void> _handelUserTopic() async {
    await UserInfoService().setUserTopics(selectedTopics);
  }
}
