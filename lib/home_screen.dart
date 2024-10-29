import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:quiz/components/lesson/lesson_dashboard.dart';
import 'package:quiz/components/lesson/lesson_screen.dart';
import 'package:quiz/components/lesson/all_lessons.dart';

import '../styles/app_colors.dart';
import '../styles/text_styles.dart';
import 'components/menu/menu.dart';

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
                        "Next Activity",
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
                      "POST-QUIZ",
                      style: textStyles.smallBodyTextWhite,
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

          // Tutorial Lesson
          GestureDetector(
            child: LessonDashboard(lesson: tutorial),
            onTap: () {
              // Navigate to the Tutorial Lesson
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LessonScreen(lesson: tutorial)),
              );
            },
          ),

          // Social Media Norms Lesson
          GestureDetector(
            child: LessonDashboard(lesson: socialMediaNorms),
            onTap: () {
              // Navigate to the Social Media Norms Lesson
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LessonScreen(lesson: socialMediaNorms)),
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
                MaterialPageRoute(builder: (context) => LessonScreen(lesson: settings)),
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
                MaterialPageRoute(builder: (context) => LessonScreen(lesson: fakeProfiles)),
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
                MaterialPageRoute(builder: (context) => LessonScreen(lesson: socialTags)),
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
                MaterialPageRoute(builder: (context) => LessonScreen(lesson: appropriateInteractions)),
              );
            },
          ),

          SizedBox(
            height: spacing,
          ),
        ],
      ),
    );

    return Scaffold(
        key: _scaffoldKey,
        endDrawer: MenuDrawer(),

        body: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: screen,
        ),
      );
  }
}
