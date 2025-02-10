import 'package:flutter/material.dart';
import 'package:clay_containers/clay_containers.dart';

class ReviewQuestionCard extends StatelessWidget {
  final Map<String, dynamic> questionData;
  final String reviewQuestionType;

  const ReviewQuestionCard({
    super.key,
    required this.questionData,
    required this.reviewQuestionType,
  });

  List<Widget> _buildQuestionWidgets() {
    List<Widget> widgets = [];
    if (reviewQuestionType == "word") {
      widgets.add(const Padding(
        padding: EdgeInsets.symmetric(vertical: 23),
        child: Text("Q. 以下の単語の意味として\n最も適切なものを選びなさい"),
      ));
      widgets.add(Text(questionData['question'] ?? "",
          style: const TextStyle(fontSize: 30), textAlign: TextAlign.center));
    } else if (reviewQuestionType == "translation") {
      widgets.add(const Padding(
        padding: EdgeInsets.symmetric(vertical: 21),
        child: Text("Q. 以下の英文を日本語に直したものとして\n最も適切なものを選びなさい"),
      ));
      widgets.add(Text(questionData['question'] ?? "",
          style: const TextStyle(fontSize: 16), textAlign: TextAlign.center));
    } else if (reviewQuestionType == "confirmation") {
      widgets.add(const Padding(
        padding: EdgeInsets.symmetric(vertical: 23),
        child: Text("Q. 以下の単語の意味として\n最も適切なものを選びなさい"),
      ));
      widgets.add(Text(questionData['question'] ?? "",
          style: const TextStyle(fontSize: 16), textAlign: TextAlign.center));
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return ClayContainer(
      color: Colors.white,
      width: double.infinity,
      height: 200,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: _buildQuestionWidgets(),
        ),
      ),
    );
  }
}
