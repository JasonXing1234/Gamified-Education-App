import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:quiz/components/practice/practice_questions/fake_profile_practice/fake_profiles_practice_1.dart';
import 'package:quiz/components/practice/practice_screen.dart';
import 'package:quiz/components/quiz/quiz_questions/quiz1.dart';
import 'package:quiz/components/quiz/quiz_questions/quiz2.dart';
import 'package:quiz/components/quiz/quiz_questions/quiz3.dart';
import 'package:quiz/components/quiz/quiz_questions/quiz4.dart';
import 'package:quiz/components/quiz/quiz_questions/quiz5.dart';
import 'package:quiz/components/quiz/quiz_questions/quiz6.dart';
import 'package:quiz/components/quiz/quiz_screen.dart';
import 'package:quiz/components/result_screen.dart';
import 'package:quiz/components/rewards/reward_screen.dart';

class PracticeResultScreen extends StatefulWidget {
  PracticeResultScreen({
    super.key,
    required this.lessonNumber,
    required this.activeScreen
  });

  final int lessonNumber;
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
        widget.activeScreen = 'result-screen';
      }
    });

    // setState(() {
    //   answers.add(answer);
    //   if (quiz1.length == answers.length) {
    //     widget.activeScreen = 'result-screen';
    //     resultNumber = widget.lessonNumber;
    //   }
    // });
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

    if (widget.activeScreen == "practice-screen") {
      if (widget.lessonNumber > 6) {
        screen = PracticeScreen(onSelectAnswer: recordAnswersPractice1, quizNumber: widget.lessonNumber);
      }
      else {
        screen = PracticeScreen(onSelectAnswer: practiceAnswers[widget.lessonNumber - 1], quizNumber: widget.lessonNumber);
      }
    }
    else if (widget.activeScreen == "result-screen") {
      screen = ResultScreen(
        quizNumber: resultNumber,
        userAnswers: answers,
        endQuiz: returnHome,
      );
    }
    else if (widget.activeScreen == "reward-screen") {
      screen = RewardScreen(lessonNumber: widget.lessonNumber, activityName: "practice",);
    }

    return Scaffold(
      body: screen,
    );
  }
}

