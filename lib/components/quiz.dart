import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz/components/lesson/readings_screen.dart';
import 'package:quiz/components/practice/practice_screen.dart';
import 'package:quiz/components/quiz/quiz_screen.dart';
import 'package:quiz/components/result_screen.dart';
import 'package:quiz/start_screen.dart';
import 'package:quiz/data/fake_profiles_practice_1.dart';

import 'quiz/quiz_questions/quiz1.dart';
import 'quiz/quiz_questions/quiz2.dart';
import 'quiz/quiz_questions/quiz3.dart';
import 'quiz/quiz_questions/quiz4.dart';
import 'quiz/quiz_questions/quiz5.dart';
import 'quiz/quiz_questions/quiz6.dart';
import '../styles/app_colors.dart';
import '../styles/text_styles.dart';

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

  final AppTextStyles textStyles = AppTextStyles();
  final AppColors appColors = const AppColors();

  void readingScreen1() {
    activeScreen = 'reading-screen1';

    print("DEBUG: Reading Screen 1 is active");
    print("DEBUG: " + activeScreen);
  }

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

  void quizScreen3() {
    setState(() {
      activeScreen = 'quiz-screen3';
    });
  }

  void quizScreen4() {
    setState(() {
      activeScreen = 'quiz-screen4';
    });
  }

  void quizScreen5() {
    setState(() {
      activeScreen = 'quiz-screen5';
    });
  }

  void quizScreen6() {
    setState(() {
      activeScreen = 'quiz-screen6';
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

  void recordAnswer6(String answer) {
    setState(() {
      answers.add(answer);
      if (quiz6.length == answers.length) {
        activeScreen = 'result-screen';
        resultNumber = 6;
      }
    });
  }

  void returnHomeAndResetQuiz() {
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
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 5),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border: Border.all(color: Colors.black, width: 3.0),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Points",
                        style: textStyles.mediumBodyText,
                      ),
                       Text(
                        "0",
                        style: textStyles.mediumBodyText,
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Lessons", // TODO: Lessons or activities
                        style: textStyles.mediumBodyText,
                      ),
                      Text(
                        "0/6",
                        style: textStyles.mediumBodyText,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 30),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  border: Border.all(color: Colors.black, width: 3.0),
                  borderRadius: BorderRadius.circular(20.0),
              ),
              child: Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center, // Vertical Alignment
                    crossAxisAlignment: CrossAxisAlignment.start, // Aligns children to the left
                    children: [
                      Text(
                        "Current Lesson",
                        textAlign: TextAlign.left,
                        style: textStyles.mediumBodyText,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Social Media Norms",
                        textAlign: TextAlign.left,
                        style: textStyles.smallBodyText,
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  ElevatedButton(
                    onPressed: (){
                      //TODO: Add code
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10), // Padding for text and border
                      //fixedSize: const Size(150, 50),
                      backgroundColor: appColors.royalBlue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Text(
                      "PREP",
                      style: textStyles.mediumBodyTextWhite,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(
            height: 40,
          ),
          OutlinedButton.icon(
            onPressed: (){_scaffoldKey.currentState?.openDrawer();},
            style: OutlinedButton.styleFrom(
              backgroundColor: appColors.royalBlue,
              foregroundColor: Colors.white,
            ),
            icon: const Icon(Icons.arrow_right_alt),
            label: Text(
                "Start Practice",
                style: textStyles.bodyTextWhite,
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          OutlinedButton.icon(
            onPressed: (){_scaffoldKey.currentState?.openEndDrawer();},
            style: OutlinedButton.styleFrom(
              backgroundColor: appColors.royalBlue,
              foregroundColor: Colors.white,
            ),
            icon: const Icon(Icons.arrow_right_alt),
            label: Text(
                "Start Quiz",
                style: textStyles.bodyTextWhite,
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          OutlinedButton.icon(
            onPressed: (){
              //readingScreen1();
              //Navigator.of(context).pop();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ReadingsScreen(readingNumber: 1,)),
              );
            },
            style: OutlinedButton.styleFrom(
              backgroundColor: appColors.royalBlue,
              foregroundColor: Colors.white,
            ),
            icon: const Icon(Icons.arrow_right_alt),
            label: const Text("Social Norms"),
          ),
        ],
      ),
    );

    if (activeScreen == 'reading-screen1') {
      print("DEBUG: Set Reading Screen 1");
      // TODO Screen is not being set properly in this instance, why?
      // TODO: Error is happening earlier, I think?
      // screen = QuizScreen(onSelectAnswer: recordAnswer1, quizNumber: 1,);
      //screen = const ReadingsScreen(readingNumber: 1);
      /*Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ReadingsScreen(readingNumber: 1,)),
      );*/
      screen = PracticeScreen(onSelectAnswer: recordAnswer, quizNumber: 1,);
      print("DEBUG: Open Reading Screen 1");
    }
    else if (activeScreen == 'question-screen') {
      screen = PracticeScreen(onSelectAnswer: recordAnswer, quizNumber: 1,);
    }
    else if (activeScreen == 'question-screen2') {
      screen = PracticeScreen(onSelectAnswer: recordAnswer, quizNumber: 2,);
    }
    else if (activeScreen == 'question-screen3') {
      screen = PracticeScreen(onSelectAnswer: recordAnswer, quizNumber: 3,);
    }
    else if (activeScreen == 'question-screen4') {
      screen = PracticeScreen(onSelectAnswer: recordAnswer, quizNumber: 4,);
    }
    else if (activeScreen == 'question-screen5') {
      screen = PracticeScreen(onSelectAnswer: recordAnswer, quizNumber: 5,);
    }
    else if (activeScreen == 'question-screen6') {
      screen = PracticeScreen(onSelectAnswer: recordAnswer, quizNumber: 6,);
    }
    else if (activeScreen == 'question-screen7') {
      screen = PracticeScreen(onSelectAnswer: recordAnswer, quizNumber: 7,);
    }
    else if (activeScreen == 'question-screen8') {
      screen = PracticeScreen(onSelectAnswer: recordAnswer, quizNumber: 8,);
    }
    else if (activeScreen == 'question-screen9') {
      screen = PracticeScreen(onSelectAnswer: recordAnswer, quizNumber: 9,);
    }
    else if (activeScreen == 'quiz-screen1') {
      screen = QuizScreen(onSelectAnswer: recordAnswer1, quizNumber: 1,);
    }
    else if (activeScreen == 'quiz-screen2') {
      screen = QuizScreen(onSelectAnswer: recordAnswer2, quizNumber: 2,);
    }
    else if (activeScreen == 'quiz-screen3') {
      screen = QuizScreen(onSelectAnswer: recordAnswer3, quizNumber: 3,);
    }
    else if (activeScreen == 'quiz-screen4') {
      screen = QuizScreen(onSelectAnswer: recordAnswer4, quizNumber: 4,);
    }
    else if (activeScreen == 'quiz-screen5') {
      screen = QuizScreen(onSelectAnswer: recordAnswer5, quizNumber: 5,);
    }
    else if (activeScreen == 'quiz-screen6') {
      screen = QuizScreen(onSelectAnswer: recordAnswer6, quizNumber: 6,);
    }
    else if (activeScreen == 'result-screen') {
      screen = ResultScreen(
        quizNumber: resultNumber,
        userAnswers: answers,
        restartQuiz: returnHomeAndResetQuiz,
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
                    backgroundColor: appColors.royalBlue,
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
                    backgroundColor: appColors.royalBlue,
                    foregroundColor: Colors.white,
                  ),
                  icon: const Icon(Icons.arrow_right_alt),
                  label: const Text("Settings"),
                ),
                OutlinedButton.icon(
                  onPressed: (){
                    setState(() {
                      quizScreen3();
                    });
                    Navigator.of(context).pop();
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: appColors.royalBlue,
                    foregroundColor: Colors.white,
                  ),
                  icon: const Icon(Icons.arrow_right_alt),
                  label: const Text("Fake profiles"),
                ),
                OutlinedButton.icon(
                  onPressed: (){
                    setState(() {
                      quizScreen4();
                    });
                    Navigator.of(context).pop();
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: appColors.royalBlue,
                    foregroundColor: Colors.white,
                  ),
                  icon: const Icon(Icons.arrow_right_alt),
                  label: const Text("Social tags"),
                ),
                OutlinedButton.icon(
                  onPressed: (){
                    setState(() {
                      quizScreen5();
                    });
                    Navigator.of(context).pop();
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: appColors.royalBlue,
                    foregroundColor: Colors.white,
                  ),
                  icon: const Icon(Icons.arrow_right_alt),
                  label: const Text("Appropriate interactions"),
                ),
                OutlinedButton.icon(
                  onPressed: (){
                    setState(() {
                      quizScreen6();
                    });
                    Navigator.of(context).pop();
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: appColors.royalBlue,
                    foregroundColor: Colors.white,
                  ),
                  icon: const Icon(Icons.arrow_right_alt),
                  label: const Text("Social Media vs Reality"),
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
                          backgroundColor: appColors.royalBlue,
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
                            backgroundColor: appColors.royalBlue,
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
                          backgroundColor: appColors.royalBlue,
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
                          backgroundColor: appColors.royalBlue,
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
                          backgroundColor: appColors.royalBlue,
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
                          backgroundColor: appColors.royalBlue,
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
                          backgroundColor: appColors.royalBlue,
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
                          backgroundColor: appColors.royalBlue,
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
                          backgroundColor: appColors.royalBlue,
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
            color: Colors.white,
            // gradient: LinearGradient(
            //   colors: [
            //     Color(0x986BF567),
            //     Colors.white,
            //   ],
            //   begin: Alignment.topCenter,
            //   end: Alignment.bottomCenter,
            // ),
          ),
          child: screen,
        ),
      );
  }
}
