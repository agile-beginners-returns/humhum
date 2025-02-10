import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              strokeWidth: 5,
              color: Colors.grey.shade600,
            ),
            const SizedBox(height: 20),
            Text(
              "AIが問題を生成中...",
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey.shade800,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
