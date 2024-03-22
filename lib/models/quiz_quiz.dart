class QuizQuiz {
  const QuizQuiz(this.question, this.photo, this.answers);

  final String question;
  final List<String> answers;
  final String photo;

  List<String> getShuffledAnswers() {
    final shuffledAnswers = List.of(this.answers);
    shuffledAnswers.shuffle();
    return shuffledAnswers;
  }

}
