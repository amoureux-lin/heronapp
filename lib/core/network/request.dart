import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../config/app_config.dart';
import '../storage/local_storage.dart';
import '../utils/app_logger.dart';
import 'address.dart';
import 'result_data.dart';
import 'interceptors/header_interceptor.dart';
import 'interceptors/log_interceptor.dart';
import 'interceptors/error_interceptor.dart';

class Request {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: AppConfig.baseUrl,
    connectTimeout: const Duration(seconds: AppConfig.connectTimeout),
    receiveTimeout: const Duration(seconds: AppConfig.receiveTimeout),
    contentType: AppConfig.contentType,
  ))..interceptors.addAll([
    HeaderInterceptor(),
    LogInterceptorWrapper(),
    ErrorInterceptorWrapper(),
  ]);

  Future<ResultData<T>> get<T>(String path, {Map<String, dynamic>? params, Map<String, dynamic>? extra}) async {
    try {
      final response = await _dio.get(path, queryParameters: params, options: Options(extra: extra));
      return ResultData<T>(
        data: response.data,
        code: response.statusCode ?? -1,
        message: "Success",
        success: true,
      );
    } catch (e) {
      return _handleError<T>(e);
    }
  }

  Future<ResultData<T>> post<T>(String path, {dynamic data, Map<String, dynamic>? extra}) async {
    try {
      final response = await _dio.post(path, data: data, options: Options(extra: extra));
      return ResultData<T>(
        data: response.data,
        code: response.statusCode ?? -1,
        message: "Success",
        success: true,
      );
    } catch (e) {
      return _handleError<T>(e);
    }
  }

  ResultData<T> _handleError<T>(dynamic error) {
    String message = "Unknown Error";
    if (error is DioException) {
      message = error.message ?? message;
    }
    appLogger.e("Network Error", error: error);
    return ResultData<T>(
      data: null,
      code: -1,
      message: message,
      success: false,
    );
  }

  /// 保存 Token 和过期时间
  Future<void> saveToken(String token, DateTime expiresAt) async {
    await LocalStorage.save("auth_token", token);
    await LocalStorage.save("auth_expires_at", expiresAt.toIso8601String());
  }

  /// 自动续签逻辑：使用本地账号密码登录换取 token
  Future<bool> autoLogin() async {
    final username = await LocalStorage.get("username");
    final password = await LocalStorage.get("password");
    if (username == null || password == null) return false;

    try {
      final response = await _dio.post(Address.loginPath, data: {
        "username": username,
        "password": password,
      });

      final data = response.data;
      if (response.statusCode == 200 && data["token"] != null) {
        final token = data["token"];
        final expiresAt = DateTime.parse(data["expires_at"]);
        await saveToken(token, expiresAt);
        return true;
      }
    } catch (e) {
      appLogger.w("Auto login failed: $e");
    }
    return false;
  }

  /// 获取 Token
  Future<String?> getToken() async {
    return await LocalStorage.get("auth_token");
  }

  /// 判断 Token 是否过期（提前1分钟）
  Future<bool> isTokenExpired() async {
    final expiresStr = await LocalStorage.get("auth_expires_at");
    if (expiresStr == null) return true;
    final expiresAt = DateTime.tryParse(expiresStr);
    if (expiresAt == null) return true;
    return DateTime.now().isAfter(expiresAt.subtract(const Duration(minutes: 1)));
  }

  /// 清除 Token
  Future<void> clearToken() async {
    await LocalStorage.remove("auth_token");
    await LocalStorage.remove("auth_expires_at");
  }

  /// 保存账号密码用于自动登录（可加密）
  Future<void> saveCredentials(String username, String password) async {
    await LocalStorage.save("username", username);
    await LocalStorage.save("password", password);
  }
}
