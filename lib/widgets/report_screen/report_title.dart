import 'package:flutter/material.dart';

class ReportTitle extends StatelessWidget {
  final String title;

  const ReportTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 15.0),
      child: Text(
        '全体の正答率',
        style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
      ),
    );
  }
}
