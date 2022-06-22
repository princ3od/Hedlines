class Article {
  String url;
  String thumbnail;
  DateTime publishedAt;
  String title;
  String description;
  int estimateMinuteReadTime;
  int numberOfFavorite;
  int numberOfShare;
  List<String> tags;
  Map<String, dynamic> source;
  Map<String, dynamic> topic;

  Article({
    required this.url,
    required this.thumbnail,
    required this.publishedAt,
    required this.title,
    required this.description,
    required this.estimateMinuteReadTime,
    required this.numberOfFavorite,
    required this.numberOfShare,
    required this.tags,
    required this.source,
    required this.topic,
  });
}
