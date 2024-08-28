import 'package:flutter/material.dart';
import 'package:quiz/components/lesson/lesson.dart';
import 'package:quiz/components/lesson/lessons.dart';
import 'package:quiz/components/quiz/quiz_questions/quiz1.dart';
import 'package:quiz/components/quiz/quiz_screen.dart';
import 'package:quiz/components/reading/readings_screen.dart';
import 'package:quiz/styles/app_colors.dart';
import 'package:quiz/styles/text_styles.dart';

import '../result_screen.dart';

class LessonScreen extends StatefulWidget {
  const LessonScreen({
    super.key,
    required this.lessonNumber,
  });

  final int lessonNumber;

  // Unlocked features
  @override
  State<LessonScreen> createState() { return _LessonScreenState(); }
}

class _LessonScreenState extends State<LessonScreen> {

  final AppTextStyles textStyles = AppTextStyles();
  final AppColors appColors = const AppColors();


  String activeScreen = 'lesson-screen';

  List<String> answers = [];
  int resultNumber = 0;

  void recordAnswer1(String answer) {
    setState(() {
      answers.add(answer);
      if (quiz1.length == answers.length) {
        print("DEBUG: TIME TO SHOW RESULTS");
        // activeScreen = 'result-screen';
        resultNumber = 1;

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ResultScreen(
            quizNumber: resultNumber,
            userAnswers: answers,
            restartQuiz: returnHomeAndResetQuiz,
          )),
        );


      }
    });
  }

  void returnHomeAndResetQuiz() {
    setState(() {
      answers = [];
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => LessonScreen(lessonNumber: widget.lessonNumber)),
            (route) => false, // This removes all previous routes
      );
    });
  }

  @override
  Widget build(BuildContext context) {

    final Lesson lesson = lessons[widget.lessonNumber];

    Widget screen;

    // if (activeScreen == "quiz-screen") {
    //   screen = QuizScreen(onSelectAnswer: recordAnswer1, quizNumber: widget.lessonNumber);
    // }
    if (activeScreen == 'result-screen') {
      screen = ResultScreen(
        quizNumber: resultNumber,
        userAnswers: answers,
        restartQuiz: returnHomeAndResetQuiz,
      );
    }
    else {
      screen = Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
        child: Column(
          children: [
            // Row of image and stats
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Image.asset(lesson.getCurrentPhoto()),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            // row of buttons for Pre-quiz, readings, post-quiz, practice
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ActivityButton(onTap:
                    (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ReadingsScreen(readingNumber: widget.lessonNumber)),
                      );
                    },
                    text: "PREP"),
                ActivityButton(onTap:
                    (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ReadingsScreen(readingNumber: widget.lessonNumber)),
                    );
                },
                    text: "READ"),
                ActivityButton(onTap:
                    (){
                      // Push a results page?
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ResultScreen(
                            quizNumber: resultNumber,
                            userAnswers: answers,
                            restartQuiz: returnHomeAndResetQuiz,
                          ))
                      );

                      // Then push the quiz?
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => QuizScreen(onSelectAnswer: recordAnswer1, quizNumber: widget.lessonNumber))
                      );
                    },
                    text: "QUIZ"),
                ActivityButton(onTap:
                    (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ReadingsScreen(readingNumber: widget.lessonNumber))
                      );
                    },
                    text: "PLAY"), // Play is the practice
              ],
            ),
            const SizedBox(
              height: 20,
            ),

            // Scrollable Accessory List
            SizedBox(
              height: 350, // Set a fixed height for the GridView
              width: 350,
              child: GridView.extent(
                maxCrossAxisExtent: 100, // Max width of each tile
                mainAxisSpacing: 7, // Space between rows
                crossAxisSpacing: 7, // Space between columns
                children: List.generate(20, (index) {
                  return const Center(
                    child: Accessory(imageName: "assets/character_images/sunglasses.png"),
                  );
                }),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Padding(
            padding: const EdgeInsets.only(top: 30.0), // Adjust the top padding of title
            child: Text(
              lesson.title,
              style: textStyles.heading1,
            ),
          ),
        ),
        body: screen,
    );
  }
}

class Accessory extends StatelessWidget {
  const Accessory({
    super.key,
    required this.imageName,
  });

  final String imageName;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        border: Border.all(color: Colors.black, width: 3.0),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Center(
        child: Image.asset(
          imageName,
          scale: 2,
        ),
      ),
    );
  }
}

class ActivityButton extends StatelessWidget {
  ActivityButton({
    super.key,
    required this.onTap,
    required this.text,
  });

  final AppColors appColors = const AppColors();
  final AppTextStyles textStyles = AppTextStyles();

  final void Function() onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Padding for text and border
        //fixedSize: const Size(150, 50),
        backgroundColor: appColors.royalBlue,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text(
        text,
        style: textStyles.smallBodyTextWhite,
        textAlign: TextAlign.center,
      ),
    );
  }
}