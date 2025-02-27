import 'PracticeQuestionModel.dart';

class PracticeAttemptModel {
  final int attemptId;
  final List<PracticeQuestionModel> questions;

  PracticeAttemptModel({
    required this.attemptId,
    required this.questions,
  });

  factory PracticeAttemptModel.fromJson(Map<String, dynamic> json) {
    return PracticeAttemptModel(
      attemptId: json['attemptId'],
      questions: (json['questions'] as List)
          .map((e) => PracticeQuestionModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'attemptId': attemptId,
      'questions': questions.map((q) => q.toJson()).toList(),
    };
  }
}