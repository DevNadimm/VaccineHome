class PhysicalExerciseAlertModel {
  int? status;
  List<ExerciseData>? data;

  PhysicalExerciseAlertModel({this.status, this.data});

  factory PhysicalExerciseAlertModel.fromJson(Map<String, dynamic> json) {
    return PhysicalExerciseAlertModel(
      status: json['status'] as int?,
      data: json['data'] != null
          ? (json['data'] as List)
          .map((e) => ExerciseData.fromJson(e as Map<String, dynamic>))
          .toList()
          : null,
    );
  }
}

class ExerciseData {
  int? id;
  String? userId;
  String? exerciseName;
  String? duration;
  String? time;
  String? startDate;
  String? endDate;
  String? createdAt;
  String? updatedAt;

  ExerciseData({
    this.id,
    this.userId,
    this.exerciseName,
    this.duration,
    this.time,
    this.startDate,
    this.endDate,
    this.createdAt,
    this.updatedAt,
  });

  factory ExerciseData.fromJson(Map<String, dynamic> json) {
    return ExerciseData(
      id: json['id'] as int?,
      userId: json['user_id'] as String?,
      exerciseName: json['exercise_name'] as String?,
      duration: json['duration'] as String?,
      time: json['time'] as String?,
      startDate: json['start_date'] as String?,
      endDate: json['end_date'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }
}
