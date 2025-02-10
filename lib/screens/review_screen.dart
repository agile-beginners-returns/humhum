import 'package:flutter/material.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:humhum/widgets/answer_button.dart';
import 'package:humhum/widgets/review_screen/review_question_card.dart';
import 'package:humhum/widgets/review_screen/review_service.dart';

class ReviewScreen extends StatefulWidget {
  final String userId;
  final String reviewQuestionType;

  const ReviewScreen({
    super.key,
    required this.userId,
    required this.reviewQuestionType,
  });

  @override
  ReviewScreenState createState() => ReviewScreenState();
}

class ReviewScreenState extends State<ReviewScreen> {
  List<Map<String, dynamic>> reviewQuestions = [];
  bool isLoading = true;
  int currentIndex = 0;
  bool isAnswered = false;

  @override
  void initState() {
    super.initState();
    _loadReviewQuestions();
  }

  Future<void> _loadReviewQuestions() async {
    final questions = await ReviewService.fetchReviewQuestions(
        widget.userId, widget.reviewQuestionType);
    setState(() {
      reviewQuestions = questions;
      isLoading = false;
    });
  }

  /// 回答処理：選択肢ボタンがタップされたときに userAnswer を記録し、フラグを更新
  void answerQuestion(int answer) {
    if (isAnswered) return;
    setState(() {
      reviewQuestions[currentIndex]['userAnswer'] = answer;
      isAnswered = true;
    });
  }

  /// 次の問題へ進む。最後の問題の場合は完了ダイアログを表示
  void pushNextQuestion() {
    if (currentIndex + 1 >= reviewQuestions.length) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("復習完了"),
          content: const Text("すべての復習問題を確認しました。"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text("OK"),
            ),
          ],
        ),
      );
    } else {
      setState(() {
        currentIndex++;
        isAnswered = false;
      });
    }
  }

  IconType? getIconType(Map<String, dynamic> test, int idx) {
    if (isAnswered) {
      if (test['answer'] == idx) return IconType.correct;
      if (test['userAnswer'] == idx) return IconType.incorrect;
    }
    return null;
  }

  String getReviewTitle() {
    if (widget.reviewQuestionType == "word") return "単語復習";
    if (widget.reviewQuestionType == "translation") return "日本語訳復習";
    if (widget.reviewQuestionType == "confirmation") return "確認復習";
    return "復習";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(getReviewTitle(), style: const TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 4,
        automaticallyImplyLeading: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : reviewQuestions.isEmpty
              ? const Center(
                  child: Text(
                  "復習すべき問題はありません",
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ))
              : Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            ReviewQuestionCard(
                              questionData: reviewQuestions[currentIndex],
                              reviewQuestionType: widget.reviewQuestionType,
                            ),
                            Center(
                              child: isAnswered
                                  ? (reviewQuestions[currentIndex]
                                              ['userAnswer'] ==
                                          reviewQuestions[currentIndex]
                                              ['answer']
                                      ? Icon(Icons.radio_button_off_outlined,
                                          size: 200,
                                          color: Colors.green.withOpacity(0.5))
                                      : Icon(Icons.close,
                                          size: 200,
                                          color: Colors.red.withOpacity(0.5)))
                                  : const SizedBox(height: 0),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        Expanded(
                          child: Scrollbar(
                            child: ListView(
                              children: [
                                for (int i = 0;
                                    i <
                                        (reviewQuestions[currentIndex]
                                                ['choices'] as List<dynamic>)
                                            .length;
                                    i++)
                                  AnswerButton(
                                    title: (reviewQuestions[currentIndex]
                                        ['choices'] as List<dynamic>)[i],
                                    selectedAnswer: () => answerQuestion(i),
                                    iconType: getIconType(
                                        reviewQuestions[currentIndex], i),
                                  ),
                                AnswerButton(
                                  title: "わからない",
                                  selectedAnswer: () => answerQuestion(-1),
                                  iconType: getIconType(
                                      reviewQuestions[currentIndex], -1),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
      bottomNavigationBar: InkWell(
        onTap: pushNextQuestion,
        child: isLoading
            ? const SizedBox()
            : isAnswered
                ? const ClayContainer(
                    height: 80,
                    color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 15),
                      child: Center(
                        child: Text("タップして次へ", style: TextStyle(fontSize: 20)),
                      ),
                    ),
                  )
                : const SizedBox(height: 0),
      ),
    );
  }
}
