class Logger {
  static void log(String message) {
    final String timestamp = DateTime.now().toIso8601String();
    print('[LOG] $timestamp: $message');
  }

  static void error(String message, [dynamic error]) {
    final String timestamp = DateTime.now().toIso8601String();
    print('[ERROR] $timestamp: $message');
    if (error != null) {
      print('[ERROR DETAILS]: $error');
    }
  }
}
