import 'package:dio/dio.dart';
import 'package:heron/core/utils/app_logger.dart';

class LogInterceptorWrapper extends Interceptor {

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    appLogger.i("[REQUEST] => URL: ${options.uri} | METHOD: ${options.method} | DATA: ${options.data}");
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    appLogger.i("[RESPONSE] => CODE: ${response.statusCode} | DATA: ${response.data}");
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    appLogger.e("[ERROR] => ${err.message} | URL: ${err.requestOptions.uri}");
    super.onError(err, handler);
  }
}