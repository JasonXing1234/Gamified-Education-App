// Class for Holding Question Data

class Question {
  const Question(this.context, this.question, this.photo, this.answers);

  final String context;
  final String question;
  final List<String> answers;
  final String photo;

  List<String> getShuffledAnswers() {
    final shuffledAnswers = List.of(this.answers);
    shuffledAnswers.shuffle();
    return shuffledAnswers;
  }

}

class SingleAnswerQuestion extends Question {
  const SingleAnswerQuestion(super.context, super.question, super.photo, super.answers, this.correctAnswerIndex);

  final int correctAnswerIndex;

}

class MultipleAnswersQuestion extends Question {
  const MultipleAnswersQuestion(super.context, super.question, super.photo, super.answers, this.correctAnswers);

  final List<int> correctAnswers;

}

class TextFieldQuestion extends Question {
  const TextFieldQuestion(super.context, super.question, super.photo, super.answers, this.correctAnswers);

  final List<String> correctAnswers;

}
