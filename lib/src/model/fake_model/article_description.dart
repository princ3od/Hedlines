class ArticleDescription {
  String articleUrl;
  String urlImage;
  DateTime publishedAt;
  String titleArticle;
  String textDescription;
  int estimateMinuteReadTime;
  int numberOfFavorite;
  int numberOfShare;
  List<String> tags;
  String sourceName;
  String topic;
  ArticleDescription({
    required this.articleUrl,
    required this.urlImage,
    required this.publishedAt,
    required this.titleArticle,
    required this.textDescription,
    required this.estimateMinuteReadTime,
    required this.numberOfFavorite,
    required this.numberOfShare,
    required this.tags,
    required this.sourceName,
    required this.topic,
  });
}
