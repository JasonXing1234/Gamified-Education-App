import 'package:quiz/models/quizAttemptModel.dart';

class QuizModel {
  final String quizId;
  final List<QuizAttemptModel> attempts; // Multiple attempts for each quiz

  QuizModel({
    required this.quizId,
    required this.attempts,
  });

  factory QuizModel.fromJson(Map<String, dynamic> json) {
    return QuizModel(
      quizId: json['quizId'],
      attempts: (json['attempts'] as List)
          .map((e) => QuizAttemptModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'quizId': quizId,
      'attempts': attempts.map((a) => a.toJson()).toList(),
    };
  }
}
