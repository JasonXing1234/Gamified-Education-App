import 'package:flutter/material.dart';
import 'package:quiz/styles/app_colors.dart';
import 'package:quiz/styles/text_styles.dart';

class Lesson extends StatefulWidget {
  const Lesson({
    super.key,
    required this.lessonTitle
  });

  final String lessonTitle;

  // Unlocked features
  @override
  State<Lesson> createState() { return _LessonState(); }
}

class _LessonState extends State<Lesson> {

  final AppTextStyles textStyles = AppTextStyles();
  final AppColors appColors = const AppColors();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Padding(
            padding: const EdgeInsets.only(top: 30.0), // Adjust the top padding of title
            child: Text(
              widget.lessonTitle,
              style: textStyles.heading1,
            ),
          ),
        ),
        body: const Center(
          child: Text(
            'Hello, World!',
            style: TextStyle(fontSize: 24),
          ),
        ),
    );
  }


}