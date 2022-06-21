import 'package:cloud_firestore/cloud_firestore.dart';

class DateTimeHelper {
  static Map<String, DateTime> convertTimeStampToDateTime(Map<String, dynamic> map) {
    Map<String, DateTime> result = {};
    map.forEach((key, value) {
      result[key] = value.toDate();
    });
    return result;
  }
}
