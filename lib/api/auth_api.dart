import 'package:http/http.dart' as http;
// ignore: unused_import
import '../utils/api_constants.dart';

class AuthApi {
  static Future<http.Response> login(String email, String password) async {
    final uri = Uri.parse('${ApiConstants.baseUrl}/auth/login');
    return await http.post(uri, body: {'email': email, 'password': password});
  }

  static Future<http.Response> register(Map<String, dynamic> userData) async {
    final uri = Uri.parse('${ApiConstants.baseUrl}/auth/register');
    return await http.post(uri, body: userData);
  }

  static Future<http.Response> logout(String token) async {
    final uri = Uri.parse('${ApiConstants.baseUrl}/auth/logout');
    return await http.post(uri, headers: {'Authorization': 'Bearer $token'});
  }
}
