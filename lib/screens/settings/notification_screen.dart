import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  NotificationScreenState createState() => NotificationScreenState();
}

class NotificationScreenState extends State<NotificationScreen> {
  bool _pushNotifications = true;
  bool _emailNotifications = false;
  bool _notificationSound = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification Settings',
            style: TextStyle(color: Colors.black)),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          SwitchListTile(
            title: const Text('Push Notifications'),
            subtitle: const Text('Receive push notifications from the app'),
            value: _pushNotifications,
            onChanged: (bool value) {
              setState(() {
                _pushNotifications = value;
              });
            },
          ),
          const Divider(),
          SwitchListTile(
            title: const Text('Email Notifications'),
            subtitle: const Text('Receive notifications via email'),
            value: _emailNotifications,
            onChanged: (bool value) {
              setState(() {
                _emailNotifications = value;
              });
            },
          ),
          const Divider(),
          SwitchListTile(
            title: const Text('Notification Sound'),
            subtitle: const Text('Enable sound for notifications'),
            value: _notificationSound,
            onChanged: (bool value) {
              setState(() {
                _notificationSound = value;
              });
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Advanced Settings'),
            subtitle: const Text('Customize notification preferences'),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              // Navigate to Advanced Notification settings screen
            },
          ),
        ],
      ),
    );
  }
}
