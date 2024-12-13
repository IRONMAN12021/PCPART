// File: scraper_zttlabs.dart
import 'package:http/http.dart' as http;
import 'dart:convert';

class ZTTLabsScraper {
  static Future<List<Map<String, dynamic>>> scrape() async {
    const String url = 'https://zttlabs.com/reviews';
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
        throw Exception('Failed to fetch reviews from ZTT Labs');
      }
    } catch (e) {
      print('Error scraping ZTT Labs: $e');
      return [];
    }
  }
}