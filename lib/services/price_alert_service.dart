import 'package:myapp/services/price_tracker_service.dart';
import 'package:myapp/utils/local_storage.dart';

class PriceAlert {
  final String partId;
  final double targetPrice;
  final String retailer;

  PriceAlert({
    required this.partId,
    required this.targetPrice,
    required this.retailer,
  });
}

class PriceAlertService {
  final PriceTrackerService _priceTracker;
  final LocalStorage _storage;

  PriceAlertService(this._priceTracker, this._storage);

  Future<void> addAlert(PriceAlert alert) async {
    final alerts = await _storage.getList('price_alerts') ?? [];
    alerts.add({
      'partId': alert.partId,
      'targetPrice': alert.targetPrice,
      'retailer': alert.retailer,
    });
    await _storage.saveList('price_alerts', alerts);
  }

  Future<void> checkAlerts() async {
    final alerts = await _storage.getList('price_alerts') ?? [];
    for (var alert in alerts) {
      final prices = await _priceTracker.getCurrentPrices(alert['partId']);
      if (prices[alert['retailer']]! <= alert['targetPrice']) {
        // Trigger notification
      }
    }
  }
} 