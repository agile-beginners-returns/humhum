import 'package:flutter/material.dart';
import 'package:fluentui_emoji_icon/fluentui_emoji_icon.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTabTapped;

  const BottomNavBar(
      {super.key, required this.currentIndex, required this.onTabTapped});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      currentIndex: currentIndex,
      onTap: onTabTapped,
      selectedItemColor: Colors.orange,
      unselectedItemColor: Colors.grey,
      items: const [
        BottomNavigationBarItem(
          icon: FluentUiEmojiIcon(fl: Fluents.flHouse, w: 30, h: 30),
          activeIcon: FluentUiEmojiIcon(fl: Fluents.flHouse, w: 30, h: 30),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: FluentUiEmojiIcon(fl: Fluents.flBooks, w: 30, h: 30),
          activeIcon: FluentUiEmojiIcon(fl: Fluents.flBooks, w: 30, h: 30),
          label: 'History',
        ),
        BottomNavigationBarItem(
          icon: FluentUiEmojiIcon(fl: Fluents.flBarChart, w: 30, h: 30),
          activeIcon: FluentUiEmojiIcon(fl: Fluents.flBarChart, w: 30, h: 30),
          label: 'Report',
        ),
        BottomNavigationBarItem(
          icon: FluentUiEmojiIcon(fl: Fluents.flGear, w: 30, h: 30),
          activeIcon: FluentUiEmojiIcon(fl: Fluents.flGear, w: 30, h: 30),
          label: 'Settings',
        ),
      ],
    );
  }
}
