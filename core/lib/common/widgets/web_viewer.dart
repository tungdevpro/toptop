import 'package:core/core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebViewer extends StatefulWidget {
  final String url;
  final VoidCallback? onRedirect;
  const WebViewer(this.url, {super.key, this.onRedirect});

  @override
  State<WebViewer> createState() => _WebViewerState();
}

class _WebViewerState extends State<WebViewer> {
  InAppWebViewController? inAppWebViewController;

  void checkDirect() async {
    if (inAppWebViewController != null) {
      if (await inAppWebViewController?.canGoBack() == true) {
        canBackNotifier.value = true;
      } else {
        canBackNotifier.value = false;
      }

      if (await inAppWebViewController?.canGoForward() == true) {
        canNextNotifier.value = true;
      } else {
        canNextNotifier.value = false;
      }
    }
  }

  ValueNotifier<bool> canBackNotifier = ValueNotifier(false);
  ValueNotifier<bool> canNextNotifier = ValueNotifier(false);

  @override
  void dispose() {
    canBackNotifier.dispose();
    canNextNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              // height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(iconSize: 20, icon: const Icon(Icons.close), onPressed: _onClose),
                  ValueListenableBuilder<bool>(
                    valueListenable: canBackNotifier,
                    builder: (context, canBack, child) => IconButton(
                        iconSize: 20,
                        icon: Icon(
                          Icons.arrow_back_ios_rounded,
                          color: canBack ? Colors.black : Colors.grey,
                        ),
                        onPressed: canBack ? inAppWebViewController?.goBack : null),
                  ),
                  ValueListenableBuilder<bool>(
                    valueListenable: canNextNotifier,
                    builder: (context, canNext, child) => IconButton(
                        iconSize: 20,
                        icon: Icon(
                          Icons.arrow_forward_ios_sharp,
                          color: canNext ? Colors.black : Colors.grey,
                        ),
                        onPressed: canNext ? inAppWebViewController?.goForward : null),
                  ),
                  IconButton(
                      iconSize: 20,
                      icon: const Icon(Icons.refresh),
                      onPressed: () {
                        if (inAppWebViewController != null) {
                          inAppWebViewController!.reload();
                          inAppWebViewController!.scrollTo(x: 0, y: 0);
                        }
                      }),
                  IconButton(iconSize: 20, icon: const Icon(Icons.more_vert), onPressed: _onClickOption),
                ],
              ),
            ),
            Expanded(
              child: InAppWebView(
                  onReceivedServerTrustAuthRequest: (controller, url) async => ServerTrustAuthResponse(action: ServerTrustAuthResponseAction.PROCEED),
                  onLoadStart: _onLoadStart,
                  onLoadStop: _onLoadStop,
                  gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{}
                    ..add(Factory<VerticalDragGestureRecognizer>(() => VerticalDragGestureRecognizer())),
                  initialUrlRequest: URLRequest(
                    url: WebUri(widget.url),
                  ),
                  onUpdateVisitedHistory: (controller, url, androidIsReload) {}),
            ),
          ],
        ),
      ),
    );
  }

  void _onLoadStart(InAppWebViewController controller, WebUri? url) {
    inAppWebViewController = controller;
    checkDirect();
  }

  void _onLoadStop(InAppWebViewController controller, WebUri? url) {
    checkDirect();
  }

  void _onClose() => Navigator.of(context).pop();

  void _onClickOption() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12))),
      builder: (context) {
        return SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                onTap: _onOpenInBrower,
                leading: const Icon(Icons.open_in_browser),
                title: const Text("Mở với trình duyệt"),
              ),
              ListTile(
                onTap: () => Navigator.of(context).pop(),
                leading: const Icon(Icons.close),
                title: const Text("Đóng"),
              ),
            ],
          ),
        );
      },
    );
  }

  void _onOpenInBrower() {
    CoreUtils.launchInBrowser(widget.url);
  }
}
