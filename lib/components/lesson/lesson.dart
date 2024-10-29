import 'package:quiz/components/question.dart';
import 'package:quiz/components/reading/reading_page.dart';
import 'package:quiz/components/rewards/character.dart';

class Lesson {
  Lesson(this.title, this.character, this.lessonNumber, this.progress, this.reading, this.quiz, this.practice);

  final String title;
  final Character character;
  final int lessonNumber;
  final double progress;

  final List<ReadingPage> reading;
  final List<Question> quiz;
  final List<Question> practice;



  String getCurrentPhoto() {

    String? photo = character.photos[character.currentPhase];

    if (photo != null) {
      return photo;
    }
    else {
      return "assets/images/lock.png";
    }
  }

}
