import 'package:dio/dio.dart';
import 'package:vaccine_home/core/constants/api_endpoints.dart';
import 'package:vaccine_home/core/constants/messages.dart';
import 'package:vaccine_home/core/services/dio_service.dart';
import 'package:vaccine_home/core/services/service_locator.dart';
import 'package:vaccine_home/features/vaccine/data/models/vaccine_recommendations_model.dart';

class VaccineRecommendationsRepository {
  static Future<List<VaccineRecommendation>> fetchRecommendations() async {
    final dioService = serviceLocator<DioService>();
    final apiEndpoints = serviceLocator<ApiEndpoints>();

    final Response res = await dioService.getRequest(
      apiEndpoints.vaccineRecommendations,
      errorMessage: Messages.vaccineRecommendationsFetchFailed,
    );

    if (res.statusCode == 200) {
      final model = VaccineRecommendationsModel.fromJson(res.data);
      return model.data?.vaccineRecommendations ?? [];
    } else {
      throw Exception(Messages.vaccineRecommendationsFetchFailed);
    }
  }
}
