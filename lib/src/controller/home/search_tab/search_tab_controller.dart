import 'package:get/get.dart';
import 'package:hedlines/src/data/hard_data/mock_data.dart';
import 'package:hedlines/src/model/topic.dart';
import 'package:hedlines/src/services/storage_service/topic_storage.dart';

import '../../../data/remote_data_source/article_searcher_repository.dart';
import '../../../model/article.dart';

class SearchTabController extends GetxController {
  Rxn<List<Article>> searchedArticles = Rxn<List<Article>>(null);
  var topics = <Topic>[];
  @override
  Future<void> onInit() async {
    super.onInit();
    searchedArticles.value = MockData.articles.sublist(0, 4);
    topics = await TopicService().getTopics();
    update();
  }

  void onSearchTextChange(String searchText) {
    ArticleSearcherRepository().searchArticle(searchText).then((value) {
      searchedArticles.value = value;
      update();
    });
  }
}
