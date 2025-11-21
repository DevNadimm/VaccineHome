class VaccineScheduleModel {
  bool? success;
  List<VaccineScheduleData>? data;

  VaccineScheduleModel({this.success, this.data});

  factory VaccineScheduleModel.fromJson(Map<String, dynamic> json) {
    return VaccineScheduleModel(
      success: json['success'] as bool?,
      data: (json['data'] as List<dynamic>?)?.map((e) => VaccineScheduleData.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }
}

class VaccineScheduleData {
  String? type;
  List<Schedule>? schedules;

  VaccineScheduleData({this.type, this.schedules});

  factory VaccineScheduleData.fromJson(Map<String, dynamic> json) {
    return VaccineScheduleData(
      type: json['type'] as String?,
      schedules: (json['schedules'] as List<dynamic>?)?.map((e) => Schedule.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }
}

class Schedule {
  int? id;
  String? vaccineName;
  String? approxAge;
  String? route;
  String? dose;
  String? createdAt;
  String? updatedAt;

  Schedule({
    this.id,
    this.vaccineName,
    this.approxAge,
    this.route,
    this.dose,
    this.createdAt,
    this.updatedAt,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      id: json['id'] as int?,
      vaccineName: json['vaccine_name'] as String?,
      approxAge: json['approx_age'] as String?,
      route: json['route'] as String?,
      dose: json['dose'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }
}
