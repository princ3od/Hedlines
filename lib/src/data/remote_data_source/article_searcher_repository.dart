import 'package:hedlines/src/data/remote_data_source/status_code.dart';
import 'package:hedlines/src/model/fake_model/article_description.dart';
import 'package:dio/dio.dart';

import '../../constants/api_gateway.dart';

class ArticleSearcherRepository {
  static final ArticleSearcherRepository _singleton = ArticleSearcherRepository._internal();
  factory ArticleSearcherRepository() {
    return _singleton;
  }
  ArticleSearcherRepository._internal();

  Future<List<Article>?> searchArticle(String keyword) async {
    Response response;
    var dio = Dio();
    String path = ApiGateway.BASE_URL + ApiGateway.ARTICLES_SEARCHER;
    var body = {"query": keyword};
    response = await dio.post(path, data: body);
    if (response.statusCode == StatusCode.ok) {
      return (response.data["data"] as List).map((e) => Article.fromMap(e)).toList();
    }
    return null;
  }
}
