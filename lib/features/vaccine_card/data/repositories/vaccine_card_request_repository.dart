import 'package:dio/dio.dart';
import 'package:vaccine_home/core/constants/api_endpoints.dart';
import 'package:vaccine_home/core/constants/messages.dart';
import 'package:vaccine_home/core/services/dio_service.dart';
import 'package:vaccine_home/core/services/service_locator.dart';

class VaccineCardRequestRepository {
  static Future<bool> requestVaccineCard({
    required String firstNameEnglish,
    String? lastNameEnglish,
    required String gender,
    required String vaccinationCentre,
    required String birthDate,
    required String father,
    required String mother,
    required String phoneNumber,
    required String presentNationality,
    String? whatsapp,
    String? address,
  }) async {
    final dioService = serviceLocator<DioService>();
    final apiEndpoints = serviceLocator<ApiEndpoints>();

    final parts = birthDate.split('/');
    final apiDOB = "${parts[0].padLeft(2, '0')}-${parts[1].padLeft(2, '0')}-${parts[2]}";

    final Map<String, dynamic> data = {
      "first_name_english": firstNameEnglish,
      "last_name_english": lastNameEnglish?.isEmpty == true ? null : lastNameEnglish,
      "gender": gender,
      "vaccination_centre": vaccinationCentre,
      "birth_date": apiDOB,
      "father": father,
      "mother": mother,
      "phone_number": phoneNumber,
      "present_nationality": presentNationality,
      "whatsapp_imo": whatsapp?.isEmpty == true ? null : whatsapp,
      "address": address?.isEmpty == true ? null : address,
    };

    final Response res = await dioService.postRequest(
      apiEndpoints.vaccineCardRequest,
      data: data,
      errorMessage: Messages.vaccineCardRequestFailed,
    );

    if (res.statusCode == 200 || res.statusCode == 201) {
      return true;
    } else {
      throw Exception(res.data['message']);
    }
  }
}
