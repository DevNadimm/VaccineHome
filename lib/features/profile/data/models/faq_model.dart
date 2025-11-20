class FAQModel {
  final FAQData? data;

  FAQModel({this.data});

  factory FAQModel.fromJson(Map<String, dynamic> json) {
    return FAQModel(
      data: json['data'] != null ? FAQData.fromJson(json['data']) : null,
    );
  }
}

class FAQData {
  final int? status;
  final List<Category>? categories;

  FAQData({this.status, this.categories});

  factory FAQData.fromJson(Map<String, dynamic> json) {
    return FAQData(
      status: json['status'] as int?,
      categories: (json['categories'] as List<dynamic>?)
          ?.map((e) => Category.fromJson(e))
          .toList(),
    );
  }
}

class Category {
  final int? id;
  final String? name;
  final List<FAQ>? faqs;

  Category({this.id, this.name, this.faqs});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] as int?,
      name: json['name'] as String?,
      faqs: (json['faqs'] as List<dynamic>?)
          ?.map((e) => FAQ.fromJson(e))
          .toList(),
    );
  }
}

class FAQ {
  final int? id;
  final String? faqCategoryId;
  final String? question;
  final String? answer;
  final String? isActive;

  FAQ({
    this.id,
    this.faqCategoryId,
    this.question,
    this.answer,
    this.isActive,
  });

  factory FAQ.fromJson(Map<String, dynamic> json) {
    return FAQ(
      id: json['id'] as int?,
      faqCategoryId: json['faq_category_id']?.toString(),  // <-- Updated
      question: json['question'] as String?,
      answer: json['answer'] as String?,
      isActive: json['is_active']?.toString(),
    );
  }
}
