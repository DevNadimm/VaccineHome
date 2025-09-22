class MentalWellBeingModel {
  final Data? data;

  MentalWellBeingModel({this.data});

  factory MentalWellBeingModel.fromJson(Map<String, dynamic> json) {
    return MentalWellBeingModel(
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data?.toJson(),
    };
  }
}

class Data {
  final int? status;
  final List<MentalWellBeingItem>? mentalWellBeings;

  Data({this.status, this.mentalWellBeings});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      status: json['status'],
      mentalWellBeings: json['mental_well_beings'] != null
          ? List<MentalWellBeingItem>.from(json['mental_well_beings']
              .map((x) => MentalWellBeingItem.fromJson(x)))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'mental_well_beings': mentalWellBeings?.map((x) => x.toJson()).toList(),
    };
  }
}

class MentalWellBeingItem {
  final int? id;
  final String? type;
  final String? title;
  final String? description;
  final String? image;
  final String? youtubeVideoLink;
  final String? createdAt;
  final String? updatedAt;

  MentalWellBeingItem({
    this.id,
    this.type,
    this.title,
    this.description,
    this.image,
    this.youtubeVideoLink,
    this.createdAt,
    this.updatedAt,
  });

  factory MentalWellBeingItem.fromJson(Map<String, dynamic> json) {
    return MentalWellBeingItem(
      id: json['id'],
      type: json['type'],
      title: json['title'],
      description: json['description'],
      image: json['image'],
      youtubeVideoLink: json['youtube_video_link'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'title': title,
      'description': description,
      'image': image,
      'youtube_video_link': youtubeVideoLink,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
