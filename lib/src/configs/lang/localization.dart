import 'package:hedlines/src/configs/lang/en_US.dart';
import 'package:hedlines/src/configs/lang/vi_VN.dart';
import 'package:i18n_extension/i18n_extension.dart';

class Strings {
  // Language
  static const String vietnamese = 'vietnamese';
  static const String english = 'english';

  // Home
  static const String home = 'home';
  static const String search = 'search';
  static const String profile = 'profile';
}

class MyI18n {
  static List<String> keys = vietnamese.keys.toList();

  static Map<String, Map<String, String>> getTranslation() {
    Map<String, Map<String, String>> value = {};
    for (var element in keys) {
      value[element] = {
        'vi_vn': vietnamese[element]!,
        'en_us': english[element]!,
      };
    }

    return value;
  }
}

extension Localization on String {
  static final _t = Translations.from('vi_vn', MyI18n.getTranslation());

  String get i18n => localize(this, _t);

  String fill(List<Object> params) => localizeFill(this, params);

  String plural(int value) => localizePlural(value, this, _t);

  String version(Object modifier) => localizeVersion(modifier, this, _t);
}
