class AdvertisementModel {
  final int? status;
  final List<Advertisement>? advertisements;

  AdvertisementModel({this.status, this.advertisements});

  factory AdvertisementModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    return AdvertisementModel(
      status: data?['status'] as int?,
      advertisements: (data?['advertisements'] as List<dynamic>?)
          ?.map((e) => Advertisement.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': {
        'status': status,
        'advertisements': advertisements?.map((e) => e.toJson()).toList(),
      }
    };
  }
}

class Advertisement {
  final String? title;
  final String? image;
  final bool? isActive;
  final String? createdAt;
  final String? updatedAt;

  Advertisement({
    this.title,
    this.image,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  factory Advertisement.fromJson(Map<String, dynamic> json) {
    return Advertisement(
      title: json['title'] as String?,
      image: json['image'] as String?,
      isActive: json['is_active'] as bool?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'image': image,
      'is_active': isActive,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
