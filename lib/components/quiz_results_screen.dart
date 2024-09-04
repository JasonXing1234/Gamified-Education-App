import 'package:flutter/material.dart';
import 'package:quiz/components/quiz/quiz_questions/quiz1.dart';
import 'package:quiz/components/quiz/quiz_screen.dart';
import 'package:quiz/components/result_screen.dart';

import 'lesson/lesson_screen.dart';

class QuizResultScreen extends StatefulWidget {
  QuizResultScreen({
    super.key,
    required this.lessonNumber,
    required this.activeScreen
  });

  final int lessonNumber;
  String activeScreen;

  @override
  State<StatefulWidget> createState() =>
      _QuizResultScreenState();

}

class _QuizResultScreenState extends State<QuizResultScreen> {

  List<String> answers = [];
  int resultNumber = 0;

  void recordAnswersQuiz1(String answer) {
    setState(() {
      answers.add(answer);
      if (quiz1.length == answers.length) {
        widget.activeScreen = 'result-screen';
        resultNumber = 1;
      }
    });
  }

  void returnHome() {
    setState(() {
      answers = [];
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {

    Widget screen = const Center(
      child: Text('Open Blank Scaffold'),
    );

    if (widget.activeScreen == "quiz-screen") {
      screen = QuizScreen(onSelectAnswer: recordAnswersQuiz1, quizNumber: widget.lessonNumber);
    }
    else if (widget.activeScreen == "result-screen") {
      screen = ResultScreen(
        quizNumber: resultNumber,
        userAnswers: answers,
        restartQuiz: returnHome,
      );
    }

    return Scaffold(
      body: screen,
    );
  }
}

