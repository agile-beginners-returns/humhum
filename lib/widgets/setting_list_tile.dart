import 'package:flutter/material.dart';
import 'package:fluentui_emoji_icon/fluentui_emoji_icon.dart';

class SettingListTile extends StatelessWidget {
  final FluentUiEmojiIcon leading;
  final String title;
  final String subtitle;
  final Function onTap;

  const SettingListTile(
      {super.key,
      required this.leading,
      required this.title,
      required this.subtitle,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: leading,
      title: Text(title,
          style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 12.0)),
      onTap: () {
        onTap();
      },
    );
  }
}
