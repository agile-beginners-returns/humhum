import 'package:flutter/material.dart';

BoxDecoration neumorphicDecoration({
  Color color = const Color(0xFFE0E5EC), // 背景色
  double borderRadius = 16.0,
  Offset lightOffset = const Offset(-4, -4),
  Offset darkOffset = const Offset(4, 4),
  double blurRadius = 8.0,
}) {
  return BoxDecoration(
    color: color,
    borderRadius: BorderRadius.circular(borderRadius),
    boxShadow: [
      // 明るい影
      BoxShadow(
        color: Colors.white,
        offset: lightOffset,
        blurRadius: blurRadius,
      ),
      // 暗い影
      BoxShadow(
        color: const Color(0xFFB3B8C2),
        offset: darkOffset,
        blurRadius: blurRadius,
      ),
    ],
  );
}
