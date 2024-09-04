class ReadingPage {
  const ReadingPage(this.title, this.text, this.photo);

  final String title;
  final List<String> text;
  final String photo;

}


class ReadingMultipleAnswersQuestion extends ReadingPage {
  const ReadingMultipleAnswersQuestion(super.title, super.text, super.photo, this.answerOptions, this.correctAnswers);

  final List<String> answerOptions;
  final List<String> correctAnswers;
}