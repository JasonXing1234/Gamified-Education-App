// Class for Holding Question Data

class Question {
  Question({
    required this.context,
    required this.question,
    required this.photo,
    required this.answerOptions,
    required this.explanation
  });

  // final String title = ""; // Title for questions will always be empty, but parameter is needed to mix reading pages and questions pages
  String context;
  final String question;
  final List<String> answerOptions;
  final String photo;

  final String explanation;

  List<String> getShuffledAnswers() {
    final shuffledAnswers = List.of(answerOptions);
    shuffledAnswers.shuffle();
    return shuffledAnswers;
  }
}

class SingleAnswerQuestion extends Question {
  SingleAnswerQuestion({
    required super.context,
    required super.question,
    required super.photo,
    required super.answerOptions,
    required super.explanation,
    required this.correctAnswer,
  });


  final String correctAnswer;

}

class MultipleAnswersQuestion extends Question {
  // Not labeled as const so that correct Answers can be sorted
  MultipleAnswersQuestion({
    required super.context,
    required super.question,
    required super.photo,
    required super.answerOptions,
    required super.explanation,
    required this.correctAnswers});

  List<String> correctAnswers;
}

// class TextFieldQuestion extends Question {
//   const TextFieldQuestion(super.context, super.question, super.photo, super.answerOptions, this.correctAnswers);
//
//   final List<String> correctAnswers;
//
// }
