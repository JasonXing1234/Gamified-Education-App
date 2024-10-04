class QuizQuestionModel {
  final String questionId;
  final bool isCorrect;
  final DateTime beginTimeStamp;
  final DateTime endTimeStamp;

  QuizQuestionModel({
    required this.questionId,
    required this.isCorrect,
    required this.beginTimeStamp,
    required this.endTimeStamp,
  });

  factory QuizQuestionModel.fromJson(Map<String, dynamic> json) {
    return QuizQuestionModel(
      questionId: json['questionId'],
      isCorrect: json['isCorrect'],
      beginTimeStamp: DateTime.parse(json['beginTimeStamp']),
      endTimeStamp: DateTime.parse(json['endTimeStamp']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'questionId': questionId,
      'isCorrect': isCorrect,
      'beginTimeStamp': beginTimeStamp.toIso8601String(),
      'endTimeStamp': endTimeStamp.toIso8601String(),
    };
  }
}