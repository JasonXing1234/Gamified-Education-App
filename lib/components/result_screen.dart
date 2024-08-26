import 'package:flutter/material.dart';
import 'package:quiz/components/question_answers.dart';
import 'package:quiz/components/quiz/quiz_questions/quiz1.dart';
import 'package:quiz/data/quiz_data.dart';

import 'quiz/quiz_questions/quiz2.dart';
import '../data/quiz3.dart';
import '../data/quiz4.dart';
import '../data/quiz5.dart';
import '../styles/app_colors.dart';
import '../styles/text_styles.dart';
import 'buttons/menu_button.dart';
import 'buttons/next_button.dart';
import 'buttons/sound_button.dart';

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
        'question': questions[i].context,
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

    var quizName = "QUIZ";

    if (number == 1){
      numTotalAnswers = quiz1.length;
      quizName = "QUIZ: SOCIAL MEDIA NORMS";
    }
    else if (number == 2){
      numTotalAnswers = quiz2.length;
      quizName = "QUIZ: SETTINGS";
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

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            quizName,
            style: textStyles.heading1,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: [
                const Expanded(
                  child: MenuButton(),
                ),
                const Expanded(
                  child: SoundButton(),
                ),
                Expanded(
                  child: NextButton(
                    onTap: restartQuiz,
                    disabled: false,
                    buttonText: "FINISH",
                  ),
                ),
              ],
            ),
          ),
        ),

      body: SingleChildScrollView(
        child: Container(
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
                height: 60,
              ),
            ],
          ))
      )
    );
  }
}
