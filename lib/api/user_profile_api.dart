import 'package:http/http.dart' as http;
import '../utils/api_constants.dart';

class UserProfileApi {
  static Future<http.Response> fetchProfile(String userId, String token) async {
    final uri = Uri.parse('${ApiConstants.baseUrl}/profile/$userId');
    return await http.get(uri, headers: {'Authorization': 'Bearer $token'});
  }

  static Future<http.Response> updateProfile(
      String userId, Map<String, dynamic> profileData, String token) async {
    final uri = Uri.parse('${ApiConstants.baseUrl}/profile/$userId');
    return await http.put(uri,
        headers: {'Authorization': 'Bearer $token'}, body: profileData);
  }
}
