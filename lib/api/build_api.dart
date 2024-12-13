import 'package:http/http.dart' as http;
import '../utils/api_constants.dart';

class BuildApi {
  static Future<http.Response> autoBuild(
      Map<String, dynamic> preferences) async {
    final uri = Uri.parse('${ApiConstants.baseUrl}/build/auto');
    return await http.post(uri, body: preferences);
  }

  static Future<http.Response> manualBuild(
      Map<String, dynamic> selectedParts) async {
    final uri = Uri.parse('${ApiConstants.baseUrl}/build/manual');
    return await http.post(uri, body: selectedParts);
  }
}
