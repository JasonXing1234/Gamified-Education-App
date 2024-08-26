// Class for Holding Question Data

class Question {
  const Question(this.context, this.question, this.photo, this.answerOptions);

  final String context;
  final String question;
  final List<String> answerOptions;
  final String photo;

  List<String> getShuffledAnswers() {
    final shuffledAnswers = List.of(this.answerOptions);
    shuffledAnswers.shuffle();
    return shuffledAnswers;
  }

}

class SingleAnswerQuestion extends Question {
  const SingleAnswerQuestion(super.context, super.question, super.photo, super.answerOptions, this.correctAnswer);

  // Corresponding Index from answer options the correct answer
  final int correctAnswer;

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
