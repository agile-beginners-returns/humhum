import 'package:flutter/material.dart';

class PrivacySecurityScreen extends StatelessWidget {
  const PrivacySecurityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy & Security',
            style: TextStyle(color: Colors.black)),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ListTile(
            leading: const Icon(Icons.lock),
            title: const Text('Change Password'),
            subtitle: const Text('Update your account password'),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              // Navigate to Change Password screen
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.shield),
            title: const Text('Two-Factor Authentication'),
            subtitle: const Text('Enable additional security'),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              // Navigate to Two-Factor Authentication screen
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.delete),
            title: const Text('Delete Account'),
            subtitle: const Text('Permanently delete your account'),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              // Confirm and handle account deletion
            },
          ),
        ],
      ),
    );
  }
}
