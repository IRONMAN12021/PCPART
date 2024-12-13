import 'package:http/http.dart' as http;

class ApiClient {
  static Map<String, String> defaultHeaders(String token) {
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  static Future<http.Response> get(String url, {String? token}) async {
    return await http.get(Uri.parse(url), headers: defaultHeaders(token ?? ''));
  }

  static Future<http.Response> post(String url,
      {Map<String, dynamic>? body, String? token}) async {
    return await http.post(Uri.parse(url),
        headers: defaultHeaders(token ?? ''), body: body);
  }
}
