import 'package:hive_flutter/hive_flutter.dart';

import '../../features/onboarding/data/models/user_informations_model.dart';
import 'hive_constants.dart';

class HiveService {
  static final Map<String, Box> _openedBoxes = {};

  static Future<void> hiveInit() async {
    await Hive.initFlutter();
    await initHiveAdapter();
    await initBoxes(hiveBoxesNames);
  }

  static List<String> get hiveBoxesNames => [HiveConstants.userInfoBox];

  static Future<void> initHiveAdapter() async {
    Hive.registerAdapter(UserInformationsModelAdapter());
    Hive.registerAdapter(BornDateAdapter());
  }

  static Future<void> initBoxes(List<String> boxNames) async {
    for (final boxName in boxNames) {
      if (!_openedBoxes.containsKey(boxName)) {
        final box = await Hive.openBox(boxName);
        _openedBoxes[boxName] = box;
      }
    }
  }

  static Future<Box> _getBox(String boxName) async {
    if (_openedBoxes.containsKey(boxName)) {
      return _openedBoxes[boxName]!;
    }

    final box = await Hive.openBox(boxName);
    _openedBoxes[boxName] = box;

    return box;
  }

  static Future<void> createBox(String boxName) async {
    if (!_openedBoxes.containsKey(boxName)) {
      final box = await Hive.openBox(boxName);
      _openedBoxes[boxName] = box;
    }
  }

  static Future<void> addData(String boxName, String key, value) async {
    final box = await _getBox(boxName);
    await box.put(key, value);
  }

  static Future<dynamic> getData(String boxName, String key) async {
    final box = await _getBox(boxName);

    return box.get(key);
  }

  static Future<void> deleteData(String boxName, String key) async {
    final box = await _getBox(boxName);
    await box.delete(key);
  }
}
