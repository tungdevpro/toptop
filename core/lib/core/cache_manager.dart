import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CacheManager {
  static final CacheManager _inst = CacheManager._internal();

  CacheManager._internal();

  factory CacheManager({String? box}) {
    return _inst;
  }

  static const String boxName = 'local.data';

  static Box box = Hive.box(boxName);

  static Future<void> ensureInitialized() async {
    await Hive.initFlutter();
    await Hive.openBox(boxName);
    debugPrint('[hive]: initial $boxName');
  }

  static Future<void> put(String key, dynamic value) async {
    switch (value) {
      case String:
      case double:
      case bool:
      case int:
        await box.put(key, value);
        break;
      default:
        await box.put(key, jsonEncode(value));
        break;
    }
  }

  static dynamic get<T>(String key, [dynamic defaultValue]) {
    if (!isExist(key)) return defaultValue;
    String? value = box.get(key, defaultValue: defaultValue);

    switch (T) {
      case String:
        return value;
      case double:
        return double.tryParse(value ?? '');
      case bool:
        return bool.fromEnvironment(value ?? '');
      case int:
        return int.tryParse(value ?? '');
      default:
        return jsonDecode(box.get(key));
    }
  }

  static bool isExist(String key) => box.containsKey(key);

  static Future<void> delete(String key) async {
    if (!isExist(key)) return;
    await box.delete(key);
  }

  static Future<void> clearData() async {
    final Box box = Hive.box(boxName);
    await box.deleteFromDisk();
  }
}
