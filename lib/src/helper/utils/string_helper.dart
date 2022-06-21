class StringHeler {
  static Map<String, String> convertMapStringToString(Map<String, dynamic> map) {
    Map<String, String> result = {};
    map.forEach((key, value) {
      result[key] = value.toString();
    });
    return result;
  }
}
