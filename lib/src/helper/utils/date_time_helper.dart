class DateTimeHelper {
  static Map<String, DateTime> convertTimeStampToDateTime(
      Map<String, dynamic> map) {
    Map<String, DateTime> result = {};
    map.forEach((key, value) {
      result[key] = value.toDate();
    });
    return result;
  }

  static dynamic myDateSerializer(dynamic object) {
    if (object is DateTime) {
      return object.toIso8601String();
    }
    return object;
  }

  static dynamic myDateDeserializer(dynamic object) {
    if (object is String && isIsoDate(object)) {
      return DateTime.parse(object);
    }
    return object;
  }

  static bool isIsoDate(str) {
    RegExp exp = RegExp('/d{4}-d{2}-d{2}Td{2}:d{2}:d{2}.d{3}Z/');
    if (!exp.hasMatch(str)) return false;
    var d = DateTime.parse(str);
    return d.toIso8601String() == str;
  }
}
