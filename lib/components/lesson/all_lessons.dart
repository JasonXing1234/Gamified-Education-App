
import 'package:quiz/components/quiz/quiz_questions/quiz0.dart';
import 'package:quiz/components/reading/readings/reading0.dart';

import '../practice/practice_questions/fake_profile_practice/fake_profiles_practice_1.dart';
import '../practice/practice_questions/tutorial_practice.dart';
import '../quiz/quiz_questions/quiz1.dart';
import '../quiz/quiz_questions/quiz2.dart';
import '../quiz/quiz_questions/quiz3.dart';
import '../quiz/quiz_questions/quiz4.dart';
import '../quiz/quiz_questions/quiz5.dart';
import '../quiz/quiz_questions/quiz6.dart';
import '../reading/readings/reading1.dart';
import '../reading/readings/reading2.dart';
import '../reading/readings/reading3.dart';
import '../reading/readings/reading4.dart';
import '../reading/readings/reading5.dart';
import '../reading/readings/reading6.dart';
import '../rewards/all_characters.dart';
import 'lesson.dart';


List<Lesson> allLessons = [
  tutorial,
  socialMediaNorms,
  settings,
  fakeProfiles,
  socialTags,
  appropriateInteractions,
  socialMediaVSReality,
];

Lesson tutorial = Lesson(
  "Tutorial and Set up",
  orangeDragon,
  0,
  0.5,
  reading0,
  quiz0,
  tutorialPractice,
);

Lesson socialMediaNorms = Lesson(
  "SOCIAL MEDIA NORMS",
    lockedCharacter,
  1,
  0.0,
  reading1,
  quiz1,
  fakeProfilesPractice1,
);


Lesson settings = Lesson(
  "SETTINGS",
  lockedCharacter,
  2,
  0.0,
  reading2,
  quiz2,
  fakeProfilesPractice1,
);

Lesson fakeProfiles = Lesson(
  "FAKE PROFILES",
  lockedCharacter,
  3,
  0.0,
  reading3,
  quiz3,
  fakeProfilesPractice1,
);

Lesson socialTags = Lesson(
  "SOCIAL TAGS",
  lockedCharacter,
  4,
  0.0,
  reading4,
  quiz4,
  fakeProfilesPractice1,
);

Lesson appropriateInteractions = Lesson(
  //"APPROPRIATE INTERACTIONS",
  "INTERACTION ETIQUETTE", // Slightly shorter name for dashboard on home-screen
  lockedCharacter,
  5,
  0.0,
  reading5,
  quiz5,
  fakeProfilesPractice1,
);

Lesson socialMediaVSReality = Lesson(
  "SOCIAL MEDIA VS REALITY",
  lockedCharacter,
  6,
  0.0,
  reading6,
  quiz6,
  fakeProfilesPractice1,
);