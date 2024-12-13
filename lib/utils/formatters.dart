import 'package:intl/intl.dart';
import 'package:intl/locale.dart';

class Formatters {
  static String formatPrice(double price, {String currencySymbol = '\$'}) {
    final NumberFormat currencyFormatter = NumberFormat.currency(symbol: currencySymbol);
    return currencyFormatter.format(price);
  }

  static String formatDate(DateTime date, {String locale = 'en_US'}) {
    return DateFormat.yMMMd(locale).format(date);
  }

  static String formatTime(DateTime time, {String locale = 'en_US'}) {
    return DateFormat.jm(locale).format(time);
  }

  static String formatNumber(int number) {
    final NumberFormat numberFormatter = NumberFormat.decimalPattern();
    return numberFormatter.format(number);
  }

  static String formatDateTime(DateTime dateTime, {String locale = 'en_US'}) {
    return DateFormat.yMMMd(locale).add_jm().format(dateTime);
  }

  static String convertCurrency(double amount, double conversionRate, {String targetCurrencySymbol = '\$'}) {
    final convertedAmount = amount * conversionRate;
    return formatPrice(convertedAmount, currencySymbol: targetCurrencySymbol);
  }
}
