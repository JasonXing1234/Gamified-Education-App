import 'package:quiz/components/question.dart';
import 'package:quiz/components/reading/reading_page.dart';
import 'package:quiz/components/rewards/character.dart';

class Lesson {
  Lesson({
    required this.title,
    required this.character,
    required this.characterName,
    required this.lessonNumber,
    required this.progress,
    required this.reading,
    required this.preQuiz,
    required this.quiz,
    required this.practice
  });

  final String title;
  final Character character;
  String characterName;

  final int lessonNumber;
  final double progress;

  final List<ReadingPage> reading;
  final List<Question> preQuiz;
  final List<Question> quiz;
  final List<Question> practice; // TODO: Update these practices to have lots of practices?????

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
