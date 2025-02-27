import 'quizQuestionModel.dart';

class QuizAttemptModel {
  final int? attemptId; // Unique ID for each attempt
  final String quizId;
  late final int quizScore;
  final DateTime attemptTimestamp;
  final List<QuizQuestionModel> questions; // Questions for this attempt

  QuizAttemptModel({
    this.attemptId,
    required this.quizId,
    required this.quizScore,
    required this.attemptTimestamp,
    required this.questions,
  });

  factory QuizAttemptModel.fromJson(Map<String, dynamic> json) {
    return QuizAttemptModel(
      attemptId: json['attemptId'],
      quizId: json['quizId'],
      quizScore: json['quizScore'],
      attemptTimestamp: DateTime.parse(json['attemptTimestamp']),
      questions: (json['questions'] as List)
          .map((q) => QuizQuestionModel.fromJson(q))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'attemptId': attemptId,
      'quizId': quizId,
      'quizScore': quizScore,
      'attemptTimestamp': attemptTimestamp.toIso8601String(),
      'questions': questions.map((q) => q.toJson()).toList(),
    };
  }
}