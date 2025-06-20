import 'package:flutter/foundation.dart'; // 导入 kReleaseMode, kDebugMode 等常量
import '../utils/app_logger.dart';

class AppConfig {
  static late final String baseUrl;
  static late final String apiKey;
  static late final String environment; // "development" 或 "production"

  /// 初始化应用配置
  static void initialize() {
    if (kReleaseMode) {
      // 发布模式 (flutter build --release 或 flutter run --release)
      baseUrl = 'https://api.yourcompany.com/prod/v1';
      apiKey = 'prod_api_key_xyz';
      environment = 'production';
    } else if (kDebugMode) {
      // 调试模式 (flutter run)
      baseUrl = 'http://192.168.1.100:8080/dev/v1'; // 示例：本地开发服务器地址
      apiKey = 'dev_api_key_123';
      environment = 'development';
    } else { // kProfileMode 等
      baseUrl = 'http://192.168.1.100:8080/profile/v1'; // 示例：分析模式地址
      apiKey = 'profile_api_key_xyz';
      environment = 'profile';
    }

    // 打印加载的配置详情
    appLogger.i('【App配置信息】');
    appLogger.d('  【App Environment】: $environment');
    appLogger.d('  【App Base URL】: $baseUrl');
    appLogger.d('  【App API Key】: $apiKey'); // 警告：敏感信息不应直接打印到生产日志中

    // 你也可以在这里加入一些错误处理，并用 logger.e 记录
    try {
      if (baseUrl.isEmpty) {
        throw Exception('Base URL is empty!');
      }
    } catch (e, s) {
      appLogger.e('Error during AppConfig initialization', error: e, stackTrace: s);
    }
  }

  // 你也可以为其他配置添加静态属性
  static const String appDisplayName = 'My App';
  static const int connectTimeout = 10; // 秒
  static const int receiveTimeout = 15; // 秒
  // application/json    application/x-www-form-urlencoded    multipart/form-data    text/plain     application/xml
  static const String contentType = "application/json";

}