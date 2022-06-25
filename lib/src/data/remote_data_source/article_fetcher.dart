import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hedlines/src/data/remote_data_source/status_code.dart';

import '../../constants/api_gateway.dart';
import '../../model/article.dart';
import '../../model/topic.dart';

class ArticleFetcher {
  static final ArticleFetcher _singleton = ArticleFetcher._internal();
  factory ArticleFetcher() {
    return _singleton;
  }
  ArticleFetcher._internal();

  Future<List<Article>?> searchArticleByTopic(Topic topic) async {
    Response response;
    var dio = Dio();
    String path = ApiGateway.baseURL + ApiGateway.articlesFetcher;
    var body = {"topic_id": topic.id};
    response = await dio.post(path, data: body);
    if (response.statusCode == StatusCode.ok) {
      return (response.data["data"] as List)
          .map((e) => Article.fromMap(e))
          .toList();
    }
    return null;
  }

  Future<Article?> fetchArticle(String id) async {
    Response response;
    var dio = Dio();
    String path = ApiGateway.baseURL + ApiGateway.articlesFetcher;
    var body = {
      "article_id": id,
      "user_id": FirebaseAuth.instance.currentUser!.uid
    };
    response = await dio.post(path, data: body);
    if (response.statusCode == StatusCode.ok) {
      return Article.fromMap(response.data);
    }
    return null;
  }
}
