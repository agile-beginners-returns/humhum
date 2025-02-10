import 'package:humhum/widgets/level_bar.dart';
import 'package:flutter/material.dart';
import 'package:humhum/widgets/question_generate_form.dart';
import 'package:humhum/widgets/article_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const LevelBar(),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 4,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              // タイトルとアイコン (後で変更したい)
              Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 80,
                      child: Image.asset('assets/images/humhum_logo.png'),
                    ),
                  ],
                ),
              ),
              // URL入力フォームとボタン
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: QuestionGenerateForm(),
              ),
              // 記事リスト
              const Expanded(
                child: ArticleList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
