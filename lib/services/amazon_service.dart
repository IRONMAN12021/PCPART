import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:myapp/services/scraper_service.dart';

class AmazonService {
  final String baseUrl = 'https://api.example.com/amazon';
  final ScraperService scraperService;

  AmazonService({required this.scraperService});

  Future<List<Map<String, dynamic>>> fetchParts() async {
    try {
      // Fetch parts from the API
      final response = await http.get(Uri.parse('$baseUrl/parts'));

      if (response.statusCode == 200) {
        return List<Map<String, dynamic>>.from(json.decode(response.body));
      } else {
        throw Exception('Failed to load parts from API');
      }
    } catch (e) {
      // If API call fails, fall back to scraping data from local files
      print('API call failed, falling back to local scraper: $e');
      return await scraperService.scrapeParts();
    }
  }
}