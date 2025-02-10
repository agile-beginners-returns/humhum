/// 集計結果を保持するクラス
class AggregatedData {
  final double overallPercentage;
  final Map<String, double> typePercentage;

  AggregatedData({
    required this.overallPercentage,
    required this.typePercentage,
  });
}
