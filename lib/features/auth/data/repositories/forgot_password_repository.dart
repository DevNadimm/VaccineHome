import 'package:vaccine_home/core/constants/api_endpoints.dart';
import 'package:vaccine_home/core/constants/messages.dart';
import 'package:vaccine_home/core/services/dio_service.dart';
import 'package:vaccine_home/core/services/service_locator.dart';

class ForgotPasswordRepository {
  static Future<bool> sendPin({required String email}) async {
    final dioService = serviceLocator<DioService>();
    final apiEndpoints = serviceLocator<ApiEndpoints>();

    final data = {
      "email": email,
    };

    final res = await dioService.postRequest(
      apiEndpoints.sendPin,
      data: data,
      errorMessage: Messages.sendPinFailed,
    );

    if (res.statusCode == 200 || res.statusCode == 201) {
      return true;
    } else {
      throw Exception(res.data['message']);
    }
  }

  static Future<bool> verifyPin({
    required String email,
    required String pin,
  }) async {
    final dioService = serviceLocator<DioService>();
    final apiEndpoints = serviceLocator<ApiEndpoints>();

    final data = {
      "email": email,
      "pin": pin,
    };

    final res = await dioService.postRequest(
      apiEndpoints.verifyPin,
      data: data,
      errorMessage: Messages.verifyPinFailed,
    );

    if (res.statusCode == 200 || res.statusCode == 201) {
      return true;
    } else {
      throw Exception(res.data['message']);
    }
  }

  static Future<bool> setNewPassword({
    required String email,
    required String pin,
    required String password,
    required String confirmPassword,
  }) async {
    final dioService = serviceLocator<DioService>();
    final apiEndpoints = serviceLocator<ApiEndpoints>();

    final data = {
      "email": email,
      "pin": pin,
      "password": password,
      "password_confirmation": confirmPassword,
    };

    final res = await dioService.postRequest(
      apiEndpoints.setNewPassword,
      data: data,
      errorMessage: Messages.setPasswordFailed,
    );

    if (res.statusCode == 200 || res.statusCode == 201) {
      return true;
    } else {
      throw Exception(res.data['message']);
    }
  }
}
