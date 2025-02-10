import 'package:humhum/widgets/report_screen/report_container.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:humhum/widgets/report_screen/report_title.dart';
import 'package:humhum/widgets/report_screen/aggregated_data.dart';

/// テストレポート画面
class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  /// Firestore からログイン中ユーザーのテスト結果を集計する処理
  Future<AggregatedData> fetchAggregatedData() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception('ログインしていません');
    }

    // ユーザーの test_results コレクションからデータを取得
    final QuerySnapshot testResultsSnapshot = await FirebaseFirestore.instance
        .collection('test_results')
        .where('user_id', isEqualTo: user.uid)
        .get();

    int totalCorrect = 0;
    int totalCount = 0;

    // 各問題タイプごとのカウンター
    Map<String, int> typeCorrect = {
      'word': 0,
      'translation': 0,
      'confirmation': 0,
    };
    Map<String, int> typeTotal = {
      'word': 0,
      'translation': 0,
      'confirmation': 0,
    };

    // 取得した各テスト結果ドキュメントについて、サブコレクション tests 内の各問題を集計
    for (final testResultDoc in testResultsSnapshot.docs) {
      final QuerySnapshot testsSnapshot =
          await testResultDoc.reference.collection('tests').get();

      for (final testDoc in testsSnapshot.docs) {
        final String questionType = testDoc['questionType'];
        final dynamic answer = testDoc['answer'];
        final dynamic userAnswer = testDoc['userAnswer'];
        final bool isCorrect = answer == userAnswer;

        typeTotal[questionType] = (typeTotal[questionType] ?? 0) + 1;
        if (isCorrect) {
          typeCorrect[questionType] = (typeCorrect[questionType] ?? 0) + 1;
        }
        totalCount++;
        if (isCorrect) totalCorrect++;
      }
    }

    double overallPercentage =
        totalCount > 0 ? (totalCorrect / totalCount * 100.0) : 0.0;

    Map<String, double> typePercentage = {};
    for (final key in typeTotal.keys) {
      final int total = typeTotal[key] ?? 0;
      final int correct = typeCorrect[key] ?? 0;
      typePercentage[key] = total > 0 ? (correct / total * 100.0) : 0.0;
    }

    return AggregatedData(
      overallPercentage: overallPercentage,
      typePercentage: typePercentage,
    );
  }

  @override
  Widget build(BuildContext context) {
    // ログイン中のユーザーIDを取得
    final User? user = FirebaseAuth.instance.currentUser;
    final String userId = user?.uid ?? '';

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('テストレポート'),
        foregroundColor: Colors.black,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: FutureBuilder<AggregatedData>(
        future: fetchAggregatedData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
                child:
                    Text('エラーが発生しました', style: TextStyle(color: Colors.black)));
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final AggregatedData data = snapshot.data!;

          const String wordLabel = '単語';
          const String translationLabel = '日本語訳';
          const String confirmationLabel = '確認';

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 全体の正答率表示
                const ReportTitle(title: '全体の正答率'),
                ReportContainer(
                  percentage: data.overallPercentage,
                  isOverall: true,
                  userId: userId,
                  questionType: '全問題',
                ),
                // 問題タイプ別の正答率表示
                const ReportTitle(title: '問題タイプ別の正答率'),
                const SizedBox(height: 16),
                // 単語問題
                ReportContainer(
                    percentage: data.typePercentage['word'] ?? 0.0,
                    isOverall: false,
                    userId: userId,
                    questionType: wordLabel),
                const SizedBox(height: 16),
                // 日本語訳問題
                ReportContainer(
                  percentage: data.typePercentage['translation'] ?? 0.0,
                  isOverall: false,
                  userId: userId,
                  questionType: translationLabel,
                ),
                const SizedBox(height: 16),
                // 確認問題
                ReportContainer(
                  percentage: data.typePercentage['confirmation'] ?? 0.0,
                  isOverall: false,
                  userId: userId,
                  questionType: confirmationLabel,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
