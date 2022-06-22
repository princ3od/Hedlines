import 'package:get/get.dart';
import 'package:hedlines/src/controller/app_controller.dart';
import 'package:hedlines/src/services/auth_service/firebase_authentication.dart';
import 'package:hedlines/src/services/storage_service/topic_storage.dart';
import 'package:hedlines/src/services/storage_service/user_storage.dart';

import '../../../model/topic.dart';

class ProfileController extends GetxController {
  var selectedTopics = <String>[];
  var topics = <Topic>[].obs;
  var showSaveButton = false.obs;
  var isSaving = false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    selectedTopics = AppController.userInfo.value?.preferences ?? [];
    topics.value = await TopicService().getTopics();
  }

  selectTopic(String topicId) {
    if (selectedTopics.contains(topicId)) {
      selectedTopics.remove(topicId);
    } else {
      selectedTopics.add(topicId);
    }
    showSaveButton.value = selectedTopics.length > 1;
  }

  savePreferences() async {
    isSaving.value = true;
    await UserInfoService().setUserTopics(selectedTopics);
    AppController.userInfo.value?.preferences = selectedTopics;
    isSaving.value = false;
  }

  Future<void> signOut() async {
    await AuthService().signOut();
  }
}
