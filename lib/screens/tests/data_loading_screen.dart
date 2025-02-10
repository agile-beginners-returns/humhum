import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:humhum/screens/tests/test_screen.dart';
import 'package:humhum/widgets/loading.dart';
import 'package:humhum/models/test_model.dart';
import 'package:humhum/api/google_cloud.dart';

class DataLoadingScreen extends ConsumerWidget {
  final String articleUrl;

  const DataLoadingScreen({super.key, required this.articleUrl});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final response = ref
        .watch(jsonStateNotifierProvider.notifier)
        .callCloudFunctionsAPI(articleUrl);

    return FutureBuilder<Map<String, dynamic>?>(
      future: response,
      builder: (context, snapshot) {
        // ローディング画面表示
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: Loading());
        }

        // エラー処理
        if (snapshot.hasError) {
          return Center(child: Text('エラーが発生しました: ${snapshot.error}'));
        }

        // データがない場合
        if (!snapshot.hasData || snapshot.data == null) {
          return const Center(child: Text('データが存在しません'));
        }

        print(snapshot.data!);

        // データ取得が成功した場合
        final tests =
            Tests.fromJson(snapshot.data!["results"].cast<String, dynamic>());
        // 問題順をひっくり返す
        tests.tests = tests.tests.reversed.toList();

        // 選択肢をシャッフル
        for (int i = 0; i < tests.tests.length; i++) {
          final firstElement = tests.tests[i].choices.first;
          tests.tests[i].choices.shuffle();
          tests.tests[i].answer = tests.tests[i].choices.indexOf(firstElement);
        }

        // snapshotに"article"が含まれている場合は、記事を取得
        String article = "";
        if (snapshot.data!.containsKey("article")) {
          article = snapshot.data!["article"];
        }

        // 質問リスト画面に遷移
        Future.microtask(() {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => TestScreen(
                tests: tests,
                articleUrl: articleUrl,
                article: article,
              ),
            ),
          );
        });

        return Container(); // ここでは表示しない
      },
    );
  }
}
