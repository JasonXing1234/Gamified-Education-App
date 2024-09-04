// Class for Holding Question Data

class Question {
  const Question(this.context, this.question, this.photo, this.answerOptions);

  // final String title = ""; // Title for questions will always be empty, but parameter is needed to mix reading pages and questions pages
  final String context;
  final String question;
  final List<String> answerOptions;
  final String photo;

  List<String> getShuffledAnswers() {
    final shuffledAnswers = List.of(answerOptions);
    shuffledAnswers.shuffle();
    return shuffledAnswers;
  }

}

class SingleAnswerQuestion extends Question {
  const SingleAnswerQuestion(super.context, super.question, super.photo, super.answerOptions, this.correctAnswer);

  final String correctAnswer;

}

class MultipleAnswersQuestion extends Question {
  const MultipleAnswersQuestion(super.context, super.question, super.photo, super.answerOptions, this.correctAnswers);

  final List<String> correctAnswers;

}

// class TextFieldQuestion extends Question {
//   const TextFieldQuestion(super.context, super.question, super.photo, super.answerOptions, this.correctAnswers);
//
//   final List<String> correctAnswers;
//
// }