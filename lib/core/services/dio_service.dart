import 'dart:io';
import 'package:dio/dio.dart';
import 'package:vaccine_home/core/services/app_preferences.dart';

class DioService {
  final Dio _dio;

  DioService({String? baseUrl})
      : _dio = Dio(
          BaseOptions(
            baseUrl: baseUrl ?? "https://vcard.vaccinehomebd.com/api/",
            connectTimeout: const Duration(seconds: 15),
            receiveTimeout: const Duration(seconds: 15),
            headers: {
              "Content-Type": "application/json",
              "Accept": "application/json",
            },
          ),
        ) {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          print("➡️ [${options.method}] ${options.uri}");
          if (options.data != null) print("📦 Body: ${options.data}");
          if (options.queryParameters.isNotEmpty) {
            print("🔍 Query: ${options.queryParameters}");
          }
          return handler.next(options);
        },
        onResponse: (response, handler) {
          print("✅ Response [${response.statusCode}]: ${response.data}");
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          print("❌ Dio Error: ${e.message}");
          return handler.next(e);
        },
      ),
    );
  }

  /// Call this after creating instance to load token from SharedPreferences
  Future<void> initAuthToken() async {
    final token = await AppPreferences.getAccessToken();
    if (token.isNotEmpty) {
      setAuthToken(token);
    }
  }

  /// Set Bearer Token (e.g., after login)
  void setAuthToken(String token) {
    _dio.options.headers["Authorization"] = "Bearer $token";
  }

  /// Clear Token (e.g., on logout)
  void clearAuthToken() {
    _dio.options.headers.remove("Authorization");
  }

  /// GET Request
  Future<Response> getRequest(
    String endpoint, {
    String? errorMessage,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await _dio.get(endpoint, queryParameters: queryParameters);
    } on DioException catch (e) {
      throw Exception(errorMessage ?? "⚠️ Network error: ${e.message}");
    }
  }

  /// POST Request
  Future<Response> postRequest(
    String endpoint, {
    dynamic data,
    String? errorMessage,
  }) async {
    try {
      return await _dio.post(endpoint, data: data);
    } on DioException catch (e) {
      throw Exception(errorMessage ?? "⚠️ Network error: ${e.message}");
    }
  }

  /// PUT Request
  Future<Response> putRequest(
    String endpoint, {
    dynamic data,
    String? errorMessage,
  }) async {
    try {
      return await _dio.put(endpoint, data: data);
    } on DioException catch (e) {
      throw Exception(errorMessage ?? "⚠️ Network error: ${e.message}");
    }
  }

  /// DELETE Request
  Future<Response> deleteRequest(
    String endpoint, {
    dynamic data,
    String? errorMessage,
  }) async {
    try {
      return await _dio.delete(endpoint, data: data);
    } on DioException catch (e) {
      throw Exception(errorMessage ?? "⚠️ Network error: ${e.message}");
    }
  }

  /// Multipart Request
  Future<Response> postMultipart(
    String endpoint, {
    required File file,
    required String fileFieldName,
    Map<String, dynamic>? data,
    String? errorMessage,
  }) async {
    try {
      final formData = FormData.fromMap({
        ...?data,
        fileFieldName: await MultipartFile.fromFile(file.path,
            filename: file.path.split('/').last),
      });

      return await _dio.post(endpoint, data: formData);
    } on DioException catch (e) {
      throw Exception(errorMessage ?? "⚠️ Network error: ${e.message}");
    }
  }
}
