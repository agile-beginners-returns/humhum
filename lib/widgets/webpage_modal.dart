import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SinglePageWebView extends StatefulWidget {
  final String url;

  const SinglePageWebView({super.key, required this.url});

  @override
  State<SinglePageWebView> createState() => _SinglePageWebViewState();
}

class _SinglePageWebViewState extends State<SinglePageWebView> {
  late final WebViewController _controller;
  String _pageTitle = '';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (request) {
            // 指定URLと完全一致の場合のみ遷移許可
            if (request.url == widget.url) {
              return NavigationDecision.navigate;
            } else {
              return NavigationDecision.prevent;
            }
          },
          onPageFinished: (url) async {
            // ページ読み込み完了時にタイトル取得
            final title = await _controller.getTitle();
            setState(() {
              _pageTitle = title ?? '';
              _isLoading = false;
            });
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  void _reloadPage() {
    setState(() {
      _isLoading = true;
    });
    _controller.loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 64),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 5),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: _reloadPage,
                ),
                Expanded(
                  child: Center(
                    child: _isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Text(
                            _pageTitle,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                  ),
                ),
                const SizedBox(width: 48), // リロードボタンとの左右バランス用空白
              ],
            ),
            Expanded(
              child: WebViewWidget(
                controller: _controller,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
