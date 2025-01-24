
import 'package:quiz/components/quiz/quiz_questions/quiz0.dart';
import 'package:quiz/components/reading/readings/reading0.dart';

import '../practice/practice_questions/fake_profile_practice/fake_profiles_practice_1.dart';
import '../practice/practice_questions/settings_practice/settings_practice.dart';
import '../practice/practice_questions/social_media_norms_practice/social_media_norms_practice.dart';
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
  title: "TUTORIAL & SET UP",
  character: orangeDragon,
  characterName: "Name",
  lessonNumber: 0,
  progress: 0.5,
  reading: reading0,
  preQuiz: preQuiz0, //TODO: Currently only lesson with a different pre-quiz
  quiz: quiz0,
  practice: tutorialPractice,
);

Lesson socialMediaNorms = Lesson(
  title: "SOCIAL MEDIA NORMS",
  character: orangeDragon,
  characterName: "Name",
  lessonNumber: 1,
  progress: 0.0,
  reading: reading1,
  preQuiz: quiz1,
  quiz: quiz1,
  practice: socialMediaNormsPractice,
);


Lesson settings = Lesson(
  title: "SETTINGS",
  character: lockedCharacter,
  characterName: "Name",
  lessonNumber: 2,
  progress: 0.0,
  reading: reading2,
  preQuiz: quiz2,
  quiz: quiz2,
  practice: settingsPractice,
);

Lesson fakeProfiles = Lesson(
  title: "FAKE PROFILES",
  character: lockedCharacter,
  characterName: "Name",
  lessonNumber: 3,
  progress: 0.0,
  reading: reading3,
  preQuiz: quiz3,
  quiz: quiz3,
  practice: fakeProfilesPractice1,
);

Lesson socialTags = Lesson(
  title: "SOCIAL TAGS",
  character: lockedCharacter,
  characterName: "Name",
  lessonNumber: 4,
  progress: 0.0,
  reading: reading4,
  preQuiz: quiz4,
  quiz: quiz4,
  practice: fakeProfilesPractice1,
);

Lesson appropriateInteractions = Lesson(
  //"APPROPRIATE INTERACTIONS",
  title: "INTERACTION ETIQUETTE", // Slightly shorter name for dashboard on home-screen
  character: lockedCharacter,
  characterName: "Name",
  lessonNumber: 5,
  progress: 0.0,
  reading: reading5,
  preQuiz: quiz5,
  quiz: quiz5,
  practice: fakeProfilesPractice1,
);

Lesson socialMediaVSReality = Lesson(
  title: "SOCIAL MEDIA VS REALITY",
  character: lockedCharacter,
  characterName: "Name",
  lessonNumber: 6,
  progress: 0.0,
  reading: reading6,
  preQuiz: quiz6,
  quiz: quiz6,
  practice: fakeProfilesPractice1,
);