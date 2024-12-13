import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:myapp/models/build_config.dart';

class GeminiService {
  final String baseUrl;
  final String apiKey;

  GeminiService({required this.baseUrl, required this.apiKey});

  Future<BuildConfig> fetchBuildConfig(String id) async {
    final response = await http.get(
      Uri.parse('$baseUrl/build_configs/$id'),
      headers: {
        'Authorization': 'Bearer $apiKey',
      },
    );

    if (response.statusCode == 200) {
      return BuildConfig.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load build config');
    }
  }

  Future<void> createBuildConfig(BuildConfig buildConfig) async {
    final response = await http.post(
      Uri.parse('$baseUrl/build_configs'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode(buildConfig.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create build config');
    }
  }
}