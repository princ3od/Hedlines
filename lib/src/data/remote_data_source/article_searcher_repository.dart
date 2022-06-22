import 'package:hedlines/src/data/remote_data_source/status_code.dart';
import 'package:dio/dio.dart';

import '../../constants/api_gateway.dart';
import '../../model/article.dart';

class ArticleSearcherRepository {
  static final ArticleSearcherRepository _singleton =
      ArticleSearcherRepository._internal();
  factory ArticleSearcherRepository() {
    return _singleton;
  }
  ArticleSearcherRepository._internal();

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
