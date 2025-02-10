import 'package:flutter/material.dart';
import 'package:humhum/screens/tests/data_loading_screen.dart';

void toWordTestScreen(BuildContext context, String articleUrl) {
  // 入力が空の場合は何もしない
  if (articleUrl.isEmpty) {
    return;
  }

  // TestScreenに遷移
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
        builder: (context) => DataLoadingScreen(articleUrl: articleUrl)),
  );
}
