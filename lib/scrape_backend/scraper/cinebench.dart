// File: scraper_cinebench.dart
import 'package:http/http.dart' as http;
import 'dart:convert';

class Cinebench {
  static Future<List<Map<String, dynamic>>> scrape() async {
    const String url = 'https://www.maxon.net/en/cinebench';
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
        throw Exception('Failed to fetch benchmarks from Cinebench');
      }
    } catch (e) {
      print('Error scraping Cinebench: $e');
      return [];
    }
  }
}