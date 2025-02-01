import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:quiz/components/lesson/completed_lesson_screen.dart';
import 'package:quiz/components/lesson/lesson_dashboard.dart';
import 'package:quiz/components/lesson/all_lessons.dart';
import 'package:quiz/components/lesson/lesson_screen.dart';

import '../styles/app_colors.dart';
import '../styles/text_styles.dart';
import 'components/menu/menu.dart';
import 'components/practice_results_screen.dart';

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

  // Function to show the dialog
  void _showOptionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Select a lesson to practice'),
          children: <Widget>[
            SimpleDialogOption(
              child: const Text("Tutorial & Set Up"),
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  //TODO: Fill in code
                });
              },
            ),
            SimpleDialogOption(
              child: const Text("Social Media Norms"),
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PracticeResultScreen(lesson: socialMediaNorms, activeScreen: "practice-screen",))
                );
              },
            ),
            SimpleDialogOption(
              child: const Text("Settings"),
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PracticeResultScreen(lesson: settings, activeScreen: "practice-screen",))
                );
              },
            ),
            SimpleDialogOption(
              child: const Text("Fake Profiles"),
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PracticeResultScreen(lesson: fakeProfiles, activeScreen: "practice-screen",))
                );
              },
            ),
            SimpleDialogOption(
              child: const Text("Social Tags"),
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PracticeResultScreen(lesson: fakeProfiles, activeScreen: "practice-screen",))
                );
              },
            ),
            SimpleDialogOption(
              child: const Text("Interaction Etiquette"),
              onPressed: () {
                Navigator.pop(context);
                //todo: broken????
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PracticeResultScreen(lesson: appropriateInteractions, activeScreen: "practice-screen",))
                );
              },
            ),
          ],
        );
      },
    );
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
          ShortcutWidget(
            textStyles: textStyles,
            appColors: appColors,
            buttonShortcut: (context){}, //TODO: Add code to update what is the next lesson for the user
            mainText: "Next Activity",
            subtitle: "Social Media Norms",
            buttonText: "READING", //TODO: replace with logic about what text should be
            isDisabled: true,
          ),

          SizedBox(
            height: spacing,
          ),

          // Practice & Earn Items
          ShortcutWidget(
            textStyles: textStyles,
            appColors: appColors,
            buttonShortcut: (context) {
              _showOptionDialog(context!);
            },
            mainText: "Earn Rewards",
            subtitle: "For Your Dragons",
            buttonText: "PRACTICE",
            isDisabled: false,
          ),

          SizedBox(
            height: spacing,
          ),

          ShortcutWidget(
              textStyles: textStyles,
              appColors: appColors,
              buttonShortcut: (context) {  // Accepts context
                if (context != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CompletedLessonScreen(lesson: socialMediaNorms)),
                  );
                }
              },
              mainText: "TESTING",
              subtitle: "Remove later",
              buttonText: "COMPLETED",
              isDisabled: false
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

class ShortcutWidget extends StatelessWidget {
  const ShortcutWidget({
    super.key,
    required this.textStyles,
    required this.appColors,
    required this.buttonShortcut,
    required this.mainText,
    required this.subtitle,
    required this.buttonText,
    required this.isDisabled,
  });

  final AppTextStyles textStyles;
  final AppColors appColors;
  final void Function(BuildContext?) buttonShortcut;
  final String mainText;
  final String subtitle;
  final String buttonText;
  final bool isDisabled;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                  mainText,
                  textAlign: TextAlign.left,
                  style: textStyles.mediumBodyText,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  subtitle,
                  textAlign: TextAlign.left,
                  style: textStyles.caption,
                ),
              ],
            ),
            const SizedBox(
              width: 25,
            ),
            ElevatedButton(
              onPressed: isDisabled ? (){} : () => buttonShortcut(context), //Needs to be a function that calls a function so we can pass in build context
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10), // Padding for text and border
                //fixedSize: const Size(150, 50),
                backgroundColor: isDisabled ? appColors.grey : appColors.royalBlue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: Text(
                buttonText,
                style: textStyles.smallBodyTextWhite,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
