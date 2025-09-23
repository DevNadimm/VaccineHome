import 'package:dio/dio.dart';
import 'package:vaccine_home/core/constants/api_endpoints.dart';
import 'package:vaccine_home/core/constants/messages.dart';
import 'package:vaccine_home/core/services/dio_service.dart';
import 'package:vaccine_home/core/services/service_locator.dart';
import 'package:vaccine_home/features/profile/data/models/feedback_model.dart';

class FeedbackRepository {
  static Future<List<FeedbackData>> getFeedbacks() async {
    final dioService = serviceLocator<DioService>();
    final apiEndpoints = serviceLocator<ApiEndpoints>();

    final Response res = await dioService.getRequest(
      apiEndpoints.feedbacks,
      errorMessage: Messages.feedbackFetchFailed,
    );

    if (res.statusCode == 200) {
      final model = FeedbackModel.fromJson(res.data);
      return model.data ?? [];
    } else {
      throw Exception(Messages.feedbackFetchFailed);
    }
  }

  static Future<bool> submitFeedback({
    required String feedback,
    required int rating,
    required String experience,
    required String feedbackType,
    required String improvementArea,
  }) async {
    final dioService = serviceLocator<DioService>();
    final apiEndpoints = serviceLocator<ApiEndpoints>();

    final data = {
      "feedback": feedback,
      "rating": rating,
      "experience": experience,
      "feedback_type": feedbackType,
      "improvement_area": improvementArea,
    };

    final Response res = await dioService.postRequest(
      apiEndpoints.feedbacks,
      data: data,
      errorMessage: Messages.feedbackSubmitFailed,
    );

    if (res.statusCode == 200 || res.statusCode == 201) {
      return true;
    } else {
      throw Exception(Messages.feedbackSubmitFailed);
    }
  }
}
