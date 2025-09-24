class VaccineOrderModel {
  final int? status;
  final List<VaccineOrderData>? orders;

  VaccineOrderModel({this.status, this.orders});

  factory VaccineOrderModel.fromJson(Map<String, dynamic> json) =>
      VaccineOrderModel(
        status: json['status'] as int?,
        orders: json['orders'] != null
            ? List<VaccineOrderData>.from((json['orders'] as List)
                .map((x) => VaccineOrderData.fromJson(x)))
            : null,
      );
}

class VaccineOrderData {
  final int? id;
  final String? userId;
  final String? vaccineProductId;
  final String? phone;
  final String? address;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Product? product;
  final User? user;

  VaccineOrderData({
    this.id,
    this.userId,
    this.vaccineProductId,
    this.phone,
    this.address,
    this.createdAt,
    this.updatedAt,
    this.product,
    this.user,
  });

  factory VaccineOrderData.fromJson(Map<String, dynamic> json) =>
      VaccineOrderData(
        id: json['id'] as int?,
        userId: json['user_id'] as String?,
        vaccineProductId: json['vaccine_product_id'] as String?,
        phone: json['phone'] as String?,
        address: json['address'] as String?,
        createdAt: json['created_at'] != null
            ? DateTime.tryParse(json['created_at'])
            : null,
        updatedAt: json['updated_at'] != null
            ? DateTime.tryParse(json['updated_at'])
            : null,
        product:
            json['product'] != null ? Product.fromJson(json['product']) : null,
        user: json['user'] != null ? User.fromJson(json['user']) : null,
      );
}

class Product {
  final int? id;
  final String? name;
  final String? image;
  final String? price;
  final String? productType;
  final String? description;
  final String? gender;
  final String? from;
  final String? to;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Product({
    this.id,
    this.name,
    this.image,
    this.price,
    this.productType,
    this.description,
    this.gender,
    this.from,
    this.to,
    this.createdAt,
    this.updatedAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json['id'] as int?,
        name: json['name'] as String?,
        image: json['image'] as String?,
        price: json['price'] as String?,
        productType: json['product_type'] as String?,
        description: json['description'] as String?,
        gender: json['gender'] as String?,
        from: json['from'] as String?,
        to: json['to'] as String?,
        createdAt: json['created_at'] != null
            ? DateTime.tryParse(json['created_at'])
            : null,
        updatedAt: json['updated_at'] != null
            ? DateTime.tryParse(json['updated_at'])
            : null,
      );
}

class User {
  final int? id;
  final String? name;
  final String? email;
  final String? emailVerifiedAt;
  final bool? isAdmin;
  final String? avatar;
  final String? phone;
  final DateTime? dateOfBirth;
  final String? gender;
  final String? address;
  final DateTime? createdAt;
  final DateTime? updatedAt;

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

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'] as int?,
        name: json['name'] as String?,
        email: json['email'] as String?,
        emailVerifiedAt: json['email_verified_at'] as String?,
        isAdmin: json['is_admin'] as bool?,
        avatar: json['avatar'] as String?,
        phone: json['phone'] as String?,
        dateOfBirth: json['date_of_birth'] != null
            ? DateTime.tryParse(json['date_of_birth'])
            : null,
        gender: json['gender'] as String?,
        address: json['address'] as String?,
        createdAt: json['created_at'] != null
            ? DateTime.tryParse(json['created_at'])
            : null,
        updatedAt: json['updated_at'] != null
            ? DateTime.tryParse(json['updated_at'])
            : null,
      );
}
