import 'package:flutter/material.dart';

/// 各項目の棒グラフ表示用ウィジェット
class PercentageBar extends StatelessWidget {
  final double percentage; // 0.0 ～ 100.0
  final Color color;
  final String label;

  const PercentageBar({
    super.key,
    required this.percentage,
    required this.color,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    const double maxBarWidth = 210;
    final double barWidth = maxBarWidth * (percentage / 100.0);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          // ラベル部分
          Expanded(
            child: Text(
              label,
              style: const TextStyle(color: Colors.black),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 8),
          // 棒グラフ部分
          Container(
            width: maxBarWidth,
            height: 20,
            decoration: BoxDecoration(
              color: Colors.orange.shade100,
              borderRadius: BorderRadius.circular(7),
            ),
            child: Stack(
              children: [
                Container(
                  width: barWidth,
                  height: 20,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          // パーセンテージ表示部分
          SizedBox(
            width: 50,
            child: Text(
              '${percentage.toStringAsFixed(1)}%',
              style: const TextStyle(color: Colors.black),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
