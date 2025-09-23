import 'package:intl/intl.dart';

class NotificationModel {
  final bool? success;
  final List<NotificationData>? notifications;

  NotificationModel({this.success, this.notifications});

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      success: json['success'] as bool?,
      notifications: (json['notifications'] as List<dynamic>?)?.map((e) => NotificationData.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'notifications': notifications?.map((e) => e.toJson()).toList(),
    };
  }
}

class NotificationData {
  final String? id;
  final String? type;
  final String? notifiableType;
  final String? notifiableId;
  final NotificationContent? data;
  final String? readAt;
  final String? createdAt;
  final String? updatedAt;

  NotificationData({
    this.id,
    this.type,
    this.notifiableType,
    this.notifiableId,
    this.data,
    this.readAt,
    this.createdAt,
    this.updatedAt,
  });

  factory NotificationData.fromJson(Map<String, dynamic> json) {
    return NotificationData(
      id: json['id'] as String?,
      type: json['type'] as String?,
      notifiableType: json['notifiable_type'] as String?,
      notifiableId: json['notifiable_id'] as String?,
      data: json['data'] != null
          ? NotificationContent.fromJson(json['data'] as Map<String, dynamic>)
          : null,
      readAt: json['read_at'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'notifiable_type': notifiableType,
      'notifiable_id': notifiableId,
      'data': data?.toJson(),
      'read_at': readAt,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  /// Derived field → whether notification is read
  bool get isRead => readAt != null;

  /// Time ago formatter
  String get timeAgo {
    if (createdAt == null) return "";
    final date = DateTime.tryParse(createdAt!);
    if (date == null) return "";

    final diff = DateTime.now().difference(date);

    if (diff.inSeconds < 60) {
      return "Just now";
    } else if (diff.inMinutes < 60) {
      return "${diff.inMinutes}m ago";
    } else if (diff.inHours < 24) {
      return "${diff.inHours}h ago";
    } else if (diff.inDays < 7) {
      return "${diff.inDays}d ago";
    } else {
      return DateFormat('d MMM yyyy').format(date);
    }
  }
}

class NotificationContent {
  final String? title;
  final String? message;
  final String? time;

  NotificationContent({this.title, this.message, this.time});

  factory NotificationContent.fromJson(Map<String, dynamic> json) {
    return NotificationContent(
      title: json['title'] as String?,
      message: json['message'] as String?,
      time: json['time'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'message': message,
      'time': time,
    };
  }
}
