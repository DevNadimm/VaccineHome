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

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': data?.map((e) => e.toJson()).toList(),
    };
  }
}

class Medication {
  int? id;
  String? userId;
  String? medicationName;
  String? medicationType;
  List<String>? times;
  String? whenToTake;
  String? createdAt;
  String? updatedAt;

  Medication({
    this.id,
    this.userId,
    this.medicationName,
    this.medicationType,
    this.times,
    this.whenToTake,
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
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'medication_name': medicationName,
      'medication_type': medicationType,
      'times': times,
      'when_to_take': whenToTake,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
