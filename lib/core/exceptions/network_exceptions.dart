import 'package:dio/dio.dart';

class NetworkExceptions {
  static String handleDioError(DioException e) {
    if (e.response != null) {
      return e.response?.data['message'] ?? 'Unexpected server error';
    } else if (e.type == DioExceptionType.connectionError) {
      return 'No Internet connection';
    } else {
      return 'Something went wrong';
    }
  }
}
