import 'package:dio/dio.dart';
import 'package:vaccine_home/core/constants/messages.dart';
import 'package:vaccine_home/core/services/dio_service.dart';
import 'package:vaccine_home/core/constants/api_endpoints.dart';
import 'package:vaccine_home/core/services/service_locator.dart';
import 'package:vaccine_home/features/profile/data/models/faq_model.dart';

class FAQRepository {
  static Future<List<Category>> getFaqs() async {
    final dioService = serviceLocator<DioService>();
    final apiEndpoints = serviceLocator<ApiEndpoints>();

    final Response res = await dioService.getRequest(
      apiEndpoints.faqs,
      errorMessage: Messages.faqFetchFailed,
    );

    if (res.statusCode == 200) {
      final model = FAQModel.fromJson(res.data);
      return model.data?.categories ?? [];
    } else {
      throw Exception(Messages.faqFetchFailed);
    }
  }
}
