

import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';
import 'package:heron/theme/CusStyle.dart';
import 'package:universal_platform/universal_platform.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import '../../localization/l10n/app_localizations.dart';
import 'web/WebUtils.dart';

class AppUtil{
  /// 获取设备唯一ID
  static Future<String> getDeviceUUID() async {
    final deviceInfo = DeviceInfoPlugin();
    if (UniversalPlatform.isAndroid) {
      final deviceInfo = DeviceInfoPlugin();
      final androidInfo = await deviceInfo.androidInfo;
      final hash = sha256.convert(utf8.encode(androidInfo.id)).toString();
      return hash;
      // return androidInfo.id ?? 'unknown-android-id';
    } else if (UniversalPlatform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      return iosInfo.identifierForVendor ?? 'unknown_ios_id';
    } else if (UniversalPlatform.isWeb) {
      final uuid = await getWebFingerprint();
      return uuid;
    } else {
      return 'unsupported';
    }
  }



  static List<Color> getThemeListColor() {
    return [
      CusStyle.primarySwatch,
      Colors.brown,
      Colors.blue,
      Colors.teal,
      Colors.amber,
      Colors.blueGrey,
      Colors.deepOrange,
    ];
  }

  static ThemeData getThemeData(Color color) {
    return ThemeData(
      useMaterial3: false,

      ///用来适配 Theme.of(context).primaryColorLight 和 primaryColorDark 的颜色变化，不设置可能会是默认蓝色
      primarySwatch: color as MaterialColor,

      /// Card 在 M3 下，会有 apply Overlay

      colorScheme: ColorScheme.fromSeed(
        seedColor: color,
        primary: color,

        brightness: Brightness.light,

        ///影响 card 的表色，因为 M3 下是  applySurfaceTint ，在 Material 里
        surfaceTint: Colors.transparent,
      ),

      /// 受到 iconThemeData.isConcrete 的印象，需要全参数才不会进入 fallback
      iconTheme: const IconThemeData(
        size: 24.0,
        fill: 0.0,
        weight: 400.0,
        grade: 0.0,
        opticalSize: 48.0,
        color: Colors.white,
        opacity: 0.8,
      ),

      ///修改 FloatingActionButton的默认主题行为
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          foregroundColor: Colors.white,
          backgroundColor: color,
          shape: const CircleBorder()),
      appBarTheme: AppBarTheme(
        iconTheme: const IconThemeData(
          color: Colors.white,
          size: 24.0,
        ),
        backgroundColor: color,
        titleTextStyle: Typography.dense2021.titleLarge,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),

      // 如果需要去除对应的水波纹效果
      // splashFactory: NoSplash.splashFactory,
      // textButtonTheme: TextButtonThemeData(
      //   style: ButtonStyle(splashFactory: NoSplash.splashFactory),
      // ),
      // elevatedButtonTheme: ElevatedButtonThemeData(
      //   style: ButtonStyle(splashFactory: NoSplash.splashFactory),
      // ),
    );
  }




  /// ✅ 显示确认弹窗，返回 true / false
  static Future<bool> showConfirm(
      BuildContext context, {
        String? title,
        String? content,
        String? cancelText,
        String? confirmText,
      }) async {
    final l10n = AppLocalizations.of(context)!;

    final result = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title ?? ""),
        content: Text(content ?? ""),
        actions: [
          TextButton(
            onPressed: () => closeDialog(context, result: false),
            child: Text(cancelText ?? ""),
          ),
          ElevatedButton(
            onPressed: () => closeDialog(context, result: true),
            child: Text(confirmText ?? ""),
          ),
        ],
      ),
    );

    return result == true;
  }

  /// ✅ 显示普通提示弹窗（无返回值）
  static Future<void> showAlert(
      BuildContext context, {
        required String title,
        required String content,
        String? confirmText,
        VoidCallback? onConfirm,
      }) async {
    final l10n = AppLocalizations.of(context)!;

    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          ElevatedButton(
            onPressed: () {
              closeDialog(context);
              Future.microtask(() => onConfirm?.call());
            },
            child: Text(confirmText ?? ""),
          ),
        ],
      ),
    );
  }

  /// ✅ 显示 SnackBar
  static void showSnackbar(
      BuildContext context,
      String message, {
        Duration duration = const Duration(seconds: 2),
        Color? backgroundColor,
      }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration,
        backgroundColor: backgroundColor,
      ),
    );
  }

  /// ✅ 显示 Loading 遮罩
  static void showLoading(BuildContext context, {String? text}) {
    final l10n = AppLocalizations.of(context)!;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => WillPopScope(
        onWillPop: () async => false,
        child: Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(width: 16),
                Text(text ?? ""),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// ✅ 安全关闭 Dialog 或 Loading（防止 pop 报错或白屏）
  static void closeDialog(BuildContext context, {dynamic result}) {
    Navigator.of(context, rootNavigator: true).pop(result);
  }

}

