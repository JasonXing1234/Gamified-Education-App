import 'package:flutter/material.dart';
import 'package:quiz/components/lesson/lesson.dart';
import 'package:quiz/components/progress_bar/semi_circle_progress_bar.dart';
import 'package:quiz/components/rewards/all_animals.dart';
import 'package:quiz/styles/app_colors.dart';
import 'package:quiz/styles/text_styles.dart';

import '../rewards/animal.dart';

class LessonDashboard extends StatefulWidget {
  const LessonDashboard({super.key, required this.lesson});

  final Lesson lesson;

  @override
  State<LessonDashboard> createState() => _LessonDashboardState();
}

class _LessonDashboardState extends State<LessonDashboard> {

  final AppTextStyles textStyles = AppTextStyles();
  final AppColors appColors = AppColors();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Container(
            width: 350,
            height: 300,
            //padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            decoration: BoxDecoration(
              color: widget.lesson.animal.currentPhase == Phase.locked ? appColors.grey : appColors.lightGrey,
              shape: BoxShape.rectangle,
              // border: Border.all(color: Colors.black, width: 3.0),
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
                    style: textStyles.customText(Colors.black, 24, FontWeight.bold)//textStyles.bodyText,
                ),
              ),
              Stack(
                children: [
                  Center(
                    child: SemiCircleProgressBar(progress: widget.lesson.animal.currentPhase == Phase.locked ? 0.0 : widget.lesson.progress), // 75% progress,
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