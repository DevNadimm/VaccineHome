import 'package:dio/dio.dart';
import 'package:vaccine_home/core/constants/api_endpoints.dart';
import 'package:vaccine_home/core/constants/messages.dart';
import 'package:vaccine_home/core/services/dio_service.dart';
import 'package:vaccine_home/core/services/service_locator.dart';

class VaccineCardRequestRepository {
  static Future<bool> requestVaccineCard({
    required String firstNameEnglish,
    required String lastNameEnglish,
    required String gender,
    required String birthDate,
    required String father,
    required String mother,
    required String address,
    required String email,
    required String phoneNumber,
    required String whatsappImo,
    required String passportNo,
    required String birthCertificateNumber,
    required String presentNationality,
  }) async {
    final dioService = serviceLocator<DioService>();
    final apiEndpoints = serviceLocator<ApiEndpoints>();

    final Map<String, dynamic> data = {
      "first_name_english": firstNameEnglish,
      "last_name_english": lastNameEnglish,
      "gender": gender,
      "birth_date": birthDate,
      "father": father,
      "mother": mother,
      "address": address,
      "email": email,
      "phone_number": phoneNumber,
      "whatsapp_imo": whatsappImo,
      "passport_no": passportNo,
      "birth_certificate_number": birthCertificateNumber,
      "present_nationality": presentNationality,
    };

    final Response res = await dioService.postRequest(
      apiEndpoints.vaccineCardRequest,
      data: data,
      errorMessage: Messages.vaccineCardRequestFailed,
    );

    if (res.statusCode == 200 || res.statusCode == 201) {
      return true;
    } else {
      throw Exception(Messages.vaccineCardRequestFailed);
    }
  }
}
