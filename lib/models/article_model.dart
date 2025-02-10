// lib/models/article.dart

import 'package:freezed_annotation/freezed_annotation.dart';

part 'article_model.freezed.dart';
part 'article_model.g.dart';

@freezed
class Article with _$Article {
  const factory Article({
    /// 記事のタイトル
    required String title,

    /// 記事の説明
    required String description,

    /// 記事の URL
    required String url,

    /// カバー画像の URL (dev.to API の JSON では "cover_image" というキー名)
    required String? coverImage,
  }) = _Article;

  /// JSON からの変換
  factory Article.fromJson(Map<String, dynamic> json) =>
      _$ArticleFromJson(json);
}
