import 'package:quiz/components/rewards/character.dart';

class Lesson {
  Lesson(this.title, this.character, this.lessonNumber, this.progress);

  final String title;
  final Character character;
  final int lessonNumber;
  final double progress;

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
