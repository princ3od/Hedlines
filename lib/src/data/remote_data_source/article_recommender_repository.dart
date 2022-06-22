import 'package:hedlines/src/data/remote_data_source/status_code.dart';
import 'package:hedlines/src/model/fake_model/article_description.dart';
import 'package:dio/dio.dart';

import '../../constants/api_gateway.dart';

class ArticleRecommenderRepository {
  static final ArticleRecommenderRepository _singleton =
      ArticleRecommenderRepository._internal();
  factory ArticleRecommenderRepository() {
    return _singleton;
  }
  ArticleRecommenderRepository._internal();

  Future<List<Article>?> searchArticle(String keyword) async {
    Response response;
    var dio = Dio();
    String path = ApiGateway.baseURL + ApiGateway.articlesSearcher;
    var body = {"query": keyword};
    response = await dio.post(path, data: body);
    if (response.statusCode == StatusCode.ok) {
      return (response.data["data"] as List)
          .map((e) => Article.fromMap(e))
          .toList();
    }
    return null;
  }
}
