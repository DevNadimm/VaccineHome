import 'package:dio/dio.dart';
import 'package:vaccine_home/core/constants/api_endpoints.dart';
import 'package:vaccine_home/core/constants/messages.dart';
import 'package:vaccine_home/core/services/dio_service.dart';
import 'package:vaccine_home/core/services/service_locator.dart';
import 'package:vaccine_home/features/vaccine_card/data/models/patients_model.dart';

class PatientsRepository {
  static Future<List<Patient>> fetchPatients() async {
    final dioService = serviceLocator<DioService>();
    final apiEndpoints = serviceLocator<ApiEndpoints>();

    final Response res = await dioService.getRequest(
      apiEndpoints.patients,
      errorMessage: Messages.patientsFetchFailed,
    );

    if (res.statusCode == 200) {
      final model = PatientsModel.fromJson(res.data);
      return model.data ?? [];
    } else {
      throw Exception(Messages.patientsFetchFailed);
    }
  }
}