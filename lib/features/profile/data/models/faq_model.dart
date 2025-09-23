class FAQModel {
  final FAQData? data;

  FAQModel({this.data});

  factory FAQModel.fromJson(Map<String, dynamic> json) {
    return FAQModel(
      data: json['data'] != null ? FAQData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data?.toJson(),
    };
  }
}

class FAQData {
  final int? status;
  final List<FAQ>? faqs;

  FAQData({this.status, this.faqs});

  factory FAQData.fromJson(Map<String, dynamic> json) {
    return FAQData(
      status: json['status'] as int?,
      faqs: (json['faqs'] as List<dynamic>?)
          ?.map((e) => FAQ.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'faqs': faqs?.map((e) => e.toJson()).toList(),
    };
  }
}

class FAQ {
  final int? id;
  final String? question;
  final String? answer;
  final String? isActive;
  final String? createdAt;
  final String? updatedAt;

  FAQ({
    this.id,
    this.question,
    this.answer,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  factory FAQ.fromJson(Map<String, dynamic> json) {
    return FAQ(
      id: json['id'] as int?,
      question: json['question'] as String?,
      answer: json['answer'] as String?,
      isActive: json['is_active'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question': question,
      'answer': answer,
      'is_active': isActive,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
