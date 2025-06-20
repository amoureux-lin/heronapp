@JS()
library web_utils;

import 'package:web/web.dart' hide Text, Navigator;
import 'package:crypto/crypto.dart';
import 'dart:js_interop';
import 'dart:convert';
import 'dart:typed_data';

Future<String> getWebFingerprint() async {
  final canvas = HTMLCanvasElement();
  canvas.width = 200;
  canvas.height = 50;

  final ctx = canvas.getContext('2d') as CanvasRenderingContext2D;

  ctx.font = "14px Arial";
  ctx.fillStyle = '#f60'.toJS;
  ctx.fillRect(125, 1, 62, 20);
  ctx.fillStyle = '#069'.toJS;
  ctx.fillText('flutter-fingerprint', 2, 15);
  ctx.fillStyle = 'rgba(102, 204, 0, 0.7)'.toJS;
  ctx.fillText('flutter-fingerprint', 4, 17);

  final imageData = ctx.getImageData(0, 0, canvas.width!, canvas.height!);
  final bytes = Uint8List.fromList(imageData.data.toDart);

  final ua = window.navigator.userAgent ?? '';
  final lang = window.navigator.language ?? '';
  final resolution = '${window.screen?.width}x${window.screen?.height}';
  final timezone = DateTime.now().timeZoneOffset.inMinutes.toString();

  final buffer = <int>[]
    ..addAll(utf8.encode('$ua|$lang|$resolution|$timezone'))
    ..addAll(bytes);

  return sha256.convert(buffer).toString();
}
