import 'package:flutter/material.dart';
import 'package:quiz/components/question_answers.dart';
import 'package:quiz/data/quiz1.dart';
import 'package:quiz/data/quiz_data.dart';

import '../data/quiz2.dart';
import '../data/quiz3.dart';
import '../data/quiz4.dart';
import '../data/quiz5.dart';
import '../styles/app_colors.dart';
import '../styles/text_styles.dart';

class ResultScreen extends StatelessWidget {
  ResultScreen({super.key, required this.answers, required this.restartQuiz, required this.number});
  final List<String> answers;
  final void Function() restartQuiz;
  final int number;

  final AppTextStyles textStyles = AppTextStyles();

  List<Map<String, Object>> getSummaryData() {
    final List<Map<String, Object>> summary = [];

    for (int i = 0; i < answers.length; i++) {
      summary.add({
        'index': i,
        'question': questions[i].text,
        'correct_answer': number == 0 ? questions[i].answers[0] : number == 1 ? quiz1[i].answers[0] : number == 2 ? quiz2[i].answers[0]
        : number == 3 ? quiz3[i].answers[0] : number == 4 ? quiz4[i].answers[0] : number == 5 ? quiz5[i].answers[0] : questions[i].answers[0],
        'user_answer': answers[i],
      });
    }

    return summary;
  }

  @override
  build(context) {
    final summary = getSummaryData();
    int numTotalAnswers = questions.length;
    if (number == 1){
      numTotalAnswers = quiz1.length;
    }
    else if (number == 2){
      numTotalAnswers = quiz2.length;
    }
    else if (number == 3){
      numTotalAnswers = quiz3.length;
    }
    else if (number == 4){
      numTotalAnswers = quiz4.length;
    }
    else if (number == 5){
      numTotalAnswers = quiz5.length;
    }
    final int numCorrectAnswers = summary
        .where((element) => element['correct_answer'] == element['user_answer'])
        .length;

    return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "You answered $numCorrectAnswers of $numTotalAnswers questions correctly!",
              style: textStyles.heading1,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 30,
            ),
            QuestionAnswers(summary),
            const SizedBox(
              height: 30,
            ),
            TextButton.icon(
              onPressed: restartQuiz,
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
              ),
              icon: const Icon(Icons.home),
              label: Text(
                "Return to Home Screen",
                style: textStyles.smallBodyText,
              ),
            ),
          ],
        ));
  }
}
