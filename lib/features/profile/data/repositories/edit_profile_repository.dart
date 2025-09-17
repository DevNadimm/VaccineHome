import 'dart:io';
import 'package:dio/dio.dart';
import 'package:vaccine_home/core/constants/api_endpoints.dart';
import 'package:vaccine_home/core/constants/messages.dart';
import 'package:vaccine_home/core/services/app_preferences.dart';
import 'package:vaccine_home/core/services/dio_service.dart';
import 'package:vaccine_home/core/services/service_locator.dart';
import 'package:vaccine_home/features/profile/data/models/edit_profile_model.dart';

class EditProfileRepository {
  static Future<EditProfileModel> editProfile({
    required String name,
    required String email,
    required String phone,
    String? gender,
    String? dateOfBirth,
    String? address,
    File? avatar,
  }) async {
    final dioService = serviceLocator<DioService>();
    final apiEndpoints = serviceLocator<ApiEndpoints>();

    final Map<String, dynamic> data = {
      '_method': 'PUT',
      'name': name,
      'email': email,
      'phone': phone,
      if (gender != null) 'gender': gender.toLowerCase(),
      if (dateOfBirth != null) 'date_of_birth': dateOfBirth,
      if (address != null) 'address': address,
    };

    late final Response res;

    if (avatar != null) {
      res = await dioService.postMultipart(
        apiEndpoints.editProfile,
        file: avatar,
        fileFieldName: 'avatar',
        data: data,
      );
    } else {
      res = await dioService.putRequest(apiEndpoints.editProfile, data: data);
    }

    if (res.statusCode == 200 || res.statusCode == 201) {
      final model = EditProfileModel.fromJson(res.data);

      // Update app preferences if available
      if (model.data?.name != null) await AppPreferences.setUserName(model.data!.name!);
      if (model.data?.email != null) await AppPreferences.setUserEmail(model.data!.email!);
      if (model.data?.phone != null) await AppPreferences.setUserPhone(model.data!.phone!);
      if (model.data?.avatar != null) await AppPreferences.setUserAvatar(model.data!.avatar!);

      return model;
    } else {
      throw Exception(Messages.editProfileFailed);
    }
  }
}
