// File: scraper_tomshardware.dart
import 'package:http/http.dart' as http;
import 'dart:convert';

class TomsHardware {
  static Future<List<Map<String, dynamic>>> scrape() async {
    const String url = 'https://www.tomshardware.com/reviews';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((item) => {
          'component': item['component'],
          'rating': item['rating'],
          'comments': item['comments'],
        }).toList();
      } else {
        throw Exception('Failed to fetch benchmarks from TomsHardware');
      }
    } catch (e) {
      print('Error scraping TomsHardware: $e');
      return [];
    }
  }
}