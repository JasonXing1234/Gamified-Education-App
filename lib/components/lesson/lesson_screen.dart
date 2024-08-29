import 'package:flutter/material.dart';
import 'package:quiz/components/quiz_results_screen.dart';
import 'package:quiz/components/lesson/lesson.dart';
import 'package:quiz/components/lesson/lessons.dart';
import 'package:quiz/components/reading/readings_screen.dart';
import 'package:quiz/styles/app_colors.dart';
import 'package:quiz/styles/text_styles.dart';

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

  @override
  Widget build(BuildContext context) {

    // Readings and quizzes start with 1, but lessons start at 0
    // Lesson lesson = lessons[widget.lessonNumber - 1];
    Lesson lesson;

    if (widget.lessonNumber == 1) {
      lesson = socialMediaNorms;
    }
    else if (widget.lessonNumber == 2) {
      lesson = settings;
    }
    else if (widget.lessonNumber == 3) {
      lesson = fakeProfiles;
    }
    else if (widget.lessonNumber == 4) {
      lesson = socialTags;
    }
    else if (widget.lessonNumber == 5) {
      lesson = appropriateInteractions;
    }
    else if (widget.lessonNumber == 6) {
      lesson = socialMediaVSReality;
    }
    else {
      lesson = Lesson("LESSON", [], 0);
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
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
          child: Column(
            children: [
              // Row of image and stats
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  lesson.getCurrentPhoto() == "no" ? const SizedBox.shrink() : Image.asset(lesson.getCurrentPhoto()),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              // row of buttons for Pre-quiz, readings, post-quiz, practice
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ActivityButton(
                    text: "PREP",
                    onTap:
                        (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ReadingsScreen(readingNumber: widget.lessonNumber)),
                      );
                    },
                  ),
                  ActivityButton(
                    text: "READ",
                    onTap:
                        (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ReadingsScreen(readingNumber: widget.lessonNumber)),
                      );
                    },
                  ),
                  ActivityButton(
                    text: "QUIZ",
                    onTap:
                        (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => QuizResultScreen(lessonNumber: widget.lessonNumber, activeScreen: "quiz-screen",))
                      );
                    },
                  ),
                  ActivityButton(
                    text: "PLAY", // Play is practice
                    onTap:
                        (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => QuizResultScreen(lessonNumber: widget.lessonNumber, activeScreen: "quiz-screen",))
                      );
                    },
                  ),
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
        ),
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
    required this.text,
    required this.onTap,
  });

  final AppColors appColors = const AppColors();
  final AppTextStyles textStyles = AppTextStyles();

  final String text;
  final void Function() onTap;

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