import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:fluentui_emoji_icon/fluentui_emoji_icon.dart';

class Rank extends StatelessWidget {
  final int score;

  const Rank({
    super.key,
    required this.score,
  });

  @override
  Widget build(BuildContext context) {
    FluentData emoji = Fluents.flBalloon;
    String rank = "C";

    if (score >= 9) {
      emoji = Fluents.flTrophy;
      rank = "S";
    } else if (score >= 7) {
      emoji = Fluents.flSportsMedal;
      rank = "A";
    } else if (score >= 5) {
      emoji = Fluents.flPartyPopper;
      rank = "B";
    } else {
      emoji = Fluents.flBalloon;
      rank = "C";
    }

    return Center(
      child: Align(
        alignment: Alignment.centerRight,
        child: ClayContainer(
          color: Colors.yellow[60],
          borderRadius: 10,
          width: 200,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(children: [
              FluentUiEmojiIcon(
                fl: emoji,
                w: 50,
                h: 50,
              ),
              const SizedBox(width: 20),
              Text("Rank $rank", style: const TextStyle(fontSize: 30)),
            ]),
          ),
        ),
      ),
    );
  }
}
