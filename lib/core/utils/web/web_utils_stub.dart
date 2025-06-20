// App/桌面平台：返回默认值，防止 dart:js_interop 报错
Future<String> getWebFingerprint() async {
  return 'unsupported-platform';
}
