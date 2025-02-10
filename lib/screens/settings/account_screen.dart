import 'package:humhum/main.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AccountScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final User? user = _auth.currentUser;

    if (user == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Account Settings',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: const Center(child: Text('No user logged in')),
      );
    }

    // プロバイダを判別
    final bool isGoogleLogin = user.providerData.any(
      (info) => info.providerId == 'google.com',
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Account Settings',
            style: TextStyle(color: Colors.black)),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Googleログインの場合、Googleプロフィール情報を表示
          if (isGoogleLogin) ...[
            ListTile(
              leading: user.photoURL != null
                  ? CircleAvatar(
                      backgroundImage: NetworkImage(user.photoURL!),
                    )
                  : const CircleAvatar(
                      child: Icon(Icons.person),
                    ),
              title: Text(user.displayName ?? 'No name set'),
              subtitle: const Text('Logged in via Google'),
            ),
          ],
          // 通常の表示（Googleログインでない場合も表示）
          ListTile(
            leading: const Icon(Icons.email),
            title: const Text('Email'),
            subtitle: Text(user.email ?? 'No email set'),
            trailing: isGoogleLogin ? null : const Icon(Icons.edit),
            onTap: isGoogleLogin ? null : () => _editEmail(context),
          ),
          if (!isGoogleLogin) ...[
            const Divider(),
            ListTile(
              leading: const Icon(Icons.lock),
              title: const Text('Change Password'),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () => _changePassword(context),
            ),
          ],
          const Divider(),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Logout'),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () => _logout(context),
          ),
        ],
      ),
    );
  }

  Future<void> _editEmail(BuildContext context) async {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final User? user = _auth.currentUser;

    if (user == null) {
      _showErrorDialog(context, 'No user logged in.');
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Email'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(hintText: 'Enter new email'),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: passwordController,
              decoration:
                  const InputDecoration(hintText: 'Enter current password'),
              obscureText: true,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () async {
              if (emailController.text.isEmpty ||
                  passwordController.text.isEmpty) {
                _showErrorDialog(context, 'Please fill out all fields.');
                return;
              }

              try {
                final credential = EmailAuthProvider.credential(
                  email: user.email ?? '',
                  password: passwordController.text,
                );
                await user.reauthenticateWithCredential(credential);

                final String newEmail = emailController.text.trim();
                await _sendVerificationEmail(newEmail);

                _showSuccessDialog(
                  context,
                  'A verification email has been sent to $newEmail. Please verify it and then retry updating your email.',
                );
                Navigator.pop(context);
              } catch (e) {
                _showErrorDialog(context, 'Error: ${e.toString()}');
              }
            },
            child: const Text('Send Verification'),
          ),
        ],
      ),
    );
  }

  Future<void> _sendVerificationEmail(String newEmail) async {
    try {
      await _auth.currentUser?.verifyBeforeUpdateEmail(newEmail);
    } catch (e) {
      throw Exception('Failed to send verification email: $e');
    }
  }

  Future<void> _changePassword(BuildContext context) async {
    final TextEditingController passwordController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Change Password'),
        content: TextField(
          controller: passwordController,
          decoration: const InputDecoration(hintText: 'Enter new password'),
          obscureText: true,
        ),
        actions: [
          TextButton(
            onPressed: () async {
              if (passwordController.text.isNotEmpty) {
                final User? user = _auth.currentUser;
                if (user != null) {
                  await user.updatePassword(passwordController.text);
                  Navigator.pop(context);
                }
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _logout(BuildContext context) async {
    await _auth.signOut();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const AuthWrapper()),
      (route) => false,
    );
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showSuccessDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Success'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
