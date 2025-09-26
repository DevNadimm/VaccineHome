class VaccineRecommendationsModel {
  final VaccineData? data;

  VaccineRecommendationsModel({this.data});

  factory VaccineRecommendationsModel.fromJson(Map<String, dynamic> json) {
    return VaccineRecommendationsModel(
      data: json['data'] != null ? VaccineData.fromJson(json['data']) : null,
    );
  }
}

class VaccineData {
  final int? status;
  final List<VaccineRecommendation>? vaccineRecommendations;

  VaccineData({this.status, this.vaccineRecommendations});

  factory VaccineData.fromJson(Map<String, dynamic> json) {
    return VaccineData(
      status: json['status'] as int?,
      vaccineRecommendations: (json['vaccineRecommendations'] as List?)
          ?.map((e) => VaccineRecommendation.fromJson(e))
          .toList(),
    );
  }
}

class VaccineRecommendation {
  final int? id;
  final String? vaccineProductId;
  final String? details;
  final String? reason;
  final String? createdAt;
  final String? updatedAt;
  final Product? product;

  VaccineRecommendation({
    this.id,
    this.vaccineProductId,
    this.details,
    this.reason,
    this.createdAt,
    this.updatedAt,
    this.product,
  });

  factory VaccineRecommendation.fromJson(Map<String, dynamic> json) {
    return VaccineRecommendation(
      id: json['id'] as int?,
      vaccineProductId: json['vaccine_product_id'] as String?,
      details: json['details'] as String?,
      reason: json['reason'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      product:
          json['product'] != null ? Product.fromJson(json['product']) : null,
    );
  }
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
  final String? createdAt;
  final String? updatedAt;

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

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int?,
      name: json['name'] as String?,
      image: json['image'] as String?,
      price: json['price'] as String?,
      productType: json['product_type'] as String?,
      description: json['description'] as String?,
      gender: json['gender'] as String?,
      from: json['from'] as String?,
      to: json['to'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }
}
