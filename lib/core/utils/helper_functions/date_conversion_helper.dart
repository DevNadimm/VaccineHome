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
}
