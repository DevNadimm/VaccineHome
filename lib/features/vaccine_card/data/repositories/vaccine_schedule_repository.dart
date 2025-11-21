import 'package:dio/dio.dart';
import 'package:vaccine_home/core/constants/api_endpoints.dart';
import 'package:vaccine_home/core/constants/messages.dart';
import 'package:vaccine_home/core/services/dio_service.dart';
import 'package:vaccine_home/core/services/service_locator.dart';
import 'package:vaccine_home/features/vaccine_card/data/models/vaccine_schedule_model.dart';

class VaccineScheduleRepository {
  static Future<List<VaccineScheduleData>> fetchVaccineSchedules() async {
    final dioService = serviceLocator<DioService>();
    final apiEndpoints = serviceLocator<ApiEndpoints>();

    final Response res = await dioService.getRequest(
      apiEndpoints.vaccineSchedules,
      errorMessage: Messages.vaccineSchedulesFetchFailed,
    );

    if (res.statusCode == 200) {
      final model = VaccineScheduleModel.fromJson(res.data);
      return model.data ?? [];
    } else {
      throw Exception(Messages.vaccineSchedulesFetchFailed);
    }
  }
}
