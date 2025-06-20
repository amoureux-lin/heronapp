import 'package:dio/dio.dart';
import 'package:heron/core/utils/app_logger.dart';
import 'package:logger/logger.dart';

import '../code.dart';

class ErrorInterceptorWrapper extends Interceptor {

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == Code.UNAUTHORIZED) {
      appLogger.w("[ERROR] Unauthorized. Should redirect to login");
      // TODO: Implement navigation to login page
    } else if (err.response?.statusCode == Code.SERVER_ERROR) {
      appLogger.w("[ERROR] Server internal error");
    }
    super.onError(err, handler);
  }
}