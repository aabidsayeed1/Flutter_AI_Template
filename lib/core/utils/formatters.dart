import 'package:intl/intl.dart';
import 'dart:math' show pow;

/// String and data formatting utilities
class Formatters {
  /// Formats DateTime to string
  static String formatDate(DateTime date, {String pattern = 'dd/MM/yyyy'}) {
    try {
      return DateFormat(pattern).format(date);
    } catch (e) {
      return date.toString();
    }
  }

  /// Formats DateTime with time
  static String formatDateTime(
    DateTime dateTime, {
    String pattern = 'dd/MM/yyyy HH:mm',
  }) {
    try {
      return DateFormat(pattern).format(dateTime);
    } catch (e) {
      return dateTime.toString();
    }
  }

  /// Formats time only
  static String formatTime(DateTime time, {String pattern = 'HH:mm'}) {
    try {
      return DateFormat(pattern).format(time);
    } catch (e) {
      return time.toString();
    }
  }

  /// Formats currency
  static String formatCurrency(double amount, {String symbol = '\$'}) {
    return '$symbol${amount.toStringAsFixed(2)}';
  }

  /// Formats number with comma separators
  static String formatNumber(num number) {
    return NumberFormat('#,###').format(number);
  }

  /// Capitalizes first letter of string
  static String capitalize(String value) {
    if (value.isEmpty) return value;
    return value[0].toUpperCase() + value.substring(1).toLowerCase();
  }

  /// Capitalizes first letter of each word
  static String capitalizeEachWord(String value) {
    return value.split(' ').map((word) => capitalize(word)).join(' ');
  }

  /// Truncates string with ellipsis
  static String truncate(
    String value, {
    int length = 50,
    String suffix = '...',
  }) {
    if (value.length <= length) return value;
    return '${value.substring(0, length)}$suffix';
  }

  /// Formats file size in human readable format
  static String formatFileSize(int bytes) {
    if (bytes <= 0) return '0 B';
    const suffixes = ['B', 'KB', 'MB', 'GB'];
    var i = (bytes.log() / 1024.log()).floor();
    return '${(bytes / pow(1024, i)).toStringAsFixed(2)} ${suffixes[i]}';
  }
}

// Extension for num.log()
extension on num {
  double log() => (this as double).log();
}
