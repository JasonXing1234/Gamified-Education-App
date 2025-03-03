import 'package:flutter/material.dart';
import 'package:quiz/components/lesson/lesson.dart';
import 'package:quiz/components/progress_bar/semi_circle_progress_bar.dart';
import 'package:quiz/components/rewards/all_animals.dart';
import 'package:quiz/styles/app_colors.dart';
import 'package:quiz/styles/text_styles.dart';

import '../rewards/animal.dart';

class LessonDashboard extends StatefulWidget {
  const LessonDashboard({
    super.key,
    required this.lesson,
    required this.lessonNumber,
    required this.ifEachModuleComplete, // Add ifEachModuleComplete list
  });

  final Lesson lesson;
  final int lessonNumber;
  final List<List<bool>> ifEachModuleComplete; // Nested list for module progress

  @override
  State<LessonDashboard> createState() => _LessonDashboardState();
}

class _LessonDashboardState extends State<LessonDashboard> {
  final AppTextStyles textStyles = AppTextStyles();
  final AppColors appColors = AppColors();

  @override
  void initState() {
    super.initState();
    _checkAndUnlockLesson();
  }

  void _checkAndUnlockLesson() {
    if (widget.lessonNumber != 1 && widget.lessonNumber - 1 < widget.ifEachModuleComplete.length) {
      List<bool> moduleProgress = widget.ifEachModuleComplete[widget.lessonNumber - 2];

      if (moduleProgress.length > 1 && moduleProgress[0] && moduleProgress[1]) {
        setState(() {
          if (widget.lesson.animal.currentPhase == Phase.locked) {
            widget.lesson.animal.currentPhase = Phase.unknown;
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isUnlocked = widget.lesson.animal.currentPhase != Phase.locked;
    double progress = isUnlocked ? widget.lesson.progress : 0.0;

    return Stack(
      children: [
        Center(
          child: Container(
            width: 350,
            height: 300,
            decoration: BoxDecoration(
              color: isUnlocked ? appColors.lightGrey : appColors.grey,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 0),
                child: Text(
                  widget.lesson.title,
                  style: textStyles.customText(Colors.black, 24, FontWeight.bold),
                ),
              ),
              Stack(
                children: [
                  Center(
                    child: SemiCircleProgressBar(progress: progress), // Update based on unlock condition
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 0),
                    child: Center(
                      child: Image.asset(
                        widget.lesson.getCurrentPhoto(),
                        scale: 2,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}