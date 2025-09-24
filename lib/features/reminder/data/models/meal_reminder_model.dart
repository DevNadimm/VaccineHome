class MealReminderModel {
  final int? status;
  final List<MealData>? data;

  MealReminderModel({
    this.status,
    this.data,
  });

  factory MealReminderModel.fromJson(Map<String, dynamic> json) {
    return MealReminderModel(
      status: json['status'] as int?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => MealData.fromJson(e as Map<String, dynamic>))
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

class MealData {
  final int? id;
  final String? userId;
  final String? mealDescription;
  final List<String>? mealTimes;
  final String? createdAt;
  final String? updatedAt;

  MealData({
    this.id,
    this.userId,
    this.mealDescription,
    this.mealTimes,
    this.createdAt,
    this.updatedAt,
  });

  factory MealData.fromJson(Map<String, dynamic> json) {
    return MealData(
      id: json['id'] as int?,
      userId: json['user_id'] as String?,
      mealDescription: json['meal_description'] as String?,
      mealTimes: (json['meal_times'] as List<dynamic>?)
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
      'meal_description': mealDescription,
      'meal_times': mealTimes,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
