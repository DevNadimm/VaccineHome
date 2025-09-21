class TimeConversionHelper {
  TimeConversionHelper._();

  /// Converts "8:00 AM" or "10:00 PM" → "HH:mm"
  static String to24Hour(String time12h) {
    try {
      final parts = time12h.split(' '); // ["8:00", "AM"]
      final time = parts[0].split(':'); // ["8", "00"]
      int hour = int.parse(time[0]);
      final minute = int.parse(time[1]);
      final period = parts[1]; // "AM" or "PM"

      if (period == 'AM' && hour == 12) hour = 0;
      if (period == 'PM' && hour != 12) hour += 12;

      return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
    } catch (_) {
      return time12h; // fallback if something unexpected happens
    }
  }

  /// Converts "HH:mm" (24-hour) → "h:mm AM/PM"
  static String to12Hour(String time24h) {
    try {
      final parts = time24h.split(':'); // ["13", "45"]
      int hour = int.parse(parts[0]);
      final minute = int.parse(parts[1]);

      final period = hour >= 12 ? 'PM' : 'AM';
      if (hour == 0) {
        hour = 12; // midnight case
      } else if (hour > 12) {
        hour -= 12; // convert 13..23 → 1..11
      }

      return '$hour:${minute.toString().padLeft(2, '0')} $period';
    } catch (_) {
      return time24h; // fallback
    }
  }
}
