import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:humhum/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:humhum/models/test_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:humhum/widgets/rank.dart';

class ResultScreen extends ConsumerStatefulWidget {
  final Tests tests;
  final String articleUrl;

  const ResultScreen({
    super.key,
    required this.tests,
    required this.articleUrl,
  });

  @override
  ResultScreenState createState() => ResultScreenState();
}

class ResultScreenState extends ConsumerState<ResultScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    // 単語テストのスコア
    final int wordTestScore = widget.tests.tests
        .where((test) => test.questionType.toString().contains("word"))
        .where((test) => test.answer == test.userAnswer)
        .toList()
        .length;

    // 翻訳テストのスコア
    final int translationTestScore = widget.tests.tests
        .where((test) => test.questionType.toString().contains("translation"))
        .where((test) => test.answer == test.userAnswer)
        .toList()
        .length;

    // 確認テストのスコア
    final int confirmationTestScore = widget.tests.tests
        .where((test) => test.questionType.toString().contains("confirmation"))
        .where((test) => test.answer == test.userAnswer)
        .toList()
        .length;

    // 各テストの合計スコア
    final int totalScore = widget.tests.tests
        .where((test) => test.answer == test.userAnswer)
        .toList()
        .length;

    void returnMainScreen(BuildContext context) async {
      String rank = "C";
      if (totalScore >= 9) {
        rank = "S";
      } else if (totalScore >= 7) {
        rank = "A";
      } else if (totalScore >= 5) {
        rank = "B";
      } else {
        rank = "C";
      }
      // テスト結果をFirestoreに保存
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      // firestoreのtest_resultというコレクションにデータを保存
      try {
        DocumentReference testResultDoc =
            await firestore.collection('test_results').add({
          'rank': rank,
          'correct_answer_rate':
              '${(totalScore / 10 * 100).toStringAsFixed(1)}%',
          'user_id': _auth.currentUser!.uid,
          'exam_date': Timestamp.now(),
          'exam_date_string':
              "${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')}"
        });
        // `tests` サブコレクションに一括追加
        WriteBatch batch = firestore.batch(); // バッチ処理で高速に追加

        for (Test test in widget.tests.tests) {
          DocumentReference testDocRef =
              testResultDoc.collection('tests').doc(); // 自動生成 ID
          batch.set(testDocRef, test.toJson());
        }

        await batch.commit(); // すべてのドキュメントを一括コミット
        print('テストデータをサブコレクションに一括追加しました！');

        // test_resultsのコレクションのドキュメント内にtestsという名前のサブコレクションにwidget.tests.testsのデータを保存

        print('Firestore にデータが保存されました！');
      } catch (e) {
        print('Firestore の保存エラー: $e');
      }

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainScreen()),
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text("結果", style: TextStyle(color: Colors.black)),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 4,
          automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ClayContainer(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: 20,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                  child: Column(
                children: [
                  ResultItem(
                      questionType: QuestionType.word, score: wordTestScore),
                  const Divider(
                    color: Colors.black87,
                  ),
                  ResultItem(
                      questionType: QuestionType.translation,
                      score: translationTestScore),
                  const Divider(
                    color: Colors.black87,
                  ),
                  ResultItem(
                      questionType: QuestionType.confirmation,
                      score: confirmationTestScore),
                  const Divider(color: Colors.black),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: Row(
                      children: [
                        const Text("合計",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        const Spacer(),
                        Text("$totalScore/10",
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  Rank(score: totalScore),
                ],
              )),
            ),
          ),
        ),
        bottomNavigationBar: InkWell(
            onTap: () => returnMainScreen(context),
            child: ClayContainer(
              height: 80,
              color: Theme.of(context).scaffoldBackgroundColor,
              child: const Padding(
                padding: EdgeInsets.only(bottom: 15),
                child: Center(
                    child: Text("ホームに戻る", style: TextStyle(fontSize: 20))),
              ),
            )));
  }
}

class ResultItem extends StatelessWidget {
  final QuestionType questionType;
  final int score;

  const ResultItem(
      {super.key, required this.questionType, required this.score});

  @override
  Widget build(BuildContext context) {
    String title = "";
    int questionCount = 0;

    if (questionType == QuestionType.word) {
      title = "単語問題";
      questionCount = 4;
    } else if (questionType == QuestionType.translation) {
      title = "日本語訳問題";
      questionCount = 4;
    } else if (questionType == QuestionType.confirmation) {
      title = "確認問題";
      questionCount = 2;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          Text(title, style: const TextStyle(fontSize: 18)),
          const Spacer(),
          Text("$score/$questionCount", style: const TextStyle(fontSize: 18)),
        ],
      ),
    );
  }
}
