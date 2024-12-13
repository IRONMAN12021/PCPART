import 'package:flutter/material.dart';

class AppHelpers {
  // Format price as currency
  static String formatPrice(double price) {
    return '\$${price.toStringAsFixed(2)}';
  }

  // Show a simple dialog
  static void showDialogMessage(
      BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  // Show a loading indicator
  static void showLoading(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  // Dismiss a loading indicator
  static void hideLoading(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }

  // Error handler for API calls
  static String handleApiError(dynamic error) {
    if (error is String) {
      return error;
    } else if (error is Exception) {
      return error.toString();
    } else {
      return 'An unknown error occurred';
    }
  }
}
