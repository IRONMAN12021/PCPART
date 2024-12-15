import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class LocalStorage {
  final SharedPreferences _prefs;

  LocalStorage(this._prefs);

  Future<void> saveList(String key, List<dynamic> data) async {
    await _prefs.setString(key, json.encode(data));
  }

  Future<List<dynamic>?> getList(String key) async {
    final data = _prefs.getString(key);
    if (data != null) {
      return json.decode(data) as List<dynamic>;
    }
    return null;
  }

  Future<void> saveMap(String key, Map<String, dynamic> data) async {
    await _prefs.setString(key, json.encode(data));
  }

  Future<Map<String, dynamic>?> getMap(String key) async {
    final data = _prefs.getString(key);
    if (data != null) {
      return json.decode(data) as Map<String, dynamic>;
    }
    return null;
  }

  Future<void> remove(String key) async {
    await _prefs.remove(key);
  }

  Future<void> clear() async {
    await _prefs.clear();
  }
}
