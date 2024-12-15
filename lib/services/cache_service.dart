import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CacheService {
  static const String _priceHistoryKey = 'price_history_';
  static const String _benchmarkKey = 'benchmark_';
  static const Duration _cacheDuration = Duration(hours: 24);

  final SharedPreferences _prefs;

  CacheService(this._prefs);

  Future<void> cachePriceHistory(String partId, Map<String, dynamic> data) async {
    final cacheData = {
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'data': data,
    };
    await _prefs.setString(_priceHistoryKey + partId, json.encode(cacheData));
  }

  Future<Map<String, dynamic>?> getCachedPriceHistory(String partId) async {
    final cachedData = _prefs.getString(_priceHistoryKey + partId);
    if (cachedData != null) {
      final data = json.decode(cachedData);
      final timestamp = DateTime.fromMillisecondsSinceEpoch(data['timestamp']);
      if (DateTime.now().difference(timestamp) < _cacheDuration) {
        return data['data'];
      }
    }
    return null;
  }

  Future<void> cacheBenchmark(String partId, Map<String, dynamic> data) async {
    final cacheData = {
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'data': data,
    };
    await _prefs.setString(_benchmarkKey + partId, json.encode(cacheData));
  }

  Future<Map<String, dynamic>?> getCachedBenchmark(String partId) async {
    final cachedData = _prefs.getString(_benchmarkKey + partId);
    if (cachedData != null) {
      final data = json.decode(cachedData);
      final timestamp = DateTime.fromMillisecondsSinceEpoch(data['timestamp']);
      if (DateTime.now().difference(timestamp) < _cacheDuration) {
        return data['data'];
      }
    }
    return null;
  }
} 