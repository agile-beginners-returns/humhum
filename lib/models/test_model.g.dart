// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tests _$TestsFromJson(Map<String, dynamic> json) => Tests(
      tests: (json['tests'] as List<dynamic>)
          .map((e) => Test.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
    );

Map<String, dynamic> _$TestsToJson(Tests instance) => <String, dynamic>{
      'tests': instance.tests,
    };

Test _$TestFromJson(Map<String, dynamic> json) => Test(
      questionType: json['questionType'] as String,
      question: json['question'] as String,
      choices:
          (json['choices'] as List<dynamic>).map((e) => e as String).toList(),
      answer: (json['answer'] as num?)?.toInt(),
      userAnswer: (json['userAnswer'] as num?)?.toInt(),
      otherMeanings: json['otherMeanings'] as String?,
      example: json['example'] as String?,
      content: json['content'] as String?,
    );

Map<String, dynamic> _$TestToJson(Test instance) => <String, dynamic>{
      'questionType': instance.questionType,
      'question': instance.question,
      'choices': instance.choices,
      'answer': instance.answer,
      'userAnswer': instance.userAnswer,
      'otherMeanings': instance.otherMeanings,
      'example': instance.example,
      'content': instance.content,
    };
