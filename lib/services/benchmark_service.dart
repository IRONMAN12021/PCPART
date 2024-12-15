import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:myapp/utils/api_constants.dart';

class BenchmarkService {
  final String baseUrl;
  final Map<String, String> benchmarkSources = {
    'passmark': 'CPU/GPU benchmarks',
    'cinebench': 'CPU rendering',
    '3dmark': 'Gaming performance',
    'pcmark': 'System performance',
  };

  BenchmarkService({this.baseUrl = ApiConstants.benchmarkBaseUrl});

  Future<Map<String, dynamic>> getComponentBenchmarks(String partId, String type) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/benchmarks/$type/$partId'),
        headers: {'Authorization': 'Bearer ${ApiConstants.benchmarkApiKey}'},
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to fetch benchmarks');
      }
    } catch (e) {
      throw Exception('Error fetching benchmarks: $e');
    }
  }

  Future<Map<String, dynamic>> getPerformanceScore(String partId) async {
    final scores = <String, dynamic>{};
    
    for (var source in benchmarkSources.keys) {
      try {
        final response = await http.get(
          Uri.parse('$baseUrl/scores/$source/$partId'),
          headers: {'Authorization': 'Bearer ${ApiConstants.benchmarkApiKey}'},
        );

        if (response.statusCode == 200) {
          scores[source] = json.decode(response.body)['score'];
        }
      } catch (e) {
        print('Error fetching score from $source: $e');
      }
    }

    return scores;
  }
} 