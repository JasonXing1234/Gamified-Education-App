import 'package:flutter/material.dart';
import 'package:quiz/components/question_answers.dart';
import 'package:quiz/data/quiz_data.dart';

class ResultScreen extends StatelessWidget {
  ResultScreen({super.key, required this.answers, required this.restartQuiz});
  final List<String> answers;
  final void Function() restartQuiz;

  List<Map<String, Object>> getSummaryData() {
    final List<Map<String, Object>> summary = [];

    for (int i = 0; i < answers.length; i++) {
      summary.add({
        'index': i,
        'question': questions[i].text,
        'correct_answer': questions[i].answers[0],
        'user_answer': answers[i],
      });
    }

    return summary;
  }

  @override
  build(context) {
    final summary = getSummaryData();
    final int numTotalAnswers = questions.length;
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
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
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
                foregroundColor: Colors.white,
              ),
              icon: const Icon(Icons.restart_alt),
              label: const Text(
                "Restart Quiz",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ));
  }
}
