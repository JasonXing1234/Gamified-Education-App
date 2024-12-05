
import 'package:flutter/material.dart';

import 'lesson.dart';


class CompletedLessonScreen extends StatefulWidget {
  const CompletedLessonScreen({
    super.key,
    required this.lesson,
  });

  final Lesson lesson;

  // Unlocked features
  @override
  State<CompletedLessonScreen> createState() { return _CompletedLessonScreenState(); }
}

class _CompletedLessonScreenState extends State<CompletedLessonScreen> {

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold();
  }

}