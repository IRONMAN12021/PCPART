import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkCheck {
  static Future<bool> isConnected() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  static Future<void> checkConnectionAndProceed(
      Function onSuccess, Function onFailure) async {
    if (await isConnected()) {
      onSuccess();
    } else {
      onFailure();
    }
  }
}

