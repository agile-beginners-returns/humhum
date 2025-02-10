import 'package:flutter/material.dart';
import 'package:humhum/screens/settings/account_screen.dart';
import 'package:humhum/screens/settings/notification_screen.dart';
import 'package:humhum/screens/settings/privacy_security_screen.dart';
import 'package:humhum/screens/settings/about_screen.dart';
import 'package:humhum/widgets/setting_list_tile.dart';
import 'package:fluentui_emoji_icon/fluentui_emoji_icon.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings', style: TextStyle(color: Colors.black)),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            SettingListTile(
                leading: const FluentUiEmojiIcon(
                    fl: Fluents.flHuggingFace, w: 40, h: 40),
                title: "Account",
                subtitle: "Manage your account settings",
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AccountScreen()));
                }),
            const Divider(
              color: Colors.black87,
            ),
            SettingListTile(
                leading:
                    const FluentUiEmojiIcon(fl: Fluents.flBell, w: 40, h: 40),
                title: "Notification",
                subtitle: "Adjust your notification settings",
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const NotificationScreen()));
                }),
            const Divider(
              color: Colors.black87,
            ),
            SettingListTile(
                leading:
                    const FluentUiEmojiIcon(fl: Fluents.flLocked, w: 40, h: 40),
                title: "Privacy & Security",
                subtitle: "Control your privacy settings",
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PrivacySecurityScreen()));
                }),
            const Divider(
              color: Colors.black87,
            ),
            SettingListTile(
                leading: const FluentUiEmojiIcon(
                    fl: Fluents.flInformation, w: 40, h: 40),
                title: "About",
                subtitle: "Learn more about the app",
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AboutScreen()));
                }),
          ],
        ),
      ),
    );
  }
}
