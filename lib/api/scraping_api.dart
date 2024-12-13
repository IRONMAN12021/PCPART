import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/api_constants.dart';

class ScrapingApi {
  static Future<http.Response> scrapeParts() async {
    final uri = Uri.parse('${ApiConstants.baseUrl}/scrape/parts');
    return await http.get(uri);
  }

  static Future<http.Response> scrapeFromWebsite(String website) async {
    final uri = Uri.parse('${ApiConstants.baseUrl}/scrape/$website');
    return await http.get(uri);
  }
}

class ScraperService {
  final String scraperFolderPath;

  ScraperService({required this.scraperFolderPath});

  Future<List<Map<String, dynamic>>> scrapeParts() async {
    final directory = Directory(scraperFolderPath);
    final List<Map<String, dynamic>> parts = [];

    if (await directory.exists()) {
      final files = directory.listSync(recursive: true);

      for (var file in files) {
        if (file is File && file.path.endsWith('.json')) {
          final content = await file.readAsString();
          final List<dynamic> jsonData = json.decode(content);
          parts.addAll(jsonData.map((data) => Map<String, dynamic>.from(data)));
        }
      }
    } else {
      throw Exception('Scraper folder does not exist');
    }

    return parts;
  }
}
