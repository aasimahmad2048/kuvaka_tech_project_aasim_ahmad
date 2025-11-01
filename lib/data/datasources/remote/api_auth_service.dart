import 'package:dio/dio.dart';
import 'package:riverpod_full_architecture/core/network/dio_client.dart';
import 'package:riverpod_full_architecture/core/routes/api_routes.dart';
import 'package:riverpod_full_architecture/core/exceptions/network_exceptions.dart';

class ApiAuthService {
  final Dio _dio = DioClient.instance;

  /// Logs in the user and returns user data
  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final res = await _dio.post(
        ApiRoutes.login,
        data: {'email': email, 'password': password},
      );
      return res.data['user'] ?? res.data;
    } on DioException catch (e) {
      throw NetworkExceptions.handleDioError(e);
    }
  }

  /// Registers a new user
  Future<Map<String, dynamic>> register(
      String email, String password, String name) async {
    try {
      final res = await _dio.post(
        ApiRoutes.register,
        data: {'email': email, 'password': password, 'name': name},
      );
      return res.data['user'] ?? res.data;
    } on DioException catch (e) {
      throw NetworkExceptions.handleDioError(e);
    }
  }

  /// Logs out the current user
  Future<void> logout() async {
    try {
      await _dio.post(ApiRoutes.logout);
    } on DioException catch (e) {
      throw NetworkExceptions.handleDioError(e);
    }
  }
}
