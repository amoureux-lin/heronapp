import 'package:dio/dio.dart';
import 'package:heron/core/config/app_config.dart';
import '../../storage/local_storage.dart';
import '../request.dart';

class HeaderInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {

    // ✅ 若明确标记跳过认证，直接放行
    if (options.extra['auth'] != null && options.extra['auth'] == false) {
      return super.onRequest(options, handler);
    }

    final token = await LocalStorage.get("auth_token");
    final expiresStr = await LocalStorage.get("auth_expires_at");
    final isExpiring = () {
      if (expiresStr == null) return true;
      final expiresAt = DateTime.tryParse(expiresStr);
      if (expiresAt == null) return true;
      return DateTime.now().isAfter(expiresAt.subtract(const Duration(minutes: 1)));
    }();

    if ((token == null || token.isEmpty || isExpiring)) {
      final request = Request();
      final refreshed = await request.autoLogin();
      if (!refreshed) {
        return handler.reject(DioException(
          requestOptions: options,
          type: DioExceptionType.cancel,
          error: "Token 过期 自动登录 失败",
        ));
      }
    }

    final newToken = await LocalStorage.get("auth_token");
    if (newToken != null) {
      options.headers["Authorization"] = "Bearer $newToken";
    }

    options.headers["Accept"] = AppConfig.contentType;
    super.onRequest(options, handler);
  }
}