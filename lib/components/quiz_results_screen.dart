import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:quiz/components/quiz/quiz_questions/quiz1.dart';
import 'package:quiz/components/quiz/quiz_questions/quiz2.dart';
import 'package:quiz/components/quiz/quiz_questions/quiz3.dart';
import 'package:quiz/components/quiz/quiz_questions/quiz4.dart';
import 'package:quiz/components/quiz/quiz_questions/quiz5.dart';
import 'package:quiz/components/quiz/quiz_questions/quiz6.dart';
import 'package:quiz/components/quiz/quiz_screen.dart';
import 'package:quiz/components/result_screen.dart';
import 'package:quiz/components/rewards/reward_screen.dart';

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
        resultNumber = widget.lessonNumber;
      }
    });
  }

  void recordAnswersQuiz2(String answer) {
    setState(() {
      answers.add(answer);
      if (quiz2.length == answers.length) {
        widget.activeScreen = 'result-screen';
        resultNumber = 2;
      }
    });
  }

  void recordAnswersQuiz3(String answer) {
    setState(() {
      answers.add(answer);
      if (quiz3.length == answers.length) {
        widget.activeScreen = 'result-screen';
        resultNumber = 3;
      }
    });
  }

  void recordAnswersQuiz4(String answer) {
    setState(() {
      answers.add(answer);

      if (quiz4.length == answers.length) {
        widget.activeScreen = 'result-screen';
        resultNumber = 4;
      }
    });
  }

  void recordAnswersQuiz5(String answer) {
    setState(() {
      answers.add(answer);
      if (quiz5.length == answers.length) {
        widget.activeScreen = 'result-screen';
        resultNumber = 5;
      }
    });
  }

  void recordAnswersQuiz6(String answer) {
    setState(() {
      answers.add(answer);
      if (quiz6.length == answers.length) {
        widget.activeScreen = 'result-screen';
        resultNumber = 6;
      }
    });
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

    List<Function(String)> quizAnswers = [recordAnswersQuiz1, recordAnswersQuiz2, recordAnswersQuiz3, recordAnswersQuiz4, recordAnswersQuiz5, recordAnswersQuiz6];

    Widget screen = const Center(
      child: Text('Open Blank Scaffold'),
    );

    if (widget.activeScreen == "quiz-screen") {
      if (widget.lessonNumber > 6) {
        screen = QuizScreen(onSelectAnswer: recordAnswersQuiz1, quizNumber: widget.lessonNumber);
      }
      else {
        screen = QuizScreen(onSelectAnswer: quizAnswers[widget.lessonNumber - 1], quizNumber: widget.lessonNumber);
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
      screen = const RewardScreen();
    }

    return Scaffold(
      body: screen,
    );
  }
}

