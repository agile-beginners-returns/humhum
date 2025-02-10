import 'package:flutter/material.dart';

class TestScreen extends StatelessWidget {
  final String articleUrl;

  const TestScreen({super.key, required this.articleUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Test Screen"),
      ),
      body: Center(
        child: Text(
          "記事URL: $articleUrl",
          style: const TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
