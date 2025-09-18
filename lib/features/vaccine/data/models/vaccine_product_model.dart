class VaccineProductModel {
  final VaccineProductData? data;

  VaccineProductModel({this.data});

  factory VaccineProductModel.fromJson(Map<String, dynamic> json) {
    return VaccineProductModel(
      data: json['data'] != null
          ? VaccineProductData.fromJson(json['data'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data?.toJson(),
    };
  }
}

class VaccineProductData {
  final int? status;
  final List<VaccineProduct>? vaccineProducts;

  VaccineProductData({this.status, this.vaccineProducts});

  factory VaccineProductData.fromJson(Map<String, dynamic> json) {
    return VaccineProductData(
      status: json['status'] as int?,
      vaccineProducts: json['vaccine'] != null
          ? List<VaccineProduct>.from(
          (json['vaccine'] as List).map((x) => VaccineProduct.fromJson(x)))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'vaccine': vaccineProducts?.map((x) => x.toJson()).toList(),
    };
  }
}

class VaccineProduct {
  final int? id;
  final String? name;
  final String? price;
  final String? productType;
  final String? description;
  final String? gender;
  final String? from;
  final String? to;
  final String? status;
  final String? image;
  final String? createdAt;
  final String? updatedAt;

  VaccineProduct({
    this.id,
    this.name,
    this.price,
    this.productType,
    this.description,
    this.gender,
    this.from,
    this.to,
    this.status,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  factory VaccineProduct.fromJson(Map<String, dynamic> json) {
    return VaccineProduct(
      id: json['id'] as int?,
      name: json['name'] as String?,
      price: json['price'] as String?,
      productType: json['product_type'] as String?,
      description: json['description'] as String?,
      gender: json['gender'] as String?,
      from: json['from'] as String?,
      to: json['to'] as String?,
      status: json['status'] as String?, // nullable
      image: json['image'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'product_type': productType,
      'description': description,
      'gender': gender,
      'from': from,
      'to': to,
      'status': status,
      'image': image,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
