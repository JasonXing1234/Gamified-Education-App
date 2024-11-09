import 'package:flutter/material.dart';

import 'package:quiz/components/practice/practice_questions/fake_profile_practice/fake_profiles_practice_1.dart';
import 'package:quiz/components/practice/practice_screen.dart';
import 'package:quiz/components/rewards/reward_screen.dart';

import 'lesson/lesson.dart';

class PracticeResultScreen extends StatefulWidget {
  PracticeResultScreen({
    super.key,
    required this.lesson,
    required this.activeScreen
  });

  final Lesson lesson;
  String activeScreen;

  @override
  State<StatefulWidget> createState() =>
      _PracticeResultScreenState();

}

class _PracticeResultScreenState extends State<PracticeResultScreen> {

  List<String> answers = [];
  int resultNumber = 0;

  void recordAnswersPractice1(String answer) {
    setState(() {
      answers.add(answer);
      if (fakeProfilesPractice1.length == answers.length) {
        widget.activeScreen = "reward-screen";
      }
    });
  }

  void recordAnswersPractice2(String answer) {
    // setState(() {
    //   answers.add(answer);
    //   if (quiz2.length == answers.length) {
    //     widget.activeScreen = 'result-screen';
    //     resultNumber = 2;
    //   }
    // });
  }

  void returnHome() {
    setState(() {
      answers = [];
      // Navigator.of(context).pop();
      widget.activeScreen = 'reward-screen';
    });
  }

  @override
  Widget build(BuildContext context) {

    List<Function(String)> practiceAnswers = [recordAnswersPractice1, recordAnswersPractice2];

    Widget screen = const Center(
      child: Text('Open Blank Scaffold for practices'),
    );


    // TODO: Update these practices to pick random practices

    if (widget.activeScreen == "practice-screen") {
      if (widget.lesson.lessonNumber > 6) {
        screen = PracticeScreen(onSelectAnswer: recordAnswersPractice1, practice: widget.lesson.practice,);
      }
      else {
        screen = PracticeScreen(onSelectAnswer: practiceAnswers[widget.lesson.lessonNumber - 1], practice: widget.lesson.practice,);
      }
    }
    else if (widget.activeScreen == "reward-screen") {
      screen = RewardScreen(lesson: widget.lesson, activityName: "practice",);
    }

    return Scaffold(
      body: screen,
    );
  }
}

