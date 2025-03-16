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
      attemptId: json['attemptId'] ?? 0,
      questions: (json['questions'] != null && json['questions'] is List)
          ? (json['questions'] as List)
          .where((e) => e != null)
          .map((e) => PracticeQuestionModel.fromJson(Map<String, dynamic>.from(e)))
          .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'attemptId': attemptId,
      'questions': questions.map((q) => q.toJson()).toList(),
    };
  }
}