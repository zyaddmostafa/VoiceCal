import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static SharedPreferences? _prefs;

  static Future<bool> setData(String key, value) async {
    _prefs = await SharedPreferences.getInstance();

    switch (value.runtimeType) {
      case String _:
        return await _prefs?.setString(key, value as String) ?? false;
      case int _:
        return await _prefs?.setInt(key, value as int) ?? false;
      case bool _:
        return await _prefs?.setBool(key, value as bool) ?? false;
      default:
        return false;
    }
  }

  static Future<String?> getString(String key) async {
    log('SharedPref : Retrieving key: $key');
    _prefs = await SharedPreferences.getInstance();

    return _prefs?.getString(key);
  }

  static Future<int?> getInt(String key) async {
    log('SharedPref : Retrieving key: $key');
    _prefs = await SharedPreferences.getInstance();

    return _prefs?.getInt(key);
  }

  static Future<bool?> getBool(String key) async {
    log('SharedPref : Retrieving key: $key');
    _prefs = await SharedPreferences.getInstance();

    return _prefs?.getBool(key);
  }

  static Future<bool> removeData(String key) async {
    log('SharedPref : Removing key: $key');

    if (_prefs?.containsKey(key) != true) return false;

    return await _prefs?.remove(key) ?? false;
  }

  static Future<bool> clearAll() async {
    log('SharedPref : Clearing all SharedPreferences data');

    return await _prefs?.clear() ?? false;
  }
}
