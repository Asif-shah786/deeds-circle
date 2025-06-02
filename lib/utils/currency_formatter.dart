import 'package:intl/intl.dart';

class CurrencyFormatter {
  static final _formatter = NumberFormat.currency(
    symbol: '₨',
    decimalDigits: 0,
    locale: 'en_PK',
  );

  static String format(double amount) {
    return _formatter.format(amount);
  }

  static String formatCompact(double amount) {
    if (amount >= 100000) {
      return '₨${(amount / 100000).toStringAsFixed(1)}L';
    } else if (amount >= 1000) {
      return '₨${(amount / 1000).toStringAsFixed(1)}K';
    }
    return format(amount);
  }
}
