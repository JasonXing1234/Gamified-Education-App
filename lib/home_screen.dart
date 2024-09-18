import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:quiz/components/lesson/lesson_dashboard.dart';
import 'package:quiz/components/lesson/lesson_screen.dart';
import 'package:quiz/components/lesson/all_lessons.dart';

import 'package:quiz/components/practice/practice_screen.dart';
import 'package:quiz/components/quiz/quiz_screen.dart';
import 'package:quiz/components/result_screen.dart';
import 'package:quiz/components/practice/practice_questions/fake_profile_practice/fake_profiles_practice_1.dart';

import 'components/quiz/quiz_questions/quiz1.dart';
import 'components/quiz/quiz_questions/quiz2.dart';
import 'components/quiz/quiz_questions/quiz3.dart';
import 'components/quiz/quiz_questions/quiz4.dart';
import 'components/quiz/quiz_questions/quiz5.dart';
import 'components/quiz/quiz_questions/quiz6.dart';

import '../SignIn.dart';
import '../styles/app_colors.dart';
import '../styles/text_styles.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String activeScreen = 'start-screen';
  int resultNumber = 0;
  Future<int?>? numStars;
  final DatabaseReference _database = FirebaseDatabase.instance.ref();
  User? user2;

  final AppTextStyles textStyles = AppTextStyles();
  final AppColors appColors = const AppColors();

  final double spacing = 30;

  @override
  void initState() {
    super.initState();
    user2 = FirebaseAuth.instance.currentUser;
    // Fetch readings once the widget is initialized
    numStars = _fetchReadingList();
  }

  Future<int?> _fetchReadingList() async {
    if (user2 != null) {
      try {
        DataSnapshot snapshot = await _database
            .child('profile')
            .child(user2!.uid)
            .child('numStars')
            .get();

        if (snapshot.value != null) {
            return snapshot.value as int;
        }

      } catch (e) {
        // Handle potential errors, like network issues
        print('Error fetching reading list: $e');
      }
    }
  }


  // void readingScreen1() {
  //   setState(() {
  //     activeScreen = 'reading-screen1';
  //   });
  // }

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
  // void quizScreen1() {
  //   setState(() {
  //     activeScreen = 'quiz-screen1';
  //   });
  // }

  // void quizScreen2() {
  //   setState(() {
  //     activeScreen = 'quiz-screen2';
  //   });
  // }
  //
  // void quizScreen3() {
  //   setState(() {
  //     activeScreen = 'quiz-screen3';
  //   });
  // }
  //
  // void quizScreen4() {
  //   setState(() {
  //     activeScreen = 'quiz-screen4';
  //   });
  // }
  //
  // void quizScreen5() {
  //   setState(() {
  //     activeScreen = 'quiz-screen5';
  //   });
  // }
  //
  // void quizScreen6() {
  //   setState(() {
  //     activeScreen = 'quiz-screen6';
  //   });
  // }

  List<String> answers = [];
  void recordAnswer(String answer) {
    setState(() {
      answers.add(answer);
      if (fakeProfilesPractice1.length == answers.length) {
        activeScreen = 'result-screen';
      }
    });
  }

  // void recordAnswer1(String answer) {
  //   setState(() {
  //     answers.add(answer);
  //     if (quiz1.length == answers.length) {
  //       activeScreen = 'result-screen';
  //       resultNumber = 1;
  //     }
  //   });
  // }
  //
  // void recordAnswer2(String answer) {
  //   setState(() {
  //     answers.add(answer);
  //     if (quiz2.length == answers.length) {
  //       activeScreen = 'result-screen';
  //       resultNumber = 2;
  //     }
  //   });
  // }
  //
  // void recordAnswer3(String answer) {
  //   setState(() {
  //     answers.add(answer);
  //     if (quiz3.length == answers.length) {
  //       activeScreen = 'result-screen';
  //       resultNumber = 3;
  //     }
  //   });
  // }
  //
  // void recordAnswer4(String answer) {
  //   setState(() {
  //     answers.add(answer);
  //     if (quiz4.length == answers.length) {
  //       activeScreen = 'result-screen';
  //       resultNumber = 4;
  //     }
  //   });
  // }
  //
  // void recordAnswer5(String answer) {
  //   setState(() {
  //     answers.add(answer);
  //     if (quiz5.length == answers.length) {
  //       activeScreen = 'result-screen';
  //       resultNumber = 5;
  //     }
  //   });
  // }
  //
  // void recordAnswer6(String answer) {
  //   setState(() {
  //     answers.add(answer);
  //     if (quiz6.length == answers.length) {
  //       activeScreen = 'result-screen';
  //       resultNumber = 6;
  //     }
  //   });
  // }

  void returnHomeAndResetQuiz() {
    setState(() {
      activeScreen = 'start-screen';
      answers = [];
    });
  }

  @override
  Widget build(context) {
    Widget screen = SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 50,
          ),

          // Start Quiz
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              OutlinedButton.icon(
                label: Text(
                  "Menu",
                  style: textStyles.mediumBodyTextWhite,
                ),
                onPressed: (){_scaffoldKey.currentState?.openEndDrawer();},
                style: OutlinedButton.styleFrom(
                  backgroundColor: appColors.royalBlue,
                  foregroundColor: Colors.white,
                ),
                icon: const Icon(Icons.menu),
              ),

              const SizedBox(
                width: 35,
              ),
            ],
          ),


          const SizedBox(
            height: 10,
          ),

          // User Stats Box
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
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
                      Icon( Icons.stars, color: appColors.yellow, size: 60,),
                      Text("Stars", style: textStyles.mediumBodyText,),
                      FutureBuilder<int?>(
                        future: _fetchReadingList(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else if (snapshot.hasData) {
                            return Text(snapshot.data.toString(), style: textStyles.mediumBodyText,);
                          } else {
                            return Text('No data available');
                          }
                        },
                      ),

                    ],
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon( Icons.menu_book_rounded, color: appColors.green, size: 60),
                      Text(
                        "Lessons", // TODO: Lessons or activities? Activities=quiz, practice, reading
                        style: textStyles.mediumBodyText,
                      ),
                      Text("0/6", style: textStyles.mediumBodyText,),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),

          // Current Activity and Lesson Shortcut
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
                        style: textStyles.caption,
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                    onPressed: (){
                      //TODO: Add code to update what is the next lesson for the user
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
          SizedBox(
            height: spacing,
          ),

          // Social Media Norms Lesson
          GestureDetector(
            child: LessonDashboard(lesson: socialMediaNorms),
            onTap: () {
              // Navigate to the Social Media Norms Lesson
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LessonScreen(lessonNumber: socialMediaNorms.lessonNumber)),
              );
            },
          ),

          // Settings Lesson
          GestureDetector(
            child: LessonDashboard(lesson: settings),
            onTap: () {
              // Navigate to the Social Media Norms Lesson
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LessonScreen(lessonNumber: settings.lessonNumber)),
              );
            },
          ),

          // Fake Profile Lesson
          GestureDetector(
            child: LessonDashboard(lesson: fakeProfiles),
            onTap: () {
              // Navigate to the Social Media Norms Lesson
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LessonScreen(lessonNumber: fakeProfiles.lessonNumber)),
              );
            },
          ),

          // Social Tags Lesson
          GestureDetector(
            child: LessonDashboard(lesson: socialTags),
            onTap: () {
              // Navigate to the Social Media Norms Lesson
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LessonScreen(lessonNumber: socialTags.lessonNumber)),
              );
            },
          ),

          // Social Tags Lesson
          GestureDetector(
            child: LessonDashboard(lesson: appropriateInteractions),
            onTap: () {
              // Navigate to the Social Media Norms Lesson
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LessonScreen(lessonNumber: appropriateInteractions.lessonNumber)),
              );
            },
          ),



          // TODO: Delete this buttons later
          // Start Practice
          // OutlinedButton.icon(
          //   label: Text(
          //     "Start Practice",
          //     style: textStyles.bodyTextWhite,
          //   ),
          //   onPressed: (){_scaffoldKey.currentState?.openDrawer();},
          //   style: OutlinedButton.styleFrom(
          //     backgroundColor: appColors.royalBlue,
          //     foregroundColor: Colors.white,
          //   ),
          //   icon: const Icon(Icons.arrow_right_alt),
          // ),
          SizedBox(
            height: spacing,
          ),
        ],
      ),
    );

    // if (activeScreen == 'question-screen') {
    //   screen = PracticeScreen(onSelectAnswer: recordAnswer, quizNumber: 1,);
    // }
    // else if (activeScreen == 'question-screen2') {
    //   screen = PracticeScreen(onSelectAnswer: recordAnswer, quizNumber: 2,);
    // }
    // else if (activeScreen == 'question-screen3') {
    //   screen = PracticeScreen(onSelectAnswer: recordAnswer, quizNumber: 3,);
    // }
    // else if (activeScreen == 'question-screen4') {
    //   screen = PracticeScreen(onSelectAnswer: recordAnswer, quizNumber: 4,);
    // }
    // else if (activeScreen == 'question-screen5') {
    //   screen = PracticeScreen(onSelectAnswer: recordAnswer, quizNumber: 5,);
    // }
    // else if (activeScreen == 'question-screen6') {
    //   screen = PracticeScreen(onSelectAnswer: recordAnswer, quizNumber: 6,);
    // }
    // else if (activeScreen == 'question-screen7') {
    //   screen = PracticeScreen(onSelectAnswer: recordAnswer, quizNumber: 7,);
    // }
    // else if (activeScreen == 'question-screen8') {
    //   screen = PracticeScreen(onSelectAnswer: recordAnswer, quizNumber: 8,);
    // }
    // else if (activeScreen == 'question-screen9') {
    //   screen = PracticeScreen(onSelectAnswer: recordAnswer, quizNumber: 9,);
    // }
    // else if (activeScreen == 'quiz-screen1') {
    //   screen = QuizScreen(onSelectAnswer: recordAnswer1, quizNumber: 1,);
    // }
    // else if (activeScreen == 'quiz-screen2') {
    //   screen = QuizScreen(onSelectAnswer: recordAnswer2, quizNumber: 2,);
    // }
    // else if (activeScreen == 'quiz-screen3') {
    //   screen = QuizScreen(onSelectAnswer: recordAnswer3, quizNumber: 3,);
    // }
    // else if (activeScreen == 'quiz-screen4') {
    //   screen = QuizScreen(onSelectAnswer: recordAnswer4, quizNumber: 4,);
    // }
    // else if (activeScreen == 'quiz-screen5') {
    //   screen = QuizScreen(onSelectAnswer: recordAnswer5, quizNumber: 5,);
    // }
    // else if (activeScreen == 'quiz-screen6') {
    //   screen = QuizScreen(onSelectAnswer: recordAnswer6, quizNumber: 6,);
    // }
    // else if (activeScreen == 'result-screen') {
    //   screen = ResultScreen(
    //     quizNumber: resultNumber,
    //     userAnswers: answers,
    //     endQuiz: returnHomeAndResetQuiz,
    //   );
    // }

    return Scaffold(
        key: _scaffoldKey,
        endDrawer: Drawer(
          child: SafeArea(
            child: Column(
              children: <Widget>[
                const SizedBox(height: 40),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.email,
                      color: appColors.royalBlue,
                      size: 30,
                    ),
                    const SizedBox(width: 20),
                    Text(
                      "${FirebaseAuth.instance.currentUser?.email}",
                      style: textStyles.bodyText,
                    ),
                  ],
                ),

                const SizedBox(height: 40),

                OutlinedButton.icon(
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    // Navigate back to the Sign-In page after signing out
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => SignInPage()),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: appColors.royalBlue,
                    foregroundColor: Colors.white,
                  ),
                  icon: const Icon(Icons.logout),
                  label: const Text("Logout"),
                ),

                const SizedBox(height: 40),

              ],
            ),
          ),
        ),
        // drawer: Drawer(
        //   child: SafeArea(
        //     child: Column(
        //       children: <Widget>[
        //               OutlinedButton.icon(
        //                 onPressed: (){
        //                   changeScreen9();
        //                 },
        //                 style: OutlinedButton.styleFrom(
        //                   backgroundColor: appColors.royalBlue,
        //                   foregroundColor: Colors.white,
        //                 ),
        //                 icon: const Icon(Icons.arrow_right_alt),
        //                 label: const Text("      Start Practice from beginning       "),
        //               ),
        //               OutlinedButton.icon(
        //                   onPressed: (){
        //                     setState(() {
        //                       changeScreen1();
        //                     });
        //                     Navigator.of(context).pop();
        //                   },
        //                   style: OutlinedButton.styleFrom(
        //                     backgroundColor: appColors.royalBlue,
        //                     foregroundColor: Colors.white,
        //                   ),
        //                   icon: const Icon(Icons.arrow_right_alt),
        //                   label: const Text("part 1"),
        //                 ),
        //
        //               OutlinedButton.icon(
        //                 onPressed: (){
        //                   setState(() {
        //                     changeScreen2();
        //                   });
        //                   Navigator.of(context).pop();
        //                 },
        //
        //                 style: OutlinedButton.styleFrom(
        //                   backgroundColor: appColors.royalBlue,
        //                   foregroundColor: Colors.white,
        //                 ),
        //                 icon: const Icon(Icons.arrow_right_alt),
        //                 label: const Text("part 2"),
        //               ),
        //               OutlinedButton.icon(
        //                 onPressed: (){
        //                   setState(() {
        //                     changeScreen3();
        //                   });
        //                   Navigator.of(context).pop();
        //                 },
        //                 style: OutlinedButton.styleFrom(
        //                   backgroundColor: appColors.royalBlue,
        //                   foregroundColor: Colors.white,
        //                 ),
        //                 icon: const Icon(Icons.arrow_right_alt),
        //                 label: const Text("part 3"),
        //               ),
        //               OutlinedButton.icon(
        //                 onPressed: (){
        //                   setState(() {
        //                     changeScreen4();
        //                   });
        //                   Navigator.of(context).pop();
        //                 },
        //                 style: OutlinedButton.styleFrom(
        //                   backgroundColor: appColors.royalBlue,
        //                   foregroundColor: Colors.white,
        //                 ),
        //                 icon: const Icon(Icons.arrow_right_alt),
        //                 label: const Text("part 4"),
        //               ),
        //               OutlinedButton.icon(
        //                 onPressed: (){
        //                   setState(() {
        //                     changeScreen5();
        //                   });
        //                   Navigator.of(context).pop();
        //                 },
        //                 style: OutlinedButton.styleFrom(
        //                   backgroundColor: appColors.royalBlue,
        //                   foregroundColor: Colors.white,
        //                 ),
        //                 icon: const Icon(Icons.arrow_right_alt),
        //                 label: const Text("part 5"),
        //               ),
        //               OutlinedButton.icon(
        //                 onPressed: (){
        //                   setState(() {
        //                     changeScreen6();
        //                   });
        //                   Navigator.of(context).pop();
        //                 },
        //                 style: OutlinedButton.styleFrom(
        //                   backgroundColor: appColors.royalBlue,
        //                   foregroundColor: Colors.white,
        //                 ),
        //                 icon: const Icon(Icons.arrow_right_alt),
        //                 label: const Text("part 6"),
        //               ),
        //               OutlinedButton.icon(
        //                 onPressed: (){
        //                   setState(() {
        //                     changeScreen7();
        //                   });
        //                   Navigator.of(context).pop();
        //                 },
        //                 style: OutlinedButton.styleFrom(
        //                   backgroundColor: appColors.royalBlue,
        //                   foregroundColor: Colors.white,
        //                 ),
        //                 icon: const Icon(Icons.arrow_right_alt),
        //                 label: const Text("part 7"),
        //               ),
        //               OutlinedButton.icon(
        //                 onPressed: (){
        //                   setState(() {
        //                     changeScreen8();
        //                   });
        //                   Navigator.of(context).pop();
        //                 },
        //                 style: OutlinedButton.styleFrom(
        //                   backgroundColor: appColors.royalBlue,
        //                   foregroundColor: Colors.white,
        //                 ),
        //                 icon: const Icon(Icons.arrow_right_alt),
        //                 label: const Text("part 8"),
        //               ),
        //             ],
        //           ),
        //         ),
        // ),
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
