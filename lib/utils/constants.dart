class Constants {
  // App-wide constants
  static const String appName = 'PC Configurator';
  static const int timeoutDuration = 30; // in seconds

  // Mandatory Part Categories
  static const List<String> mandatoryPartCategories = [
    'CPU',
    'Motherboard',
    'RAM',
    'GPU',
    'Storage',
    'PSU',
    'Case',
    'Cooler',
  ];

  // Optional Part Categories
  static const List<String> optionalPartCategories = [
    'Monitor',
    'Keyboard',
    'Mouse',
    'Headphones',
    'Speakers',
  ];

  // External websites for scraping
  static const List<String> scrapingWebsites = [
    'https://pcpartpicker.com',
    'https://lttstore.com',
    'https://zttlabs.com',
    'https://benchmarks.ul.com',
    'https://passmark.com'
  ];

  // Check if a part is mandatory
  static bool isMandatoryPart(String partCategory) {
    return mandatoryPartCategories.contains(partCategory);
  }

  // Check if a part is optional
  static bool isOptionalPart(String partCategory) {
    return optionalPartCategories.contains(partCategory);
  }
}
