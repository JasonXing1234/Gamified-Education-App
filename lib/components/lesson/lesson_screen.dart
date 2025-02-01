import 'package:flutter/material.dart';
import 'package:quiz/components/lesson/completed_lesson_screen.dart';
import 'package:quiz/components/lesson/in_progress_lesson_screen.dart';

import 'lesson.dart';


class LessonScreen extends StatefulWidget {
  const LessonScreen({
    super.key,
    required this.lesson,
  });

  final Lesson lesson;

  @override
  State<StatefulWidget> createState() => _LessonScreennState();

}

class _LessonScreennState extends State<LessonScreen> {
  @override
  Widget build(BuildContext context) {

    Widget screen = const Center(
      child: Text('Open Blank Scaffold for Incomplete or Complete'),
    );

    if (widget.lesson.progress < 1.0) {
      screen = InProgressLessonScreen(lesson: widget.lesson);
    }
    else {
      screen = CompletedLessonScreen(lesson: widget.lesson);
    }

    return Scaffold(
      body: screen,
    );
  }

}