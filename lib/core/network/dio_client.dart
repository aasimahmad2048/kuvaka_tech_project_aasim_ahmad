import 'package:dio/dio.dart';
import 'package:riverpod_full_architecture/core/core_constants/app_config.dart';

class DioClient {
  static final Dio _dio = Dio(
    BaseOptions(
      // Use AppConfig for consistency and better abstraction
      baseUrl: AppConfig.apiBaseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    ),
  );

  static Dio get instance => _dio;
}
