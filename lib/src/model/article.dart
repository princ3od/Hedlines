class Article {
  String url;
  String thumbnail;
  DateTime date;
  String title;
  String description;
  int estimateMinuteReadTime;
  int numberOfFavorite;
  int numberOfShare;
  List<String> tags;
  Map<String, dynamic> source;
  Map<String, dynamic> topic;
  String author;
  String id;

  Article({
    required this.id,
    required this.author,
    required this.url,
    required this.thumbnail,
    required this.date,
    required this.title,
    required this.description,
    required this.estimateMinuteReadTime,
    required this.numberOfFavorite,
    required this.numberOfShare,
    required this.tags,
    required this.source,
    required this.topic,
  });

  factory Article.fromMap(Map<String, dynamic> map) => Article(
        url: map["url"] ?? "",
        thumbnail: map["thumbnail"] ?? [],
        date: DateTime.fromMillisecondsSinceEpoch(map["date"]),
        title: map["title"] ?? "",
        description: map["description"] ?? "",
        estimateMinuteReadTime: map["estimateMinuteReadTime"] ?? 0,
        numberOfFavorite: map["numberOfFavorite"] ?? 0,
        numberOfShare: map["numberOfShare"] ?? 0,
        tags: map["tags"] != null
            ? List<String>.from(map["tags"].map((x) => x))
            : [],
        source: Map<String, dynamic>.from(map["source"]),
        topic: Map<String, dynamic>.from(map["topic"]),
        author: '',
        id: '',
      );
}
