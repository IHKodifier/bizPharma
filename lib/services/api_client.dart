import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/foundation.dart';
import '../config/api_config.dart';

class ApiClient {
  final Dio _dio;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseAppCheck _appCheck = FirebaseAppCheck.instance;

  ApiClient()
    : _dio = Dio(
        BaseOptions(
          baseUrl: ApiConfig.baseUrl,
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
        ),
      ) {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Get Firebase ID Token
          final user = _auth.currentUser;
          if (user != null) {
            final token = await user.getIdToken();
            if (token != null && token.isNotEmpty) {
              options.headers['Authorization'] = 'Bearer $token';
            }
          }

          // Get and add AppCheck token
          if (!kDebugMode) {
            try {
              final appCheckToken = await _appCheck.getToken();
              if (appCheckToken != null) {
                options.headers['X-Firebase-AppCheck'] = appCheckToken;
              }
            } catch (e) {
              print('ApiClient: AppCheck token failed (Expected in Dev): $e');
            }
          } else {
            // In debug mode, we can add a mock header or skip it
            options.headers['X-Firebase-AppCheck-Debug'] = 'true';
          }

          return handler.next(options);
        },
        onError: (DioException e, handler) {
          // Global error handling
          print('API Error: ${e.response?.statusCode} - ${e.message}');
          if (e.response?.data != null) {
            print('Error Data: ${e.response?.data}');
          }
          return handler.next(e);
        },
      ),
    );
  }

  // Generic GET
  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    return await _dio.get(path, queryParameters: queryParameters);
  }

  // Generic POST
  Future<Response> post(String path, {dynamic data}) async {
    return await _dio.post(path, data: data);
  }

  // Generic PUT
  Future<Response> put(String path, {dynamic data}) async {
    return await _dio.put(path, data: data);
  }

  // Generic DELETE
  Future<Response> delete(String path) async {
    return await _dio.delete(path);
  }
}
