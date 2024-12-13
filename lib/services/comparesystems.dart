import 'bottleneckpercentage.dart';

Future<Map<String, dynamic>> compareSystems(String cpu, String gpu) async {
  // Mocked data for simplicity. Replace this with real API calls.
  await Future.delayed(const Duration(seconds: 1));

  // Example: return mock data for system performance comparison.
  Map<String, dynamic> comparison = {
    'cpuPerformance': 'Excellent', // Example performance metric
    'gpuPerformance': 'High', // Example performance metric
    'performanceDifference': '15%', // Example performance difference
    'bottleneckPercentage': await getBottleneckPercentage(cpu, gpu), // Get the bottleneck
  };

  return comparison;
}

Future<List<Map<String, dynamic>>> getHottestConfigs() async {
  // Mocked data for simplicity. Replace this with real API calls.
  await Future.delayed(const Duration(seconds: 1));
  return [
    {'id': '1', 'name': 'Hot Config 1', 'performance': 'High'},
    {'id': '2', 'name': 'Hot Config 2', 'performance': 'Medium'},
  ];
}

Future<List<Map<String, dynamic>>> getMostSelectedConfigs() async {
  // Mocked data for simplicity. Replace this with real API calls.
  await Future.delayed(const Duration(seconds: 1));
  return [
    {'id': '3', 'name': 'Selected Config 1', 'performance': 'High'},
    {'id': '4', 'name': 'Selected Config 2', 'performance': 'Medium'},
  ];
}

Future<List<Map<String, dynamic>>> getMostSuggestedConfigs() async {
  // Mocked data for simplicity. Replace this with real API calls.
  await Future.delayed(const Duration(seconds: 1));
  return [
    {'id': '5', 'name': 'Suggested Config 1', 'performance': 'High'},
    {'id': '6', 'name': 'Suggested Config 2', 'performance': 'Medium'},
  ];
}
