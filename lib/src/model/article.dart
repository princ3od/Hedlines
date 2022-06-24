import 'package:cloud_firestore/cloud_firestore.dart';

class Article {
  String url;
  String thumbnail;
  DateTime date;
  String title;
  String description;
  int estimateMinuteReadTime;
  int numberOfFavorite;
  int numberOfShare;
  List<dynamic> tags;
  Map<String, dynamic> source;
  Map<String, dynamic> topic;
  String author;
  String id;
  bool isLiked;

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
    this.isLiked = true,
  });

  factory Article.fromMap(Map<String, dynamic> map) {
    return Article(
      id: map['id'] as String,
      url: map["url"] ?? "",
      thumbnail: map["thumbnail"] ?? '',
      date: DateTime.fromMillisecondsSinceEpoch(map["date"]),
      title: map["title"] ?? "",
      description: map["description"] ?? "",
      estimateMinuteReadTime: map["readtime"] ?? 0,
      numberOfFavorite: map["like_count"] ?? 0,
      numberOfShare: map["share_count"] ?? 0,
      tags: map["tags"] != null ? List.from((map["tags"]).map((x) => x)) : [],
      source: Map<String, dynamic>.from(map["source"]),
      topic: Map<String, dynamic>.from(map["topic"]),
      author: map["author"] ?? "",
      isLiked: map["is_liked"] ?? false,
    );
  }

  factory Article.fromMapFireStore(Map<String, dynamic> map) {
    return Article(
      id: map['id'] as String,
      url: map["url"] ?? "",
      thumbnail: map["thumbnail"] ?? '',
      date: (map["date"] as Timestamp).toDate(),
      title: map["title"] ?? "",
      description: map["description"] ?? "",
      estimateMinuteReadTime: map["readtime"] ?? 0,
      numberOfFavorite: map["like_count"] ?? 0,
      numberOfShare: map["share_count"] ?? 0,
      tags: [],
      source: {},
      topic: {},
      author: map["author"] ?? "",
      isLiked: map["is_liked"] ?? false,
    );
  }
}
