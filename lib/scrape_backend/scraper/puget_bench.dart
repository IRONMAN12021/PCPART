import 'package:http/http.dart' as http;
import 'dart:convert';

class PugetBench {
  static Future<List<Map<String, dynamic>>> scrape() async {
    const String url = 'https://www.pugetsystems.com/benchmarks';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((item) => {
          'component': item['component'],
          'score': item['score'],
          'details': item['details'],
        }).toList();
      } else {
        throw Exception('Failed to fetch benchmarks from PugetBench');
      }
    } catch (e) {
      print('Error scraping PugetBench: $e');
      return [];
    }
  }
} 