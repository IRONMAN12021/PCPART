import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin _notifications;

  NotificationService(this._notifications) {
    _initializeNotifications();
  }

  Future<void> _initializeNotifications() async {
    const initializationSettings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    );
    await _notifications.initialize(initializationSettings);
  }

  Future<void> showPriceAlert(String partName, double price, String retailer) async {
    const notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        'price_alerts',
        'Price Alerts',
        importance: Importance.high,
      ),
      iOS: DarwinNotificationDetails(),
    );

    await _notifications.show(
      0,
      'Price Alert',
      '$partName is now \$$price on $retailer',
      notificationDetails,
    );
  }
} 