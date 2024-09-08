import 'package:quiz/components/rewards/character.dart';

class Lesson {
  Lesson(this.title, this.character, this.lessonNumber);

  final String title;
  final Character character;
  final int lessonNumber;

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
