class PracticeQuestionModel {
  final String questionId;
  final bool isCorrect;
  final DateTime beginTimeStamp;
  final DateTime endTimeStamp;
  final int attemptCount;
  final int timeTaken;
  final List<String> incorrectAnswers;

  PracticeQuestionModel({
    required this.questionId,
    required this.isCorrect,
    required this.beginTimeStamp,
    required this.endTimeStamp,
    required this.attemptCount,
    required this.timeTaken,
    required this.incorrectAnswers

  });

  factory PracticeQuestionModel.fromJson(Map<String, dynamic> json) {
    return PracticeQuestionModel(
      questionId: json['questionId'],
      isCorrect: json['isCorrect'],
      beginTimeStamp: DateTime.parse(json['beginTimeStamp']),
      endTimeStamp: DateTime.parse(json['endTimeStamp']),
      attemptCount: json['attemptAcount'],
      timeTaken: json['timeTaken'],
        incorrectAnswers: json['incorrectAnswers'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'questionId': questionId,
      'isCorrect': isCorrect,
      'beginTimeStamp': beginTimeStamp.toIso8601String(),
      'endTimeStamp': endTimeStamp.toIso8601String(),
      'attemptCount': attemptCount,
      'timeTaken': timeTaken,
      'incorrectAnswers': incorrectAnswers
    };
  }
}