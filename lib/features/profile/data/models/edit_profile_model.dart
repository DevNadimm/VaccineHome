class EditProfileModel {
  bool? success;
  String? message;
  UserData? data;

  EditProfileModel({this.success, this.message, this.data});

  factory EditProfileModel.fromJson(Map<String, dynamic> json) {
    return EditProfileModel(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      data: json['data'] != null ? UserData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'success': success,
    'message': message,
    'data': data?.toJson(),
  };
}

class UserData {
  int? id;
  String? name;
  String? email;
  String? emailVerifiedAt;
  bool? isAdmin;
  String? avatar;
  String? phone;
  String? dateOfBirth;
  String? gender;
  String? address;
  String? createdAt;
  String? updatedAt;

  UserData({
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

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
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

  Map<String, dynamic> toJson() => {
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
