class PopupBannerModel {
  final bool success;
  final PopupBannerData? data;

  PopupBannerModel({
    required this.success,
    this.data,
  });

  factory PopupBannerModel.fromJson(Map<String, dynamic> json) {
    return PopupBannerModel(
      success: json['success'] ?? false,
      data: json['data'] != null ? PopupBannerData.fromJson(json['data']) : null,
    );
  }
}

class PopupBannerData {
  final int? id;
  final String? title;
  final String? image;
  final String? showDate;

  PopupBannerData({
    this.id,
    this.title,
    this.image,
    this.showDate,
  });

  factory PopupBannerData.fromJson(Map<String, dynamic> json) {
    return PopupBannerData(
      id: json['id'],
      title: json['title'],
      image: json['image'],
      showDate: json['show_date'],
    );
  }
}
