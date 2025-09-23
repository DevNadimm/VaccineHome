import 'dart:convert';

class FeedbackModel {
  final int? status;
  final List<FeedbackData>? data;

  FeedbackModel({this.status, this.data});

  factory FeedbackModel.fromJson(Map<String, dynamic> json) {
    return FeedbackModel(
      status: json['status'] as int?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => FeedbackData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': data?.map((e) => e.toJson()).toList(),
    };
  }

  static FeedbackModel fromRawJson(String str) => FeedbackModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());
}

class FeedbackData {
  final int? id;
  final String? userId;
  final String? feedback;
  final String? rating;
  final String? experience;
  final String? feedbackType;
  final String? improvementArea;
  final String? createdAt;
  final String? updatedAt;
  final User? user;

  FeedbackData({
    this.id,
    this.userId,
    this.feedback,
    this.rating,
    this.experience,
    this.feedbackType,
    this.improvementArea,
    this.createdAt,
    this.updatedAt,
    this.user,
  });

  factory FeedbackData.fromJson(Map<String, dynamic> json) {
    return FeedbackData(
      id: json['id'] as int?,
      userId: json['user_id'] as String?,
      feedback: json['feedback'] as String?,
      rating: json['rating'] as String?,
      experience: json['experience'] as String?,
      feedbackType: json['feedback_type'] as String?,
      improvementArea: json['improvement_area'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'feedback': feedback,
      'rating': rating,
      'experience': experience,
      'feedback_type': feedbackType,
      'improvement_area': improvementArea,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'user': user?.toJson(),
    };
  }
}

class User {
  final int? id;
  final String? name;
  final String? email;
  final String? emailVerifiedAt;
  final bool? isAdmin;
  final String? avatar;
  final String? phone;
  final String? dateOfBirth;
  final String? gender;
  final String? address;
  final String? createdAt;
  final String? updatedAt;

  User({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.isAdmin,
    this.avatar,
    this.phone,
    this.dateOfBirth,
    this.gender,
    this.address,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      emailVerifiedAt: json['email_verified_at'] as String?,
      isAdmin: json['is_admin'] as bool?,
      avatar: json['avatar'] as String?,
      phone: json['phone'] as String?,
      dateOfBirth: json['date_of_birth'] as String?,
      gender: json['gender'] as String?,
      address: json['address'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'email_verified_at': emailVerifiedAt,
      'is_admin': isAdmin,
      'avatar': avatar,
      'phone': phone,
      'date_of_birth': dateOfBirth,
      'gender': gender,
      'address': address,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
