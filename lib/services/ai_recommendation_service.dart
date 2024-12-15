import 'package:myapp/models/pc_part.dart';
import 'package:myapp/services/price_tracker_service.dart';
import 'package:myapp/services/benchmark_service.dart';
import 'package:myapp/utils/api_constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AIRecommendationService {
  final String baseUrl;
  final PriceTrackerService _priceTracker;
  final BenchmarkService _benchmarkService;

  AIRecommendationService({
    this.baseUrl = ApiConstants.aiRecommendationBaseUrl,
    PriceTrackerService? priceTracker,
    BenchmarkService? benchmarkService,
  }) : 
    _priceTracker = priceTracker ?? PriceTrackerService(),
    _benchmarkService = benchmarkService ?? BenchmarkService();

  Future<List<PCPart>> getRecommendedParts(Map<String, dynamic> requirements) async {
    try {
      // Get initial AI recommendations
      final response = await http.post(
        Uri.parse('$baseUrl/recommend'),
        headers: {
          'Authorization': 'Bearer ${ApiConstants.aiApiKey}',
          'Content-Type': 'application/json',
        },
        body: json.encode(requirements),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to get AI recommendations');
      }

      final recommendations = json.decode(response.body);
      final enrichedParts = <PCPart>[];

      // Enrich each recommendation with price and benchmark data
      for (var rec in recommendations['parts']) {
        final partId = rec['id'];
        
        // Get current prices
        final prices = await _priceTracker.getCurrentPrices(partId);
        final bestPrice = await _priceTracker.getBestPrice(partId);
        
        // Get performance benchmarks
        final benchmarks = await _benchmarkService.getComponentBenchmarks(
          partId,
          rec['type'],
        );
        
        // Create enriched part object
        final part = PCPart(
          id: partId,
          name: rec['name'],
          type: rec['type'],
          price: bestPrice,
          specifications: {
            ...rec['specifications'],
            'prices': prices,
            'benchmarks': benchmarks,
          },
        );
        
        enrichedParts.add(part);
      }

      return enrichedParts;
    } catch (e) {
      throw Exception('Error getting recommendations: $e');
    }
  }

  Future<Map<String, dynamic>> analyzeBuildCompatibility(List<PCPart> parts) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/analyze-compatibility'),
        headers: {
          'Authorization': 'Bearer ${ApiConstants.aiApiKey}',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'parts': parts.map((p) => p.toJson()).toList(),
        }),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to analyze compatibility');
      }
    } catch (e) {
      throw Exception('Error analyzing compatibility: $e');
    }
  }
} 