import 'package:hedlines/src/constants/storage_key.dart';
import 'package:hedlines/src/helper/utils/path_helper.dart';
import 'package:hive/hive.dart';

class BaseLocalData {
  static Future<void> initialBox() async {
    var path = await PathHelper.appDir;
    Hive..init(path.path);
    await Hive.openBox(StorageKey.BOX_USER);
  }
}
