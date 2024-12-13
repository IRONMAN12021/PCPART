import 'package:http/http.dart' as http;
import 'dart:convert';

Future<double> getBottleneckPercentage(String cpu, String gpu) async {
  // Replace this URL with your actual API endpoint
  final String apiUrl = 'https://yourapiurl.com/api/v1/bottleneck';

  try {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'cpu': cpu,
        'gpu': gpu,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['bottleneckPercentage'];
    } else {
      throw Exception('Failed to fetch bottleneck percentage');
    }
  } catch (e) {
    print('Error: $e');
    return -1.0; // Return -1.0 to indicate an error
  }
}
