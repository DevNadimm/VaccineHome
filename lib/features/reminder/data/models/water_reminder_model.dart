class WaterReminderModel {
  final int? status;
  final List<WaterData>? data;

  WaterReminderModel({
    this.status,
    this.data,
  });

  factory WaterReminderModel.fromJson(Map<String, dynamic> json) {
    return WaterReminderModel(
      status: json['status'] as int?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => WaterData.fromJson(e as Map<String, dynamic>))
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

class WaterData {
  final int? id;
  final String? userId;
  final String? totalWater;
  final List<String>? waterTimes;
  final String? createdAt;
  final String? updatedAt;

  WaterData({
    this.id,
    this.userId,
    this.totalWater,
    this.waterTimes,
    this.createdAt,
    this.updatedAt,
  });

  factory WaterData.fromJson(Map<String, dynamic> json) {
    return WaterData(
      id: json['id'] as int?,
      userId: json['user_id'] as String?,
      totalWater: json['total_water'] as String?,
      waterTimes: (json['water_times'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'total_water': totalWater,
      'water_times': waterTimes,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
