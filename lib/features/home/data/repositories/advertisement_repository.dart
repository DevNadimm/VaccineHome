import 'package:dio/dio.dart';
import 'package:vaccine_home/core/constants/api_endpoints.dart';
import 'package:vaccine_home/core/constants/messages.dart';
import 'package:vaccine_home/core/services/dio_service.dart';
import 'package:vaccine_home/core/services/service_locator.dart';
import 'package:vaccine_home/features/home/data/models/advertisement_model.dart';

class AdvertisementRepository {
  static Future<AdvertisementModel> getAdvertisements() async {
    final dioService = serviceLocator<DioService>();
    final apiEndpoints = serviceLocator<ApiEndpoints>();

    final Response res = await dioService.getRequest(
      apiEndpoints.getAdvertisements,
      errorMessage: Messages.changePasswordFailed,
    );

    if (res.statusCode == 200) {
      return AdvertisementModel.fromJson(res.data);
    } else {
      throw Exception(Messages.changePasswordFailed);
    }
  }
}
