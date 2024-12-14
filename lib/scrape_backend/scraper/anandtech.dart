// File: scraper_anandtech.dart
// ignore_for_file: avoid_print

import 'package:http/http.dart' as http;
import 'dart:convert';

class AnandTech {
  static Future<List<Map<String, dynamic>>> scrape() async {
    const String url = 'https://www.anandtech.com/bench';
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
        throw Exception('Failed to fetch benchmarks from AnandTech');
      }
    } catch (e) {
      print('Error scraping AnandTech: $e');
      return [];
    }
  }
}
