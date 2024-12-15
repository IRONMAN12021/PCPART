import 'package:http/http.dart' as http;
import 'dart:convert';
//import 'package:myapp/models/pc_part.dart';
import 'package:myapp/utils/api_constants.dart';

class PriceTrackerService {
  final String baseUrl;
  final Map<String, String> retailers = {
    'amazon': 'https://www.amazon.com',
    'newegg': 'https://www.newegg.com',
    'microcenter': 'https://www.microcenter.com',
    'bestbuy': 'https://www.bestbuy.com',
  };

  PriceTrackerService({this.baseUrl = ApiConstants.priceTrackerBaseUrl});

  Future<Map<String, dynamic>> getPriceHistory(String partId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/price-history/$partId'),
        headers: {'Authorization': 'Bearer ${ApiConstants.priceTrackerApiKey}'},
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to fetch price history');
      }
    } catch (e) {
      throw Exception('Error fetching price history: $e');
    }
  }

  Future<Map<String, double>> getCurrentPrices(String partId) async {
    Map<String, double> prices = {};
    
    for (var retailer in retailers.keys) {
      try {
        final response = await http.get(
          Uri.parse('$baseUrl/current-price/$partId?retailer=$retailer'),
          headers: {'Authorization': 'Bearer ${ApiConstants.priceTrackerApiKey}'},
        );

        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          prices[retailer] = data['price'].toDouble();
        }
      } catch (e) {
        print('Error fetching price from $retailer: $e');
      }
    }

    return prices;
  }

  Future<double> getBestPrice(String partId) async {
    final prices = await getCurrentPrices(partId);
    return prices.values.reduce((curr, next) => curr < next ? curr : next);
  }
} 