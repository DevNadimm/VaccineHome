class MenstrualCycleAlertModel {
  int? status;
  List<MenstrualCycleData>? data;

  MenstrualCycleAlertModel({this.status, this.data});

  factory MenstrualCycleAlertModel.fromJson(Map<String, dynamic> json) {
    return MenstrualCycleAlertModel(
      status: json['status'],
      data: (json['data'] as List?)
          ?.map((item) => MenstrualCycleData.fromJson(item))
          .toList(),
    );
  }
}

class MenstrualCycleData {
  int? id;
  String? userId;
  String? lastCycleStartDate;
  String? lastCycleEndDate;
  String? createdAt;
  String? updatedAt;

  MenstrualCycleData({
    this.id,
    this.userId,
    this.lastCycleStartDate,
    this.lastCycleEndDate,
    this.createdAt,
    this.updatedAt,
  });

  factory MenstrualCycleData.fromJson(Map<String, dynamic> json) {
    return MenstrualCycleData(
      id: json['id'],
      userId: json['user_id'],
      lastCycleStartDate: json['last_cycle_start_date'],
      lastCycleEndDate: json['last_cycle_end_date'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
