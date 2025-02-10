import 'package:humhum/screens/tests/result_screen.dart';
import 'package:humhum/widgets/markdown_viewer.dart';
import 'package:humhum/widgets/webpage_modal.dart';
import 'package:flutter/material.dart';
import 'package:humhum/models/test_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:humhum/widgets/answer_button.dart';
import 'package:fluentui_emoji_icon/fluentui_emoji_icon.dart';

const int WORD_TEST_END = 4;
const int TRANSLATION_TEST_END = 8;
const int CONFIRMATION_TEST_END = 10;

class TestScreen extends ConsumerStatefulWidget {
  final Tests tests;
  final String articleUrl;
  final String? article;

  const TestScreen(
      {super.key, required this.tests, required this.articleUrl, this.article});

  @override
  TestScreenState createState() => TestScreenState();
}

class TestScreenState extends ConsumerState<TestScreen> {
  bool isAnswered = false;
  int userAnswer = -1;
  int questionNumber = 0;

  @override
  Widget build(BuildContext context) {
    final test = widget.tests.tests[questionNumber];

    void pushTestScreen(BuildContext context) {
      if (questionNumber + 1 >= widget.tests.tests.length) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ResultScreen(
                tests: widget.tests, articleUrl: widget.articleUrl),
          ),
        );
        return;
      }
      setState(() {
        questionNumber++;
        isAnswered = false;
      });
    }

    void answerQuestion(int answer) {
      if (isAnswered) {
        return;
      }
      setState(() {
        widget.tests.tests[questionNumber].userAnswer = answer;
        isAnswered = true;
      });
    }

    String getTestTitle(int questionNumber) {
      // questionNumberが0から3までの間は単語テスト
      // questionNumberが4から7までの間は翻訳テスト
      // questionNumberが8から9までの間は確認テスト

      if (questionNumber < WORD_TEST_END) {
        return "No.${questionNumber + 1} 単語テスト";
      } else if (questionNumber < TRANSLATION_TEST_END) {
        return "No.${questionNumber + 1} 翻訳テスト";
      } else if (questionNumber < CONFIRMATION_TEST_END) {
        return "No.${questionNumber + 1} 確認テスト";
      } else {
        return "";
      }
    }

    List<Widget> getQuestion() {
      List<Widget> question = [];
      if (questionNumber < WORD_TEST_END) {
        question.add(const Padding(
          padding: EdgeInsets.symmetric(vertical: 23),
          child: Text("Q. 以下の単語の意味として\n最も適切なものを選びなさい"),
        ));
        question.add(Text(test.question, style: const TextStyle(fontSize: 30)));
      } else if (questionNumber < TRANSLATION_TEST_END) {
        question.add(const Padding(
          padding: EdgeInsets.symmetric(vertical: 21),
          child: Text("Q. 以下の英文を日本語に直したものとして\n最も適切なものを選びなさい"),
        ));
        question.add(Text(test.question, style: const TextStyle(fontSize: 16)));
      } else if (questionNumber < CONFIRMATION_TEST_END) {
        question.add(const Padding(
          padding: EdgeInsets.symmetric(vertical: 23),
          child: Text("Q. 以下の単語の意味として\n最も適切なものを選びなさい"),
        ));
        question.add(Text(test.question, style: const TextStyle(fontSize: 16)));
      }
      return question;
    }

    IconType? getIconType(int idx) {
      if (isAnswered) {
        if (test.answer == idx) {
          return IconType.correct;
        } else if (test.userAnswer == idx) {
          return IconType.incorrect;
        } else {
          return null;
        }
      } else {
        return null;
      }
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(getTestTitle(questionNumber),
              style: const TextStyle(color: Colors.black)),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 4,
          automaticallyImplyLeading: false,
          actions: <Widget>[
            IconButton(
              icon: const FluentUiEmojiIcon(
                fl: Fluents.flOpenBook,
                w: 60,
                h: 60,
              ),
              onPressed: () async {
                await showModalBottomSheet<void>(
                    context: context,
                    backgroundColor: Colors.transparent,
                    isScrollControlled: true,
                    enableDrag: true,
                    barrierColor: Colors.black.withOpacity(0.5),
                    builder: (context) {
                      // articleがnullの場合はWebViewを表示
                      if (widget.article == null || widget.article == "") {
                        return SinglePageWebView(url: widget.articleUrl);
                      } else {
                        return MarkdownViewer(markdownContent: widget.article!);
                      }
                    });
              },
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              children: [
                Stack(
                  children: [
                    ClayContainer(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: 10,
                        width: double.infinity,
                        // height: 200,
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(
                            minHeight: 200, // 最小の高さを 80 に設定
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: getQuestion()),
                          ),
                        )),
                    Center(
                      child: (isAnswered)
                          ? ((test.userAnswer == test.answer)
                              ? Icon(Icons.radio_button_off_outlined,
                                  size: 200,
                                  color: Colors.green.withOpacity(0.5))
                              : Icon(Icons.close,
                                  size: 200,
                                  color: Colors.red.withOpacity(0.5)))
                          : const SizedBox(height: 0),
                    )
                  ],
                ),
                const SizedBox(height: 30.0),
                Expanded(
                    child: Scrollbar(
                  child: ListView(
                    children: [
                      for (int choiceIdx = 0;
                          choiceIdx < test.choices.length;
                          choiceIdx++)
                        AnswerButton(
                            title: test.choices[choiceIdx],
                            selectedAnswer: () => answerQuestion(choiceIdx),
                            iconType: getIconType(choiceIdx)),
                      AnswerButton(
                          title: "わからない",
                          selectedAnswer: () => answerQuestion(-1),
                          iconType: getIconType(-1)),
                    ],
                  ),
                ))
              ],
            ),
          ),
        ),
        bottomNavigationBar: InkWell(
          onTap: () => pushTestScreen(context),
          child: (isAnswered)
              ? ClayContainer(
                  height: 80,
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: const Padding(
                    padding: EdgeInsets.only(bottom: 15),
                    child: Center(
                        child: Text("タップして次へ", style: TextStyle(fontSize: 20))),
                  ))
              : const SizedBox(height: 0),
        ));
  }
}
