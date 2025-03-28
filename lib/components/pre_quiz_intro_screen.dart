import 'package:flutter/material.dart';
import 'package:quiz/components/preQuiz/pre_quiz_screen.dart';
import 'package:quiz/components/quiz/quiz_questions/quiz0.dart';
import 'package:quiz/components/quiz/quiz_questions/quiz1.dart';
import 'package:quiz/components/quiz/quiz_questions/quiz2.dart';
import 'package:quiz/components/quiz/quiz_questions/quiz3.dart';
import 'package:quiz/components/quiz/quiz_questions/quiz4.dart';
import 'package:quiz/components/quiz/quiz_questions/quiz5.dart';
import 'package:quiz/components/quiz/quiz_questions/quiz6.dart';
import 'package:quiz/components/quiz/quiz_screen.dart';
import 'package:quiz/components/pre_quiz_result_screen.dart';
import 'package:quiz/components/rewards/reward_screen.dart';

import '../SQLITE/sqliteHelper.dart';
import '../models/UserModel.dart';
import 'lesson/lesson.dart';

class PreQuizResultScreen extends StatefulWidget {
  PreQuizResultScreen({
    super.key,
    required this.lesson,
    required this.activeScreen
  });

  final Lesson lesson;
  String activeScreen;

  @override
  State<StatefulWidget> createState() =>
      _QuizResultScreenState();

}

class _QuizResultScreenState extends State<PreQuizResultScreen> {

  List<String> answers = [];
  int resultNumber = 0;
  UserModel? user;
  final DatabaseHelper _dbHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    _initializeUser();
  }

  Future<void> _initializeUser() async {
    user = await _dbHelper.getLoggedInUser();
  }

  void recordAnswersQuiz0(String answer) {
    setState(() {
      answers.add(answer);
      if (quiz0.length == answers.length) {
        widget.activeScreen = 'result-screen';
        resultNumber = widget.lesson.lessonNumber;
        print('resultNumber is $resultNumber');
      }
    });
  }

  void recordAnswersQuiz1(String answer) {
    setState(() {
      answers.add(answer);
      if (quiz1.length == answers.length) {
        widget.activeScreen = 'result-screen';
        resultNumber = widget.lesson.lessonNumber;
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

    List<Function(String)> quizAnswers = [recordAnswersQuiz0, recordAnswersQuiz1, recordAnswersQuiz2, recordAnswersQuiz3, recordAnswersQuiz4, recordAnswersQuiz5, recordAnswersQuiz6];

    Widget screen = const Center(
      child: Text('Open Blank Scaffold'),
    );

    if (widget.activeScreen == "quiz-screen") {
      if (widget.lesson.lessonNumber > 6) {
        screen = PreQuizScreen(onSelectAnswer: recordAnswersQuiz1, quizNumber: widget.lesson.lessonNumber, quiz: widget.lesson.quiz);
      }
      else {
        screen = PreQuizScreen(onSelectAnswer: quizAnswers[widget.lesson.lessonNumber], quizNumber: widget.lesson.lessonNumber, quiz: widget.lesson.quiz);
      }
    }
    else if (widget.activeScreen == "result-screen") {
      final int quizResult = resultNumber;
      final List<String> userAnswersResolved = answers;
      screen = PreResult(
        quizNumber: quizResult,
        userAnswers: userAnswersResolved,
        endQuiz: returnHome, user: user!,
      );
    }
    else if (widget.activeScreen == "reward-screen") {
      screen = RewardScreen(lesson: widget.lesson, activityName: "quiz",);
    }

    return Scaffold(
      body: screen,
    );
  }
}

