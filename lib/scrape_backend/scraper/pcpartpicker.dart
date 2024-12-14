import 'package:http/http.dart' as http;
import 'dart:convert';

class PCPartPicker {
  static const String baseUrl = 'https://pcpartpicker.com/api/v1';

  static Future<Map<String, dynamic>> scrape() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/products'));
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return {
          'status': 'success',
          'data': data,
        };
      } else {
        throw Exception('Failed to fetch data from PCPartPicker');
      }
    } catch (e) {
      print('Error scraping PCPartPicker: $e');
      return {
        'status': 'error',
        'message': e.toString()
      };
    }
  }
}
