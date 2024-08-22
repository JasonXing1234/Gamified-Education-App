import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextBox extends StatelessWidget {
  const TextBox({
    super.key,
    required this.currentQuestion,
  });

  final dynamic currentQuestion;

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
            style: GoogleFonts.lato(
              color: Colors.black,
              fontSize: 24,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
            child: TextButton.icon(
              onPressed: readText,
              icon: const Icon(Icons.play_arrow),
              label: const Text("listen to text"),
              style: TextButton.styleFrom(
                foregroundColor: Colors.black, // Text color
              ),
            ),
          ),
        ],
      )
    );
  }
}
