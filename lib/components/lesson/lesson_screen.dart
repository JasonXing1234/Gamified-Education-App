import 'package:flutter/material.dart';
import 'package:quiz/components/quiz_results_screen.dart';
import 'package:quiz/components/lesson/lesson.dart';
import 'package:quiz/components/lesson/all_lessons.dart';
import 'package:quiz/components/reading/readings_screen.dart';
import 'package:quiz/components/rewards/all_characters.dart';
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

    if (widget.lessonNumber == socialMediaNorms.lessonNumber) {
      lesson = socialMediaNorms;
    }
    else if (widget.lessonNumber == settings.lessonNumber) {
      lesson = settings;
    }
    else if (widget.lessonNumber == fakeProfiles.lessonNumber) {
      lesson = fakeProfiles;
    }
    else if (widget.lessonNumber == socialTags.lessonNumber) {
      lesson = socialTags;
    }
    else if (widget.lessonNumber == appropriateInteractions.lessonNumber) {
      lesson = appropriateInteractions;
    }
    else if (widget.lessonNumber == socialMediaVSReality.lessonNumber) {
      lesson = socialMediaVSReality;
    }
    else {
      lesson = Lesson("LESSON", lockedCharacter, 0);
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

              StatsNotebook(lesson: lesson, textStyles: textStyles),

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
                    text: "DRILL", // Drill is practice
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

class StatsNotebook extends StatelessWidget {
  const StatsNotebook({
    super.key,
    required this.lesson,
    required this.textStyles,
  });

  final Lesson lesson;
  final AppTextStyles textStyles;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 375,
      height: 200,
      child: GridView.extent(
        maxCrossAxisExtent: 300, // Max width of character and notebook
        mainAxisSpacing: 1, // Space between rows
        crossAxisSpacing: 1, // Space between columns
        children: [
          lesson.getCurrentPhoto() == "no" ? const SizedBox.shrink() : Image.asset(lesson.getCurrentPhoto()),
          Stack(
              children: [
                Image.asset("assets/images/notebook_v1.png"),
                Center(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 2),
                        child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10,),
                          Text(lesson.character.name, style: textStyles.caption,),
                          const SizedBox(height: 5,),
                          Text("Phase: ${lesson.character.currentPhase.name}", style: textStyles.caption,),
                          const SizedBox(height: 5,),
                          Text("Weight: ${lesson.character.stats[lesson.character.currentPhase]?["weight"]}", style: textStyles.caption,),
                          const SizedBox(height: 5,),
                          Text("Height: ${lesson.character.stats[lesson.character.currentPhase]?["height"]}", style: textStyles.caption,),
                        ],
                      ),
                    ),
                ),
              ]
          ),
        ],
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