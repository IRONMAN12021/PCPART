import 'package:http/http.dart' as http;
import 'dart:convert';

class TechSpot {
  static Future<List<Map<String, dynamic>>> scrape() async {
    const String url = 'https://www.techspot.com/reviews/benchmarks';
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
        throw Exception('Failed to fetch benchmarks from TechSpot');
      }
    } catch (e) {
      print('Error scraping TechSpot: $e');
      return [];
    }
  }
}
