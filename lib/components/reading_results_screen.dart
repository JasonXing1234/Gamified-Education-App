import 'package:flutter/material.dart';
import 'package:quiz/components/reading/readings_screen.dart';
import 'package:quiz/components/rewards/reward_screen.dart';

import 'lesson/lesson.dart';

class ReadingResultScreen extends StatefulWidget {
  ReadingResultScreen({
    super.key,
    required this.lessonNumber,
    required this.lesson,
    required this.activeScreen
  });

  final int lessonNumber;
  final Lesson lesson;
  String activeScreen;

  @override
  State<StatefulWidget> createState() =>
      _ReadingResultScreenState();

}

class _ReadingResultScreenState extends State<ReadingResultScreen> {

  // List<String> answers = [];
  // int resultNumber = 0;

  void openRewardPage() {
    setState(() {
      // answers = [];
      // Navigator.of(context).pop();
      widget.activeScreen = "reward-screen";
    });
  }

  @override
  Widget build(BuildContext context) {

    Widget screen = const Center(
      child: Text("Open Blank Scaffold for reading"),
    );

    if (widget.activeScreen == "reading-screen") {
      screen = ReadingsScreen(readingNumber: widget.lessonNumber, openRewardPage: openRewardPage);
    }
    else if (widget.activeScreen == "reward-screen") {
      screen = RewardScreen(lessonNumber: widget.lessonNumber, lesson: widget.lesson, activityName: "reading",);
    }

    return Scaffold(
      body: screen,
    );
  }
}

