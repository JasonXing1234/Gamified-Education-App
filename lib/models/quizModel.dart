import 'package:quiz/models/quizQuestionModel.dart';

class QuizModel {
  final String quizId;
  final int quizScore;
  final List<QuizQuestionModel> questions;

  QuizModel({
    required this.quizId,
    required this.quizScore,
    required this.questions,
  });

  factory QuizModel.fromJson(Map<String, dynamic> json) {
    return QuizModel(
      quizId: json['quizId'],
      quizScore: json['quizScore'],
      questions: (json['questions'] as List)
          .map((e) => QuizQuestionModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'quizId': quizId,
      'quizScore': quizScore,
      'questions': questions.map((q) => q.toJson()).toList(),
    };
  }
}