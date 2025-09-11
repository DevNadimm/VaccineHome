import 'package:intl/intl.dart';

class NotificationModel {
  final String title;
  final String message;
  final DateTime createdAt;
  final bool isRead;

  const NotificationModel({
    required this.title,
    required this.message,
    required this.createdAt,
    this.isRead = false,
  });

  /// Time ago formatter
  String get timeAgo {
    final diff = DateTime.now().difference(createdAt);

    if (diff.inMinutes < 60) {
      return "${diff.inMinutes}m ago";
    } else if (diff.inHours < 24) {
      return "${diff.inHours}h ago";
    } else if (diff.inDays < 7) {
      return "${diff.inDays}d ago";
    } else {
      return DateFormat('d MMM yyyy').format(createdAt);
    }
  }
}
