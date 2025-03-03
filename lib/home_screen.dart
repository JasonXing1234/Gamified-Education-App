import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:quiz/components/lesson/completed_lesson_screen.dart';
import 'package:quiz/components/lesson/lesson_dashboard.dart';
import 'package:quiz/components/lesson/all_lessons.dart';
import 'package:quiz/components/lesson/lesson_screen.dart';

import '../styles/app_colors.dart';
import '../styles/text_styles.dart';
import 'SQLITE/sqliteHelper.dart';
import 'components/lesson/lesson.dart';
import 'components/menu/menu.dart';
import 'components/practice_results_screen.dart';
import 'components/quiz_results_screen.dart';
import 'components/reading_results_screen.dart';
import 'models/UserModel.dart';

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
  final DatabaseHelper _dbHelper = DatabaseHelper();
  final AppTextStyles textStyles = AppTextStyles();
  final AppColors appColors = const AppColors();
  Map<String, int>? nextTask;
  String buttonText = "Next Task";
  bool isDisabled = true;
  final double spacing = 30;
  UserModel? user;
  List<List<bool>> isEachModuleComplete = [];

  @override
  void initState() {
    super.initState();
    // Fetch readings once the widget is initialized
    numTickets = _fetchReadingList();
    _initializeHome();
  }

  Future<void> _initializeHome() async {
    await _initializeUser(); // Ensure user is set before initializing the attempt
    await fetchAndSetModuleProgress(); // Now user will not be null
    await fetchModuleCompletionStatus();
  }

  Future<void> _initializeUser() async {
    user = await _dbHelper.getLoggedInUser();
  }

  Future<int?> _fetchReadingList() async {
    if (user != null) {
      try {
        DataSnapshot snapshot = await _database
            .child('profile')
            .child(user!.userId!)
            .child('numTickets')
            .get();

        if (snapshot.value != null) {
            return snapshot.value as int;
        }

      } catch (e) {
        print('Error fetching reading list: $e');
      }
    }
  }

  Future<List<List<bool>>> fetchModuleCompletionStatus() async {
    if (user == null) return [];

    List<List<bool>> fetchedData = await _dbHelper.getModuleCompletionStatus(user!.userId!);

    setState(() {
      isEachModuleComplete = fetchedData;
    });

    return fetchedData;
  }


  Future<void> fetchAndSetModuleProgress() async {
    String userId = user!.userId!;
    Map<int, double> progressData = await _dbHelper.getModuleProgress(userId);

    setState(() {
      for (var lesson in allLessons) {
        lesson.progress = progressData[lesson.lessonNumber] ?? 0.0;
      }
    });
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
              child: const Text("Random Questions"),
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
                    MaterialPageRoute(builder: (context) => PracticeResultScreen(lesson: socialMediaNorms, activeScreen: "practice-screen", practiceNumber: 1,))
                );
              },
            ),
            SimpleDialogOption(
              child: const Text("Settings"),
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PracticeResultScreen(lesson: settings, activeScreen: "practice-screen", practiceNumber: 2,))
                );
              },
            ),
            SimpleDialogOption(
              child: const Text("Fake Profiles"),
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PracticeResultScreen(lesson: fakeProfiles, activeScreen: "practice-screen", practiceNumber: 3,))
                );
              },
            ),
            SimpleDialogOption(
              child: const Text("Social Tags"),
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PracticeResultScreen(lesson: fakeProfiles, activeScreen: "practice-screen", practiceNumber: 4,))
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
                    MaterialPageRoute(builder: (context) => PracticeResultScreen(lesson: appropriateInteractions, activeScreen: "practice-screen", practiceNumber: 5,))
                );
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> fetchNextTask() async {
    final task = await _dbHelper.getNextIncompleteTask("user123");

    if (task != null) {
      setState(() {
        int moduleIndex = task['moduleIndex']!;
        int taskIndex = task['taskIndex']!;
        String taskType = taskIndex == 0 ? "Reading" : "Quiz";

        buttonText = "$taskType ${moduleIndex + 1}";
        isDisabled = false;
        nextTask = task;
      });
    } else {
      setState(() {
        buttonText = "All Tasks Complete!";
        isDisabled = true;
      });
    }
  }

  void _handleButtonPress(BuildContext context) {
    if (nextTask == null) return;

    int moduleIndex = nextTask!['moduleIndex']!;
    int taskIndex = nextTask!['taskIndex']!;
    Lesson selectedLesson = allLessons[moduleIndex];

    if (taskIndex == 0) {
      // Navigate to Reading
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ReadingResultScreen(lesson: selectedLesson, activeScreen: "reading-screen"),
        ),
      );
    } else {
      // Navigate to Quiz
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => QuizResultScreen(lesson: selectedLesson, activeScreen: "quiz-screen"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: MenuDrawer(),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(color: Colors.white),
        child: RefreshIndicator(
    onRefresh: () async {
    print("🔄 Refreshing module completion status...");
    await fetchModuleCompletionStatus(); // Re-fetch the module status
    await fetchAndSetModuleProgress(); // Optional: Refresh progress too
    setState(() {}); // Force UI rebuild
    },
    child:
        FutureBuilder<List<List<bool>>>(
          future: fetchModuleCompletionStatus(), // Fetch progress dynamically
          builder: (context, AsyncSnapshot<List<List<bool>>> snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            List<List<bool>> fetchedModuleCompletion = snapshot.data!;

            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const SizedBox(width: 35),
                      Text(
                        user?.userName ?? "Name",
                        style: textStyles.bodyText,
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          _scaffoldKey.currentState?.openEndDrawer();
                        },
                        icon: Icon(Icons.menu, size: 35, color: appColors.royalBlue),
                      ),
                      const SizedBox(width: 35),
                    ],
                  ),
                  const SizedBox(height: 10),

                  ShortcutWidget(
                    textStyles: textStyles,
                    appColors: appColors,
                    buttonShortcut: (context) {
                      _handleButtonPress(context!);
                    },
                    mainText: "Next Activity",
                    subtitle: "Social Media Norms",
                    buttonText: buttonText,
                    isDisabled: false,
                  ),

                  SizedBox(height: spacing),

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

                  SizedBox(height: spacing),

                  GestureDetector(
                    child: LessonDashboard(
                      lesson: tutorial,
                      lessonNumber: 1,
                      ifEachModuleComplete: fetchedModuleCompletion,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LessonScreen(lesson: tutorial)),
                      );
                    },
                  ),

                  GestureDetector(
                    child: LessonDashboard(
                      lesson: socialMediaNorms,
                      lessonNumber: 2,
                      ifEachModuleComplete: fetchedModuleCompletion,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LessonScreen(lesson: socialMediaNorms)),
                      );
                    },
                  ),

                  GestureDetector(
                    child: LessonDashboard(
                      lesson: settings,
                      lessonNumber: 3,
                      ifEachModuleComplete: fetchedModuleCompletion,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LessonScreen(lesson: settings)),
                      );
                    },
                  ),

                  GestureDetector(
                    child: LessonDashboard(
                      lesson: fakeProfiles,
                      lessonNumber: 4,
                      ifEachModuleComplete: fetchedModuleCompletion,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LessonScreen(lesson: fakeProfiles)),
                      );
                    },
                  ),

                  GestureDetector(
                    child: LessonDashboard(
                      lesson: socialTags,
                      lessonNumber: 5,
                      ifEachModuleComplete: fetchedModuleCompletion,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LessonScreen(lesson: socialTags)),
                      );
                    },
                  ),

                  GestureDetector(
                    child: LessonDashboard(
                      lesson: appropriateInteractions,
                      lessonNumber: 6,
                      ifEachModuleComplete: fetchedModuleCompletion,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LessonScreen(lesson: appropriateInteractions)),
                      );
                    },
                  ),

                  SizedBox(height: spacing),
                ],
              ),
            );
          },
        ),
      ),
  ));
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
