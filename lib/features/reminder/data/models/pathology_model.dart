class PathologyModel {
  int? status;
  List<Pathology>? data;

  PathologyModel({
    this.status,
    this.data,
  });

  factory PathologyModel.fromJson(Map<String, dynamic> json) {
    return PathologyModel(
      status: json['status'] as int?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Pathology.fromJson(e))
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

class Pathology {
  int? id;
  String? userId;
  String? testName;
  String? nextTestDate;
  String? nextTestTime;
  String? description;
  String? createdAt;
  String? updatedAt;

  Pathology({
    this.id,
    this.userId,
    this.testName,
    this.nextTestDate,
    this.nextTestTime,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  factory Pathology.fromJson(Map<String, dynamic> json) {
    return Pathology(
      id: json['id'] as int?,
      userId: json['user_id'] as String?,
      testName: json['test_name'] as String?,
      nextTestDate: json['next_test_date'] as String?,
      nextTestTime: json['next_test_time'] as String?,
      description: json['description'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'test_name': testName,
      'next_test_date': nextTestDate,
      'next_test_time': nextTestTime,
      'description': description,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
