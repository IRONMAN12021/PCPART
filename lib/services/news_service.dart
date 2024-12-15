import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:myapp/utils/api_constants.dart';

class NewsService {
  final String baseUrl = 'https://newsapi.org/v2';
  final String apiKey = ApiConstants.newsApiKey;

  Future<List<Map<String, dynamic>>> getTechNews() async {
    try {
      final response = await http.get(
        Uri.parse(
          '$baseUrl/everything?'
          'q=pc+hardware+OR+gaming+hardware+OR+tech+components&'
          'language=en&'
          'sortBy=publishedAt&'
          'pageSize=20&'
          'apiKey=$apiKey'
        ),
      ).timeout(
        const Duration(seconds: 10),
        onTimeout: () => throw TimeoutException('Request timed out'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return List<Map<String, dynamic>>.from(data['articles']);
      } else {
        throw Exception('Failed to load news: ${response.statusCode}');
      }
    } on TimeoutException {
      throw Exception('Connection timed out. Please check your internet connection.');
    } catch (e) {
      print('Error fetching news: $e');
      throw Exception('Failed to load news: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getComponentNews(String component) async {
    try {
      final response = await http.get(
        Uri.parse(
          '$baseUrl/everything?'
          'q=$component+hardware+review+OR+$component+benchmark&'
          'language=en&'
          'sortBy=publishedAt&'
          'pageSize=10&'
          'apiKey=$apiKey'
        ),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return List<Map<String, dynamic>>.from(data['articles']);
      } else {
        throw Exception('Failed to load component news');
      }
    } catch (e) {
      print('Error fetching component news: $e');
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> searchNews(String query) async {
    try {
      final response = await http.get(
        Uri.parse(
          '$baseUrl/everything?'
          'q=$query+AND+(pc+OR+hardware+OR+tech)&'
          'language=en&'
          'sortBy=relevancy&'
          'pageSize=20&'
          'apiKey=$apiKey'
        ),
      ).timeout(
        const Duration(seconds: 10),
        onTimeout: () => throw TimeoutException('Request timed out'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return List<Map<String, dynamic>>.from(data['articles']);
      } else {
        throw Exception('Failed to search news: ${response.statusCode}');
      }
    } catch (e) {
      print('Error searching news: $e');
      throw Exception('Failed to search news: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getNewsByCategory(String category) async {
    if (category == 'All') {
      return getTechNews();
    }

    try {
      final response = await http.get(
        Uri.parse(
          '$baseUrl/everything?'
          'q=$category+AND+pc+hardware&'
          'language=en&'
          'sortBy=publishedAt&'
          'pageSize=20&'
          'apiKey=$apiKey'
        ),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return List<Map<String, dynamic>>.from(data['articles']);
      } else {
        throw Exception('Failed to load category news');
      }
    } catch (e) {
      print('Error fetching category news: $e');
      throw Exception('Failed to load category news: $e');
    }
  }
} 