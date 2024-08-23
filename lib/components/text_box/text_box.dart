import 'package:flutter/material.dart';
import 'package:quiz/models/quiz_question.dart';
import 'package:quiz/models/quiz_quiz.dart';

import '../../styles/text_styles.dart';

class TextBox extends StatelessWidget {
  TextBox({
    super.key,
    required this.currentQuestion,
    this.color = Colors.black
  });

  final dynamic currentQuestion;

  Color color;

  final AppTextStyles textStyles = AppTextStyles();

  void readText() {
    // Read currentQuestion to the user
    // If sound is off show warning/notification to the user
  }

  @override
  Widget build(BuildContext context) {

    String text = "";

    if(currentQuestion is String) {
      text = currentQuestion;
    }
    else if (currentQuestion is QuizQuiz || currentQuestion is QuizQuestion) {
      text = currentQuestion.question;
    }

    return Container(
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: Colors.white, // Box background color
        borderRadius: BorderRadius.circular(15.0), // Rounded corners
        border: Border.all( // Add a border to the box
          color: color, // Border color
          width: 4.0, // Border width
        ),
      ),
      child: Column(
        children: [
          Text(
            text,
            textAlign: TextAlign.left,
            style: textStyles.bodyTextCustom(color, 24),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: TextButton.icon(
              onPressed: readText,
              icon: const Icon(Icons.play_arrow),
              label: const Text("listen to text"),
              style: TextButton.styleFrom(
                foregroundColor: color, // Text color
                textStyle: textStyles.caption,
              ),
            ),
          ),
        ],
      )
    );
  }
}
