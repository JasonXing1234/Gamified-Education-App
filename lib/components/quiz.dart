import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz/components/question_screen.dart';
import 'package:quiz/components/quiz_screen.dart';
import 'package:quiz/components/result_screen.dart';
import 'package:quiz/data/quiz3.dart';
import 'package:quiz/data/quiz4.dart';
import 'package:quiz/start_screen.dart';
import 'package:quiz/data/quiz_data.dart';

import '../data/quiz1.dart';
import '../data/quiz2.dart';
import '../data/quiz5.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() {
    return _QuizState();
  }
}

class _QuizState extends State<Quiz> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String activeScreen = 'start-screen';
  int resultNumber = 0;
  void changeScreen1() {
    setState(() {
      activeScreen = 'question-screen';
    });
  }

  void changeScreen5() {
    setState(() {
      activeScreen = 'question-screen5';
    });
  }
  void changeScreen2() {
    setState(() {
      activeScreen = 'question-screen2';
    });
  }
  void changeScreen3() {
    setState(() {
      activeScreen = 'question-screen3';
    });
  }
  void changeScreen4() {
    setState(() {
      activeScreen = 'question-screen4';
    });
  }
  void changeScreen6() {
    setState(() {
      activeScreen = 'question-screen6';
    });
  }
  void changeScreen7() {
    setState(() {
      activeScreen = 'question-screen7';
    });
  }
  void changeScreen8() {
    setState(() {
      activeScreen = 'question-screen8';
    });
  }
  void changeScreen9() {
    setState(() {
      activeScreen = 'question-screen9';
    });
  }
  void quizScreen1() {
    setState(() {
      activeScreen = 'quiz-screen1';
    });
  }
  void quizScreen2() {
    setState(() {
      activeScreen = 'quiz-screen2';
    });
  }

  List<String> answers = [];
  void recordAnswer(String answer) {
    setState(() {
      answers.add(answer);
      if (questions.length == answers.length) {
        activeScreen = 'result-screen';
      }
    });
  }

  void recordAnswer1(String answer) {
    setState(() {
      answers.add(answer);
      if (quiz1.length == answers.length) {
        activeScreen = 'result-screen';
        resultNumber = 1;
      }
    });
  }

  void recordAnswer2(String answer) {
    setState(() {
      answers.add(answer);
      if (quiz2.length == answers.length) {
        activeScreen = 'result-screen';
        resultNumber = 2;
      }
    });
  }

  void recordAnswer3(String answer) {
    setState(() {
      answers.add(answer);
      if (quiz3.length == answers.length) {
        activeScreen = 'result-screen';
        resultNumber = 3;
      }
    });
  }

  void recordAnswer4(String answer) {
    setState(() {
      answers.add(answer);
      if (quiz4.length == answers.length) {
        activeScreen = 'result-screen';
        resultNumber = 4;
      }
    });
  }

  void recordAnswer5(String answer) {
    setState(() {
      answers.add(answer);
      if (quiz5.length == answers.length) {
        activeScreen = 'result-screen';
        resultNumber = 5;
      }
    });
  }

  void restartQuiz() {
    setState(() {
      activeScreen = 'start-screen';
      answers = [];
    });
  }

  @override
  Widget build(context) {
    Widget screen = Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 40,
          ),
          OutlinedButton.icon(
            onPressed: (){_scaffoldKey.currentState?.openDrawer();},
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
              foregroundColor: Colors.white,
            ),
            icon: const Icon(Icons.arrow_right_alt),
            label: const Text("Start Practice"),
          ),
          OutlinedButton.icon(
            onPressed: (){_scaffoldKey.currentState?.openEndDrawer();},
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
              foregroundColor: Colors.white,
            ),
            icon: const Icon(Icons.arrow_right_alt),
            label: const Text("Start Quiz"),
          ),
        ],
      ),
    );
    if (activeScreen == 'question-screen') {
      screen = QuestionsScreen(onSelectAnswer: recordAnswer, quizNumber: 1,);
    }
    else if (activeScreen == 'question-screen2') {
      screen = QuestionsScreen(onSelectAnswer: recordAnswer, quizNumber: 2,);
    }
    else if (activeScreen == 'question-screen3') {
      screen = QuestionsScreen(onSelectAnswer: recordAnswer, quizNumber: 3,);
    }
    else if (activeScreen == 'question-screen4') {
      screen = QuestionsScreen(onSelectAnswer: recordAnswer, quizNumber: 4,);
    }
    else if (activeScreen == 'question-screen5') {
      screen = QuestionsScreen(onSelectAnswer: recordAnswer, quizNumber: 5,);
    }
    else if (activeScreen == 'question-screen6') {
      screen = QuestionsScreen(onSelectAnswer: recordAnswer, quizNumber: 6,);
    }
    else if (activeScreen == 'question-screen7') {
      screen = QuestionsScreen(onSelectAnswer: recordAnswer, quizNumber: 7,);
    }
    else if (activeScreen == 'question-screen8') {
      screen = QuestionsScreen(onSelectAnswer: recordAnswer, quizNumber: 8,);
    }
    else if (activeScreen == 'question-screen9') {
      screen = QuestionsScreen(onSelectAnswer: recordAnswer, quizNumber: 9,);
    }
    else if (activeScreen == 'quiz-screen1') {
      screen = QuizScreen(onSelectAnswer: recordAnswer1, quizNumber: 1,);
    }
    else if (activeScreen == 'quiz-screen2') {
      screen = QuizScreen(onSelectAnswer: recordAnswer2, quizNumber: 2,);
    }
    else if (activeScreen == 'result-screen') {
      screen = ResultScreen(
        number: resultNumber,
        answers: answers,
        restartQuiz: restartQuiz,
      );
    }
    return Scaffold(
        key: _scaffoldKey,
        endDrawer: Drawer(
          child: SafeArea(
            child: Column(
              children: <Widget>[
                OutlinedButton.icon(
                  onPressed: (){
                    setState(() {
                      quizScreen1();
                    });
                    Navigator.of(context).pop();
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                  ),
                  icon: const Icon(Icons.arrow_right_alt),
                  label: const Text("Social Norms"),
                ),
                OutlinedButton.icon(
                  onPressed: (){
                    setState(() {
                      quizScreen2();
                    });
                    Navigator.of(context).pop();
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                  ),
                  icon: const Icon(Icons.arrow_right_alt),
                  label: const Text("Settings"),
                ),
                OutlinedButton.icon(
                  onPressed: (){
                    setState(() {
                      quizScreen2();
                    });
                    Navigator.of(context).pop();
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                  ),
                  icon: const Icon(Icons.arrow_right_alt),
                  label: const Text("Fake profiles"),
                ),
                OutlinedButton.icon(
                  onPressed: (){
                    setState(() {
                      quizScreen2();
                    });
                    Navigator.of(context).pop();
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                  ),
                  icon: const Icon(Icons.arrow_right_alt),
                  label: const Text("Social tags"),
                ),
                OutlinedButton.icon(
                  onPressed: (){
                    setState(() {
                      quizScreen2();
                    });
                    Navigator.of(context).pop();
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                  ),
                  icon: const Icon(Icons.arrow_right_alt),
                  label: const Text("Appropriate interactions"),
                ),
              ],
            ),
          ),
        ),
        drawer: Drawer(
          child: SafeArea(
            child: Column(
              children: <Widget>[
                      OutlinedButton.icon(
                        onPressed: (){
                          changeScreen9();
                        },
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          foregroundColor: Colors.white,
                        ),
                        icon: const Icon(Icons.arrow_right_alt),
                        label: const Text("      Start Practice from beginning       "),
                      ),
                      OutlinedButton.icon(
                          onPressed: (){
                            setState(() {
                              changeScreen1();
                            });
                            Navigator.of(context).pop();
                          },
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.deepPurple,
                            foregroundColor: Colors.white,
                          ),
                          icon: const Icon(Icons.arrow_right_alt),
                          label: const Text("part 1"),
                        ),

                      OutlinedButton.icon(
                        onPressed: (){
                          setState(() {
                            changeScreen2();
                          });
                          Navigator.of(context).pop();
                        },

                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          foregroundColor: Colors.white,
                        ),
                        icon: const Icon(Icons.arrow_right_alt),
                        label: const Text("part 2"),
                      ),
                      OutlinedButton.icon(
                        onPressed: (){
                          setState(() {
                            changeScreen3();
                          });
                          Navigator.of(context).pop();
                        },
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          foregroundColor: Colors.white,
                        ),
                        icon: const Icon(Icons.arrow_right_alt),
                        label: const Text("part 3"),
                      ),
                      OutlinedButton.icon(
                        onPressed: (){
                          setState(() {
                            changeScreen4();
                          });
                          Navigator.of(context).pop();
                        },
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          foregroundColor: Colors.white,
                        ),
                        icon: const Icon(Icons.arrow_right_alt),
                        label: const Text("part 4"),
                      ),
                      OutlinedButton.icon(
                        onPressed: (){
                          setState(() {
                            changeScreen5();
                          });
                          Navigator.of(context).pop();
                        },
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          foregroundColor: Colors.white,
                        ),
                        icon: const Icon(Icons.arrow_right_alt),
                        label: const Text("part 5"),
                      ),
                      OutlinedButton.icon(
                        onPressed: (){
                          setState(() {
                            changeScreen6();
                          });
                          Navigator.of(context).pop();
                        },
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          foregroundColor: Colors.white,
                        ),
                        icon: const Icon(Icons.arrow_right_alt),
                        label: const Text("part 6"),
                      ),
                      OutlinedButton.icon(
                        onPressed: (){
                          setState(() {
                            changeScreen7();
                          });
                          Navigator.of(context).pop();
                        },
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          foregroundColor: Colors.white,
                        ),
                        icon: const Icon(Icons.arrow_right_alt),
                        label: const Text("part 7"),
                      ),
                      OutlinedButton.icon(
                        onPressed: (){
                          setState(() {
                            changeScreen8();
                          });
                          Navigator.of(context).pop();
                        },
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          foregroundColor: Colors.white,
                        ),
                        icon: const Icon(Icons.arrow_right_alt),
                        label: const Text("part 8"),
                      ),
                    ],
                  ),
                ),
        ),
        body: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0x986BF567),
                Colors.white,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: screen,
        ),
      );
  }
}
