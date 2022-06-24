import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hedlines/src/data/hard_data/mock_data.dart';
import 'package:hedlines/src/model/topic.dart';
import 'package:hedlines/src/services/storage_service/topic_storage.dart';

import '../../../data/remote_data_source/article_fetcher.dart';
import '../../../data/remote_data_source/article_searcher_repository.dart';
import '../../../model/article.dart';
import '../../../ui/article_view/article_view_screen.dart';

class SearchTabController extends GetxController {
  Rxn<List<Article>> searchedArticles = Rxn<List<Article>>([]);
  Rxn<List<Topic>> topics = Rxn<List<Topic>>([]);
  RxList<bool> isCardEnabled = RxList<bool>([]);
  TextEditingController textEditingController = TextEditingController();
  var isLoading = false.obs;
  @override
  Future<void> onInit() async {
    super.onInit();
    isLoading.value = true;
    update();
    searchedArticles.value = MockData.articles.sublist(0, 4);
    topics.value = await TopicService().getTopics();
    isCardEnabled.value =
        List.generate(topics.value!.length, (index) => index == 0).toList();
    onTopicClick(0);
    isLoading.value = false;
    update();
  }

  void onSearchTextChange(String searchText) {
    isLoading.value = true;
    update();
    ArticleSearcherRepository().searchArticle(searchText).then((value) {
      searchedArticles.value = value;
      isLoading.value = false;
      update();
    });
  }

  void onTopicClick(int index) {
    textEditingController.text = "";
    Topic topic = topics.value![index];
    isLoading.value = true;
    update();
    ArticleFetcher().searchArticleByTopic(topic).then((value) {
      searchedArticles.value = value;
      isLoading.value = false;
      update();
    });
  }

  void onSearchForcus() {
    for (int i = 0; i < isCardEnabled.length; i++) {
      isCardEnabled[i] = false;
    }
    update();
  }

  Future<void> onOpenArticle(String id) async {
    Article? _article = await ArticleFetcher().fetchArticle(id);
    if (_article != null) {
      Get.to(
        () => ArticleViewScreen(
          article: _article,
        ),
        transition: Transition.rightToLeft,
      );
    }
  }
}
