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
      questionId: json['questionId'] ?? 'unknown',
      isCorrect: json['isCorrect'] ?? false,
      beginTimeStamp: json['beginTimeStamp'] != null
          ? DateTime.parse(json['beginTimeStamp'])
          : DateTime.now(),
      endTimeStamp: json['endTimeStamp'] != null
          ? DateTime.parse(json['endTimeStamp'])
          : DateTime.now(),
      attemptCount: json['attemptAcount'] ?? 0,
      timeTaken: json['timeTaken'] ?? 0,
      incorrectAnswers: (json['incorrectAnswers'] != null && json['incorrectAnswers'] is List)
          ? List<String>.from(json['incorrectAnswers'])
          : [],
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