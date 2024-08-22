import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class TextBox extends StatelessWidget {
  const TextBox({
    super.key,
    required this.currentQuestion,
  });

  final dynamic currentQuestion;

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
      child: Text(
        currentQuestion.question,
        textAlign: TextAlign.left,
        style: GoogleFonts.lato(
          color: Colors.black,
          fontSize: 24,
        ),
      ),
    );
  }
}