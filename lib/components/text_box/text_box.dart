import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../styles/text_styles.dart';

class TextBox extends StatelessWidget {
  TextBox({
    super.key,
    required this.currentQuestion,
  });

  final dynamic currentQuestion;

  final AppTextStyles textStyles = AppTextStyles();

  void readText() {
    // Read currentQuestion to the user
    // If sound is off show warning/notification to the user
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: Colors.white, // Box background color
        borderRadius: BorderRadius.circular(15.0), // Rounded corners
        border: Border.all( // Add a border to the box
          color: Colors.black, // Border color
          width: 4.0, // Border width
        ),
      ),
      child: Column(
        children: [
          Text(
            currentQuestion.question,
            textAlign: TextAlign.left,
            style: textStyles.bodyText,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: TextButton.icon(
              onPressed: readText,
              icon: const Icon(Icons.play_arrow),
              label: const Text("listen to text"),
              style: TextButton.styleFrom(
                foregroundColor: Colors.black, // Text color
                textStyle: textStyles.caption,
              ),
            ),
          ),
        ],
      )
    );
  }
}
