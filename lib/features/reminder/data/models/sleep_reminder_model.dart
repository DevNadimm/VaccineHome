class SleepReminderModel {
  final int? status;
  final List<SleepData>? data;

  SleepReminderModel({
    this.status,
    this.data,
  });

  factory SleepReminderModel.fromJson(Map<String, dynamic> json) {
    return SleepReminderModel(
      status: json['status'] as int?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => SleepData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': data?.map((e) => e.toJson()).toList(),
    };
  }
}

class SleepData {
  final int? id;
  final String? userId;
  final String? sleepTime;
  final String? createdAt;
  final String? updatedAt;

  SleepData({
    this.id,
    this.userId,
    this.sleepTime,
    this.createdAt,
    this.updatedAt,
  });

  factory SleepData.fromJson(Map<String, dynamic> json) {
    return SleepData(
      id: json['id'] as int?,
      userId: json['user_id'] as String?,
      sleepTime: json['sleep_time'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'sleep_time': sleepTime,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
