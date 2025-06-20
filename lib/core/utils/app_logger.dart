// lib/utils/app_logger.dart
import 'package:logger/logger.dart';
import 'package:flutter/foundation.dart'; // 导入 kReleaseMode, kDebugMode

/// 全局的 Logger 实例，方便在应用各处使用
final Logger appLogger = Logger(
  printer: PrettyPrinter(
    methodCount: 0, // 显示调用栈的层数
    errorMethodCount: 8, // 显示错误时调用栈的层数
    lineLength: 0, // 每行最大长度
    colors: false, // 是否彩色打印
    printEmojis: true, // 是否打印表情符号
    dateTimeFormat: DateTimeFormat.none, // 显示小时:分钟:秒
    excludeBox: {
      Level.debug: true,   // debug 级别不显示框
      Level.info: true,     // info 级别不显示框
      Level.warning: true, // warning 级别不显示框
      Level.error: true,   // error 级别不显示框
      Level.fatal: true,   // fatal 级别不显示框
    },
  ),
  filter: MyLogFilter(), // 使用自定义的过滤器
);

// 自定义日志过滤器：在发布模式下只输出警告及以上级别的日志
class MyLogFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) {
    if (kReleaseMode) {
      // 在发布模式下，只打印 Warning, Error, WTF 级别的日志
      return event.level.index >= Level.warning.index;
    } else {
      // 在调试模式下，打印所有级别的日志
      // return true;
      return event.level.index >= Level.debug.index;
    }
  }
}