import 'package:flutter/material.dart';

class AnswerButton extends StatelessWidget {

  const AnswerButton({
    super.key,
    required this.color,
    required this.answerText,
    required this.onTap,
  });

  final Color color;
  final String answerText;
  final void Function() onTap;

  @override
  build(context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
        backgroundColor: color,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
      ),
      child: Text(
        answerText,
        textAlign: TextAlign.center,
      ),
    );
  }
}
