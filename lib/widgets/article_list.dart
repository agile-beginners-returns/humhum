import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:humhum/utils/navigation_utils.dart';
import 'package:humhum/widgets/article_card.dart';
import 'package:http/http.dart' as http;

class ArticleList extends StatefulWidget {
  const ArticleList({super.key});

  @override
  ArticleListState createState() => ArticleListState();
}

class ArticleListState extends State<ArticleList> {
  late Future<List<Map<String, dynamic>>> futureArticles;

  @override
  void initState() {
    super.initState();
    futureArticles = fetchArticles();
  }

  /// dev.to の API から記事を取得する関数
  /// per_page パラメータで記事を10件取得します
  Future<List<Map<String, dynamic>>> fetchArticles() async {
    final url = Uri.parse('https://dev.to/api/articles?per_page=10');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      // 各要素は Map<String, dynamic> として扱えるため、cast を利用して変換
      return jsonList.cast<Map<String, dynamic>>();
    } else {
      throw Exception('記事の取得に失敗しました (${response.statusCode})');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: futureArticles,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // データ取得中はプログレスインジケーターを表示
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          // エラー時はエラーメッセージを表示
          return Center(child: Text('エラー: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          // 取得データが空の場合の表示
          return const Center(child: Text('記事が見つかりませんでした'));
        } else {
          final articles = snapshot.data!;
          return GridView.builder(
            padding: const EdgeInsets.only(top: 12.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              // 縦横比を調整して表示が崩れないようにする
              childAspectRatio: 1.0,
            ),
            itemCount: articles.length,
            itemBuilder: (context, index) {
              return ArticleCard(
                article: articles[index],
                onTap: () {
                  toWordTestScreen(context, articles[index]["url"]);
                },
              );
            },
          );
        }
      },
    );
  }
}
