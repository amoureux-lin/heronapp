import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

/// Controller Provider（用于跨组件访问）
final webViewControllerProvider = StateProvider<InAppWebViewController?>((ref) => null);
final webViewUrlProvider = StateProvider<String>((ref) => 'http://192.168.1.19:8080');
final webViewProgressProvider = StateProvider<double>((ref) => 0);

class GameScreen extends ConsumerStatefulWidget {
  const GameScreen({super.key});

  @override
  ConsumerState<GameScreen> createState() => _InAppWebViewScreenState();
}

class _InAppWebViewScreenState extends ConsumerState<GameScreen> {
  final GlobalKey webViewKey = GlobalKey();
  final urlController = TextEditingController();
  late final PullToRefreshController? pullToRefreshController;

  final InAppWebViewSettings settings = InAppWebViewSettings(
    isInspectable: kDebugMode,
    mediaPlaybackRequiresUserGesture: false,
    allowsInlineMediaPlayback: true,
    iframeAllow: "camera; microphone",
    iframeAllowFullscreen: true,
  );

  @override
  void initState() {
    super.initState();

    pullToRefreshController = kIsWeb ||
        ![TargetPlatform.iOS, TargetPlatform.android].contains(defaultTargetPlatform)
        ? null
        : PullToRefreshController(
      settings: PullToRefreshSettings(color: Colors.blue),
      onRefresh: () async {
        final controller = ref.read(webViewControllerProvider);
        if (defaultTargetPlatform == TargetPlatform.android) {
          controller?.reload();
        } else if (defaultTargetPlatform == TargetPlatform.iOS) {
          final url = await controller?.getUrl();
          if (url != null) {
            controller?.loadUrl(urlRequest: URLRequest(url: url));
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentUrl = ref.watch(webViewUrlProvider);
    final progress = ref.watch(webViewProgressProvider);

    return Scaffold(
      // appBar: AppBar(title: const Text("InAppWebView")),
      body: SafeArea(
        child: Stack(
          children: [
            InAppWebView(
              key: webViewKey,
              initialSettings: settings,
              initialUrlRequest: URLRequest(url: WebUri(currentUrl)),
              pullToRefreshController: pullToRefreshController,
              onWebViewCreated: (controller) {
                ref.read(webViewControllerProvider.notifier).state = controller;
              },
              onLoadStart: (controller, url) {
                ref.read(webViewUrlProvider.notifier).state = url.toString();
                urlController.text = url.toString();
              },

              shouldOverrideUrlLoading: (controller, action) async {
                final uri = action.request.url!;
                if (!["http", "https", "file", "chrome", "data", "javascript", "about"]
                    .contains(uri.scheme)) {

                }
                return NavigationActionPolicy.ALLOW;
              },
              onLoadStop: (controller, url) {
                pullToRefreshController?.endRefreshing();
                ref.read(webViewUrlProvider.notifier).state = url.toString();
                urlController.text = url.toString();
              },
              onReceivedError: (controller, request, error) {
                pullToRefreshController?.endRefreshing();
              },
              onProgressChanged: (controller, progressValue) {
                ref.read(webViewProgressProvider.notifier).state = progressValue / 100.0;
              },
              onUpdateVisitedHistory: (controller, url, _) {
                ref.read(webViewUrlProvider.notifier).state = url.toString();
                urlController.text = url.toString();
              },
              onConsoleMessage: (controller, consoleMessage) {
                debugPrint(consoleMessage.message);
              },
            ),
            if (progress < 1.0)
              LinearProgressIndicator(value: progress)
            else
              const SizedBox.shrink(),
            Positioned(
              top: 12,
              right: 12,
              child: PointerInterceptor(child: GestureDetector(
                onTap: () => context.pop(),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.close, color: Colors.white, size: 18),
                      SizedBox(width: 4),
                      Text('退出', style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
              ),)
              ,
            ),
          ],
        ),
      ),
    );
  }
}
