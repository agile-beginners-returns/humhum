// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ArticleImpl _$$ArticleImplFromJson(Map<String, dynamic> json) =>
    _$ArticleImpl(
      title: json['title'] as String,
      description: json['description'] as String,
      url: json['url'] as String,
      coverImage: json['coverImage'] as String?,
    );

Map<String, dynamic> _$$ArticleImplToJson(_$ArticleImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'url': instance.url,
      'coverImage': instance.coverImage,
    };
