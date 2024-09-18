// Class for Holding Question Data

class Question {
  const Question(this.context, this.question, this.photo, this.answerOptions, this.explanation);

  // final String title = ""; // Title for questions will always be empty, but parameter is needed to mix reading pages and questions pages
  final String context;
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
  const SingleAnswerQuestion(super.context, super.question, super.photo, super.answerOptions, super.explanation, this.correctAnswer,);

  final String correctAnswer;

}

class MultipleAnswersQuestion extends Question {
  // Not labeled as const so that correct Answers can be sorted
  MultipleAnswersQuestion(super.context, super.question, super.photo, super.answerOptions, super.explanation, this.correctAnswers);

  List<String> correctAnswers;



}

// class TextFieldQuestion extends Question {
//   const TextFieldQuestion(super.context, super.question, super.photo, super.answerOptions, this.correctAnswers);
//
//   final List<String> correctAnswers;
//
// }
