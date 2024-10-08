import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quiz/components/lesson/lesson_dashboard.dart';
import 'package:quiz/components/lesson/lesson_screen.dart';
import 'package:quiz/components/lesson/all_lessons.dart';



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
  Future<int?>? numTickets;
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
    numTickets = _fetchReadingList();
  }

  Future<int?> _fetchReadingList() async {
    if (user2 != null) {
      try {
        DataSnapshot snapshot = await _database
            .child('profile')
            .child(user2!.uid)
            .child('numTickets')
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
              const SizedBox(
                width: 35,
              ),
              Text(
                "Name",
                style: textStyles.bodyText,
              ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  _scaffoldKey.currentState?.openEndDrawer();
                },
                icon: Icon(
                    Icons.menu,
                  size: 35,
                  color: appColors.royalBlue
                ),
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
          // Padding(
          //     padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          //   child: Container(
          //     padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
          //     decoration: BoxDecoration(
          //       shape: BoxShape.rectangle,
          //       border: Border.all(color: Colors.black, width: 3.0),
          //       borderRadius: BorderRadius.circular(20.0),
          //     ),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: [
          //         Column(
          //           mainAxisSize: MainAxisSize.min,
          //           children: [
          //             FaIcon(FontAwesomeIcons.ticket, color: appColors.yellow, size: 60,),
          //             // Icon( Icons.stars, color: appColors.yellow, size: 60,),
          //             Text("Tickets", style: textStyles.mediumBodyText,),
          //             FutureBuilder<int?>(
          //               future: _fetchReadingList(),
          //               builder: (context, snapshot) {
          //                 if (snapshot.connectionState == ConnectionState.waiting) {
          //                   return const CircularProgressIndicator();
          //                 } else if (snapshot.hasError) {
          //                   return Text('Error: ${snapshot.error}');
          //                 } else if (snapshot.hasData) {
          //                   return Text(snapshot.data.toString(), style: textStyles.mediumBodyText,);
          //                 } else {
          //                   return Text("0", style: textStyles.mediumBodyText,);
          //                 }
          //               },
          //             ),
          //
          //           ],
          //         ),
          //         const SizedBox(
          //           width: 50,
          //         ),
          //         Column(
          //           mainAxisSize: MainAxisSize.min,
          //           children: [
          //             Icon( Icons.menu_book_rounded, color: appColors.green, size: 60),
          //             // TODO: Add logic to record the lessons (6) or activities (6*4) completed
          //             Text(
          //               "Lessons",
          //               style: textStyles.mediumBodyText,
          //             ),
          //             Text("0/6", style: textStyles.mediumBodyText,),
          //           ],
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          // const SizedBox(
          //   height: 20,
          // ),

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
                    width: 25,
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
