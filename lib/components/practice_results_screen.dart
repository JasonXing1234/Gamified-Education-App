import 'package:flutter/material.dart';

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

  void switchToRewardScreen() {
    setState(() {
      widget.activeScreen = "reward-screen";
    });
  }

  @override
  Widget build(BuildContext context) {

    Widget screen = const Center(
      child: Text('Open Blank Scaffold for practices'),
    );


    // TODO: Update these practices to pick random practices from the lesson

    if (widget.activeScreen == "practice-screen") {
      screen = PracticeScreen(onDone: switchToRewardScreen, practice: widget.lesson.practice,);
    }
    else if (widget.activeScreen == "reward-screen") {
      screen = RewardScreen(lesson: widget.lesson, activityName: "practice",);
    }

    return Scaffold(
      body: screen,
    );
  }
}

