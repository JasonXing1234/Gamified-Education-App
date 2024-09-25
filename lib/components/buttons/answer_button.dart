import 'package:flutter/material.dart';

class AnswerButton extends StatelessWidget {

  const AnswerButton({
    super.key,
    required this.color,
    required this.borderThickness,
    required this.answerText,
    required this.onTap,
  });

  final Color color;
  final double borderThickness;
  final String answerText;
  final void Function() onTap;

  @override
  build(context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
        backgroundColor: Colors.white,
        foregroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide( // Add border with different color and width
            color: color, // Change this to the color you want for the border
            width: borderThickness, // Set the width of the border
          ),
        ),
      ),
      child: Text(
        answerText,
        style: const TextStyle(fontSize: 18,),
        textAlign: TextAlign.center,
      ),
    );
  }
}
