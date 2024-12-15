import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as html;

class ScraperService {
  final String baseUrl;

  ScraperService({required this.baseUrl});

  Future<List<Map<String, dynamic>>> scrapeParts() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final document = html.parse(response.body);
      final parts = <Map<String, dynamic>>[];

      // Example: Scrape part details from the HTML
      final partElements = document.querySelectorAll('.part-item');
      for (var element in partElements) {
        final name = element.querySelector('.part-name')?.text ?? 'Unknown';
        final type = element.querySelector('.part-type')?.text ?? 'Unknown';
        final releaseYear = element.querySelector('.part-release-year')?.text ?? 'Unknown';
        final generation = element.querySelector('.part-generation')?.text ?? 'Unknown';
        final specifications = element.querySelector('.part-specifications')?.text ?? 'Unknown';
        final price = element.querySelector('.part-price')?.text ?? 'Unknown';

        parts.add({
          'name': name,
          'type': type,
          'releaseYear': releaseYear,
          'generation': generation,
          'specifications': specifications,
          'price': price,
        });
      }

      return parts;
    } else {
      throw Exception('Failed to load parts');
    }
  }
}