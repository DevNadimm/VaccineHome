import 'package:intl/intl.dart';

class DateConversionHelper {
  DateConversionHelper._();

  static String toReadable(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      final formatter = DateFormat('dd MMMM, yyyy');
      return formatter.format(date);
    } catch (_) {
      return dateString;
    }
  }

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
