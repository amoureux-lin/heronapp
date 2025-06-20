import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heron/core/config/app_config.dart';
import 'package:heron/core/utils/app_logger.dart';

import 'app.dart';
import 'core/network/api.dart';
import 'core/utils/AppUtil.dart';



void main() async {
  //确保 Flutter Widgets 库已经绑定并初始化
  WidgetsFlutterBinding.ensureInitialized();
  //配置初始化
  AppConfig.initialize();

  final uuid = await AppUtil.getDeviceUUID();
  appLogger.i("当前设备ID:$uuid");

  // final container = ProviderContainer();
  // final api = container.read(apiProvider);
  //
  // final configResult = await api.getConfig({'env': 'prod'});
  // if (configResult.success) {
  //   print('启动配置：${configResult.data}');
  //   // 可缓存 config，注入全局配置等
  // } else {
  //   print('获取配置失败：${configResult.message}');
  // }

  //运行
  runApp(const ProviderScope(
      child: MyApp())
  );
}
