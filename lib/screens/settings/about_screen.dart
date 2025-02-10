import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color baseColor = Colors.white;
    const Color accentColor = Colors.orange;

    return Scaffold(
      backgroundColor: baseColor,
      appBar: AppBar(
        title: const Text(
          'About',
          style: TextStyle(
            color: Colors.orange,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: baseColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.orange),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
            child: Column(
              children: [
                // アプリ名
                const Text(
                  'HumHum',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: accentColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),

                // アプリ紹介をカードでまとめる
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  elevation: 2,
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // アプリ説明の見出し
                        Text(
                          'アプリ説明',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: accentColor,
                          ),
                        ),
                        SizedBox(height: 12),
                        // アプリ説明の本文
                        Text(
                          '【目的】\nエンジニアに向けた英語学習アプリ\n\n'
                          '【概要】\nこれは、英語で書かれたIT技術記事などのURLを入力することで、生成AIが自動で記事に関連する英語問題を作成してくれます。\n\n'
                          '問題文は、記事の重要な内容をもとにして作成されるため、英文を読んでいるだけで記事の内容を把握することができる構成になっています。\n'
                          '英語の学習と技術の勉強を同時に行うことが可能です。',
                          style: TextStyle(
                            fontSize: 16,
                            height: 1.6,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // 開発者情報をカードでまとめる
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 開発者の見出し
                        const Text(
                          '開発者',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: accentColor,
                          ),
                        ),
                        const SizedBox(height: 12),
                        // 開発者一覧
                        _buildDeveloperRow('ak-nagae', accentColor),
                        _buildDeveloperRow('Kota Hisafuru', accentColor),
                        _buildDeveloperRow('Fujiwara', accentColor),
                        _buildDeveloperRow('Kohei Omikawa', accentColor),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// 開発者名を行で表示するウィジェット
  Widget _buildDeveloperRow(String name, Color accentColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Icon(
            Icons.person,
            color: accentColor,
          ),
          const SizedBox(width: 8),
          Text(
            name,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
