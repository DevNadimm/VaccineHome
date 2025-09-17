class RegisterModel {
  final bool? success;
  final String? message;
  final UserData? data;
  final String? accessToken;
  final String? tokenType;

  RegisterModel({
    this.success,
    this.message,
    this.data,
    this.accessToken,
    this.tokenType,
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) {
    return RegisterModel(
      success: json['success'],
      message: json['message'],
      data: json['data'] != null ? UserData.fromJson(json['data']) : null,
      accessToken: json['access_token'],
      tokenType: json['token_type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data?.toJson(),
      'access_token': accessToken,
      'token_type': tokenType,
    };
  }
}

class UserData {
  final int? id;
  final String? name;
  final String? email;
  final String? phone;
  final bool? isAdmin;
  final String? createdAt;
  final String? updatedAt;

  UserData({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.isAdmin,
    this.createdAt,
    this.updatedAt,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      isAdmin: json['is_admin'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'is_admin': isAdmin,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
