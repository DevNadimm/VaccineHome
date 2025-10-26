class MedicationModel {
  int? status;
  List<Medication>? data;

  MedicationModel({
    this.status,
    this.data,
  });

  factory MedicationModel.fromJson(Map<String, dynamic> json) {
    return MedicationModel(
      status: json['status'] as int?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Medication.fromJson(e))
          .toList(),
    );
  }
}

class Medication {
  int? id;
  String? userId;
  String? medicationName;
  String? medicationType;
  List<String>? times;
  String? whenToTake;
  String? duration;
  String? startDate;
  String? endDate;
  String? createdAt;
  String? updatedAt;

  Medication({
    this.id,
    this.userId,
    this.medicationName,
    this.medicationType,
    this.times,
    this.whenToTake,
    this.duration,
    this.startDate,
    this.endDate,
    this.createdAt,
    this.updatedAt,
  });

  factory Medication.fromJson(Map<String, dynamic> json) {
    return Medication(
      id: json['id'] as int?,
      userId: json['user_id'] as String?,
      medicationName: json['medication_name'] as String?,
      medicationType: json['medication_type'] as String?,
      times:
      (json['times'] as List<dynamic>?)?.map((e) => e as String).toList(),
      whenToTake: json['when_to_take'] as String?,
      duration: json['duration'] as String?,
      startDate: json['start_date'] as String?,
      endDate: json['end_date'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }
}
