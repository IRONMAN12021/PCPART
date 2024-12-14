class ScraperService {
  final String scraperFolderPath;

  ScraperService({required this.scraperFolderPath});

  Future<List<Map<String, dynamic>>> scrapeParts() async {
    // TODO: Implement actual scraping logic
    return [
      {
        'name': 'Sample Part',
        'price': 99.99,
        'type': 'CPU',
      }
    ];
  }
}