import 'package:freezed_annotation/freezed_annotation.dart';
part 'test_model.g.dart';

enum QuestionType { word, translation, confirmation }

@JsonSerializable()
class Tests {
  List<Test> tests; // 型を変更

  Tests({required this.tests});

  factory Tests.fromJson(Map<String, dynamic> json) => _$TestsFromJson(json);

  Map<String, dynamic> toJson() => _$TestsToJson(this);
}

@JsonSerializable()
class Test {
  final String questionType;
  final String question;
  final List<String> choices;
  int? answer;
  int? userAnswer;
  final String? otherMeanings;
  final String? example;
  final String? content;

  Test({
    required this.questionType,
    required this.question,
    required this.choices,
    this.answer,
    this.userAnswer,
    this.otherMeanings,
    this.example,
    this.content,
  });

  factory Test.fromJson(Map<String, dynamic> json) => _$TestFromJson(json);
  Map<String, dynamic> toJson() => _$TestToJson(this);
}
