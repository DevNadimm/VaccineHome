class DrConsultancyModel {
  int? status;
  List<DrConsultancy>? data;

  DrConsultancyModel({
    this.status,
    this.data,
  });

  factory DrConsultancyModel.fromJson(Map<String, dynamic> json) {
    return DrConsultancyModel(
      status: json['status'] as int?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => DrConsultancy.fromJson(e))
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

class DrConsultancy {
  int? id;
  String? userId;
  String? doctorName;
  String? nextConsultationDate;
  String? nextConsultationTime;
  String? address;
  String? createdAt;
  String? updatedAt;

  DrConsultancy({
    this.id,
    this.userId,
    this.doctorName,
    this.nextConsultationDate,
    this.nextConsultationTime,
    this.address,
    this.createdAt,
    this.updatedAt,
  });

  factory DrConsultancy.fromJson(Map<String, dynamic> json) {
    return DrConsultancy(
      id: json['id'] as int?,
      userId: json['user_id'] as String?,
      doctorName: json['doctor_name'] as String?,
      nextConsultationDate: json['next_consultation_date'] as String?,
      nextConsultationTime: json['next_consultation_time'] as String?,
      address: json['address'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'doctor_name': doctorName,
      'next_consultation_date': nextConsultationDate,
      'next_consultation_time': nextConsultationTime,
      'address': address,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
