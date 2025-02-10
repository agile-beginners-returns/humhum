import 'package:flutter/material.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:humhum/widgets/report_screen/percentage_bar.dart';
import 'package:humhum/screens/review_screen.dart';

class ReportContainer extends StatelessWidget {
  final double percentage;
  final bool isOverall;
  final String userId;
  final String questionType;

  const ReportContainer({
    super.key,
    required this.percentage,
    required this.isOverall,
    required this.userId,
    required this.questionType,
  });

  reviewType() {
    if (questionType == '単語') {
      return 'word';
    } else if (questionType == '翻訳') {
      return 'translation';
    } else if (questionType == '確認') {
      return 'confirmation';
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClayContainer(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: 20,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(height: 8),
              if (isOverall)
                Text(
                  '${percentage.toStringAsFixed(1)}%',
                  style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepOrange),
                ),
              const SizedBox(height: 16),
              PercentageBar(
                percentage: percentage,
                color: Colors.orange.shade700,
                label: questionType,
              ),
              if (!isOverall)
                Column(
                  children: [
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ClayContainer(
                        borderRadius: 15,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange, // 背景色をオレンジに設定
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 24),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          onPressed: () {
                            // 「単語復習」ボタンをタップしたときに、ユーザーIDと questionType を渡して ReviewScreen へ遷移
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ReviewScreen(
                                  userId: userId,
                                  reviewQuestionType: reviewType(),
                                ),
                              ),
                            );
                          },
                          child: Text(
                            '$questionType 復習',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.white, // テキスト色を白に設定
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )
            ],
          ),
        ));
  }
}
