import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

enum IconType {
  correct,
  incorrect,
}

class AnswerButton extends StatelessWidget {
  const AnswerButton(
      {super.key, required this.title, this.selectedAnswer, this.iconType});

  final String title;
  final void Function()? selectedAnswer;
  final IconType? iconType;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: ClayContainer(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: 10,
          child: InkWell(
            onTap: selectedAnswer,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 15.0), // 縦方向の余白を追加
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Stack(
                  children: [
                    (iconType == null)
                        ? const SizedBox()
                        : (iconType == IconType.correct)
                            ? const Icon(Icons.radio_button_off_outlined,
                                size: 25, color: Colors.green)
                            : const Icon(Icons.close,
                                size: 25, color: Colors.red),
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0),
                      child: AutoSizeText(
                        title,
                        maxLines: 3,
                        style: const TextStyle(fontSize: 18),
                        minFontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
