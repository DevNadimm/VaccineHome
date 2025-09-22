import 'package:dio/dio.dart';
import 'package:vaccine_home/core/constants/api_endpoints.dart';
import 'package:vaccine_home/core/constants/messages.dart';
import 'package:vaccine_home/core/services/dio_service.dart';
import 'package:vaccine_home/core/services/service_locator.dart';
import 'package:vaccine_home/features/mental_well_being/data/models/mental_well_being_model.dart';

class MentalWellBeingRepository {
  static Future<List<MentalWellBeingItem>> fetchMentalWellBeings() async {
    final dioService = serviceLocator<DioService>();
    final apiEndpoints = serviceLocator<ApiEndpoints>();

    final Response res = await dioService.getRequest(
      apiEndpoints.mentalWellBeings,
      errorMessage: Messages.mentalWellBeingFailed,
    );

    if (res.statusCode == 200) {
      final model = MentalWellBeingModel.fromJson(res.data);
      return model.data?.mentalWellBeings ?? [];
    } else {
      throw Exception(Messages.mentalWellBeingFailed);
    }
  }
}
