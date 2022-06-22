import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hedlines/src/model/topic.dart';

class TopicService {
  DocumentReference topicsRef =
      FirebaseFirestore.instance.collection('topics').doc("content");

  List<Topic>? _topics;

  Future<List<Topic>> getTopics() async {
    if (_topics != null) {
      return _topics!;
    }
    _topics = [];
    var doc = await topicsRef.get();
    var data = doc.data() as Map<String, dynamic>;
    for (var topic in data.keys) {
      Topic topicModel = Topic(id: topic, name: data[topic]["vnese"]);
      _topics!.add(topicModel);
    }
    return _topics!;
  }

  static final TopicService _authService = TopicService._internal();

  TopicService._internal();
  factory TopicService() {
    return _authService;
  }
}
