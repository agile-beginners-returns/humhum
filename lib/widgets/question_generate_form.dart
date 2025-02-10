import 'package:flutter/material.dart';
import 'package:humhum/utils/navigation_utils.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:fluentui_emoji_icon/fluentui_emoji_icon.dart';

class QuestionGenerateForm extends StatelessWidget {
  QuestionGenerateForm({super.key});
  final TextEditingController articleUrlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 250,
        child: Column(
          children: [
            Expanded(
              child: ClayContainer(
                  emboss: true,
                  borderRadius: 25,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                    child: SizedBox(
                      height: 200.0, // お好みの高さに変更
                      child: TextFormField(
                        controller: articleUrlController,
                        maxLines: null,
                        decoration: const InputDecoration(
                          hintText:
                              '問題を生成したい記事のURL\nor\n学習したい内容を入力\n\n例）Flutterの学習をしたい。特に基本的なウィジェットの作り方について知りたい。',
                          hintMaxLines: null,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  )),
            ),
            const SizedBox(height: 13),
            SizedBox(
              width: double.infinity, // 横幅を画面いっぱいに広げる
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange, // ボタンの色をオレンジに設定
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14), // 縦の余白を調整
                ),
                onPressed: () =>
                    toWordTestScreen(context, articleUrlController.text),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "問題を生成",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 8),
                    FluentUiEmojiIcon(fl: Fluents.flRocket, w: 40, h: 40),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
