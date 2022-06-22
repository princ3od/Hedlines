import 'package:get/get.dart';
import 'package:hedlines/src/data/hard_data/mock_data.dart';
import 'package:hedlines/src/model/fake_model/article_description.dart';

class SearchTabController extends GetxController {
  RxList<Article> searchedArticles = RxList<Article>();
  @override
  void onInit() {
    super.onInit();
    searchedArticles.value = MockData.articles.sublist(0, 4);
    update();
  }
}
