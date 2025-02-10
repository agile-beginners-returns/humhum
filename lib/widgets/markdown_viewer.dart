import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class MarkdownViewer extends StatefulWidget {
  /// Markdown形式の文字列を受け取ります
  final String markdownContent;

  const MarkdownViewer({super.key, required this.markdownContent});

  @override
  State<MarkdownViewer> createState() => _MarkdownViewerState();
}

class _MarkdownViewerState extends State<MarkdownViewer> {
  String _pageTitle = '';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _extractTitle();
  }

  /// Markdownの先頭にある見出し（# で始まる行）をタイトルとして抽出します
  void _extractTitle() {
    final lines = widget.markdownContent.split('\n');
    for (final line in lines) {
      final trimmed = line.trim();
      if (trimmed.isNotEmpty) {
        if (trimmed.startsWith('#')) {
          // 複数の '#' を除去して、余分な空白も取り除く
          _pageTitle = trimmed.replaceAll(RegExp(r'^#+\s*'), '');
        }
        break;
      }
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Markdown表示用のスタイルシートを定義
    final markdownStyle = MarkdownStyleSheet(
      h1: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
      h2: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
      h3: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
      p: const TextStyle(
        fontSize: 12,
        height: 1.5,
        color: Colors.black87,
      ),
      strong: const TextStyle(fontWeight: FontWeight.w600),
      em: const TextStyle(fontStyle: FontStyle.italic),
      // インラインコードのスタイル
      code: TextStyle(
        fontFamily: 'monospace',
        fontSize: 12,
        color: Colors.deepPurple,
        backgroundColor: Colors.grey.shade200,
      ),
      // コードブロックの装飾
      codeblockDecoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.grey.shade300),
      ),
      codeblockPadding: const EdgeInsets.all(16.0),
      blockquote: const TextStyle(
        color: Colors.grey,
        fontStyle: FontStyle.italic,
      ),
      blockquotePadding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      blockquoteDecoration: BoxDecoration(
        color: Colors.grey.shade100,
        border: const Border(
          left: BorderSide(color: Colors.grey, width: 4),
        ),
      ),
      listBullet: const TextStyle(fontSize: 16, color: Colors.black87),
      horizontalRuleDecoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.grey.shade300, width: 1),
        ),
      ),
    );

    return Container(
      margin: const EdgeInsets.only(top: 64),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          // ヘッダー部分：縦幅を広げ、背景色と下部の境界線を追加
          Container(
            width: double.infinity,
            height: 80, // ヘッダーの縦幅を80に設定（必要に応じて調整してください）
            decoration: BoxDecoration(
              color: Colors.blueGrey.shade50, // ヘッダー専用の背景色
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey.shade300,
                  width: 1,
                ),
              ),
            ),
            child: Center(
              child: _isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(
                      _pageTitle.isNotEmpty ? _pageTitle : 'Markdown Viewer',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
            ),
          ),
          // Markdownの表示部分
          Expanded(
            child: Markdown(
              data: widget.markdownContent,
              padding: const EdgeInsets.all(16),
              styleSheet: markdownStyle,
            ),
          ),
        ],
      ),
    );
  }
}
