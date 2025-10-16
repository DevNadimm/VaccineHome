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
  final List<String>? images;
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
    this.images,
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
      status: json['status'] as String?,
      images: json['images'] != null ? List<String>.from(json['images']) : null,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }
}
