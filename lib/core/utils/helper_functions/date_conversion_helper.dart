import 'package:intl/intl.dart';

class DateConversionHelper {
  DateConversionHelper._();

  /// Converts "2025-09-20T01:51:55.000000Z" → "20 September, 2025"
  static String fromApiFormat(String dateString) {
    try {
      final date = DateTime.parse(dateString).toLocal();
      final formatter = DateFormat('dd MMMM, yyyy');
      return formatter.format(date);
    } catch (_) {
      return dateString;
    }
  }

  /// Converts raw date string to readable "20 September, 2025"
  static String toReadable(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      final formatter = DateFormat('dd MMMM, yyyy');
      return formatter.format(date);
    } catch (_) {
      return dateString;
    }
  }

  /// Converts "dd-MM-yyyy HH:mm" → "20 September, 2025 01:51 AM"
  static String fromCustomFormat(String dateString) {
    try {
      final inputFormat = DateFormat("dd-MM-yyyy HH:mm");
      final date = inputFormat.parse(dateString);
      final outputFormat = DateFormat("dd MMMM, yyyy hh:mm a");
      return outputFormat.format(date);
    } catch (_) {
      return dateString;
    }
  }
}
