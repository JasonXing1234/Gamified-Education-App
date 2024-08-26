import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz/styles/app_colors.dart';
import 'package:quiz/styles/text_styles.dart';

class StartScreen extends StatelessWidget {
  StartScreen(this.changeScreen, {super.key});

  final void Function() changeScreen;

  final AppTextStyles textStyles = AppTextStyles();
  final AppColors appColors = const AppColors();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/quiz-logo.png',
            width: 300,
            color: appColors.grey,
          ),
          const SizedBox(
            height: 40,
          ),
          Text(
            "Learn Flutter the fun way!",
            textAlign: TextAlign.center,
            style: GoogleFonts.monoton(
              fontSize: 28,
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          OutlinedButton.icon(
            onPressed: null,
            style: OutlinedButton.styleFrom(
              backgroundColor: appColors.royalBlue,
              foregroundColor: Colors.white,
            ),
            icon: const Icon(Icons.arrow_right_alt),
            label: Text(
                "Start Quiz",
                style: textStyles.bodyTextWhite,
            ),
          ),
        ],
      ),
    );
  }
}
