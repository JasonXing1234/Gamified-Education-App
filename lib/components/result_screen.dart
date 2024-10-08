import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:quiz/components/answers_screen.dart';
import 'package:quiz/components/quiz/quiz_questions/quiz1.dart';
import 'package:quiz/components/practice/practice_questions/fake_profile_practice/fake_profiles_practice_1.dart';
import 'package:quiz/components/question.dart';

import 'buttons/ListenButton.dart';
import 'quiz/quiz_questions/quiz2.dart';
import 'quiz/quiz_questions/quiz3.dart';
import 'quiz/quiz_questions/quiz4.dart';
import 'quiz/quiz_questions/quiz5.dart';
import 'quiz/quiz_questions/quiz6.dart';
import '../styles/app_colors.dart';
import '../styles/text_styles.dart';
import 'buttons/menu_button.dart';
import 'buttons/next_button.dart';
import 'buttons/speed_button.dart';

class ResultScreen extends StatelessWidget {
  ResultScreen({super.key, required this.userAnswers, required this.endQuiz, required this.quizNumber});
  final List<String> userAnswers;
  final void Function() endQuiz;
  final int quizNumber;
  final DatabaseReference _database = FirebaseDatabase.instance.ref();
  User? user2 = FirebaseAuth.instance.currentUser;

  final AppTextStyles textStyles = AppTextStyles();

  void _updateField(int quizResult) async {
    try {
      DataSnapshot snapshot = await _database.child('profile').child(user2!.uid).child('quizScoreList').get();
      List<dynamic> scores = snapshot.value as List<dynamic>;
      scores[quizNumber - 1] = quizResult;
      await _database.child('profile/${user2?.uid}').update({
        'quizScoreList': scores,
      });
    } catch (e) {
      print('Failed to update field: $e');
    }
  }

  List<Map<String, Object>> getSummaryData() {
    final List<Map<String, Object>> summary = [];

    for (int i = 0; i < userAnswers.length; i++) {
      // if multiple options create a string with all the options?

      String specialAnswers = "";
      if (quizNumber == 4) {
        // Social Tags questions -> Multiple Answers Question
        List<String> correctAnswers = quiz4[i].correctAnswers;
        String separator = "";

        // Sort the correct answers and make a string to compare with user
        correctAnswers.sort();
        for (var answer in correctAnswers) {
          specialAnswers = specialAnswers + separator + answer;
          separator = ", ";
        }
      }

      summary.add({
        'index': i,
        'question':
          quizNumber == 0 ? fakeProfilesPractice1[i].context :
          quizNumber == 1 ? quiz1[i].question :
          quizNumber == 2 ? quiz2[i].question :
          quizNumber == 3 ? quiz3[i].context : // Fake Profiles Quiz
          quizNumber == 4 ? quiz4[i].context : // Social Tags Quiz
          quizNumber == 5 ? quiz5[i].question :
          quizNumber == 6 ? quiz6[i].question :
          fakeProfilesPractice1[i].answerOptions[0],
        'correct_answer':
            quizNumber == 0 ? fakeProfilesPractice1[i].correctAnswer :
            quizNumber == 1 ? quiz1[i].correctAnswer :
            quizNumber == 2 ? quiz2[i].answerOptions[0] :
            quizNumber == 3 ? quiz3[i].correctAnswer :
            quizNumber == 4 ? specialAnswers :
            quizNumber == 5 ? quiz5[i].correctAnswer :
            quizNumber == 6 ? quiz6[i].answerOptions[0] :
            fakeProfilesPractice1[i].answerOptions[0],
        'user_answer': userAnswers[i],
      });
    }
    final int numCorrectAnswers = summary
        .where((element) => element['correct_answer'] == element['user_answer'])
        .length;

    _updateField(numCorrectAnswers);

    return summary;
  }

  @override
  build(context) {
    final summary = getSummaryData();
    int numTotalAnswers = fakeProfilesPractice1.length;

    var quizName = "RESULTS";

    if (quizNumber == 1){
      numTotalAnswers = quiz1.length;
      quizName = "SOCIAL MEDIA NORMS";
    }
    else if (quizNumber == 2){
      numTotalAnswers = quiz2.length;
      quizName = "SETTINGS";
    }
    else if (quizNumber == 3){
      numTotalAnswers = quiz3.length;
      quizName = "FAKE PROFILES";
    }
    else if (quizNumber == 4){
      numTotalAnswers = quiz4.length;
      quizName = "SOCIAL TAGS";
    }
    else if (quizNumber == 5){
      numTotalAnswers = quiz5.length;
      quizName = "APPROPRIATE INTERACTIONS";
    }
    else if (quizNumber == 6){
      numTotalAnswers = quiz5.length;
      quizName = "SOCIAL MEDIA VS REALITY";
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
                    child: ListenButton(),
                ),
                const Expanded(
                  child: SpeedButton(),
                ),
                Expanded(
                  child: NextButton(
                    onTap: endQuiz,
                    disabled: false,
                    buttonText: "NEXT",
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
