class TimeConversionHelper {
  TimeConversionHelper._();

  /// Converts "8:00 AM" or "10:00 PM" to 24-hour format "HH:mm"
  static String to24Hour(String time12h) {
    try {
      final parts = time12h.split(' ');      // ["8:00", "AM"]
      final time = parts[0].split(':');      // ["8", "00"]
      int hour = int.parse(time[0]);
      final minute = int.parse(time[1]);
      final period = parts[1];                // "AM" or "PM"

      if (period == 'AM' && hour == 12) hour = 0;
      if (period == 'PM' && hour != 12) hour += 12;

      return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
    } catch (_) {
      return time12h; // fallback if something unexpected happens
    }
  }
}
