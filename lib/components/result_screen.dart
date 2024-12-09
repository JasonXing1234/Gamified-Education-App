import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:quiz/components/answers_screen.dart';
import 'package:quiz/components/quiz/quiz_questions/quiz0.dart';
import 'package:quiz/components/quiz/quiz_questions/quiz1.dart';
import 'package:quiz/components/practice/practice_questions/fake_profile_practice/fake_profiles_practice_1.dart';

import '../SQLITE/sqliteHelper.dart';
import 'buttons/ListenButton.dart';
import 'quiz/quiz_questions/quiz2.dart';
import 'quiz/quiz_questions/quiz3.dart';
import 'quiz/quiz_questions/quiz4.dart';
import 'quiz/quiz_questions/quiz5.dart';
import 'quiz/quiz_questions/quiz6.dart';
import '../styles/text_styles.dart';
import 'buttons/next_button.dart';

class ResultScreen extends StatelessWidget {
  ResultScreen({super.key, required this.userAnswers, required this.endQuiz, required this.quizNumber});
  final List<String> userAnswers;
  final void Function() endQuiz;
  final int quizNumber;
  final DatabaseReference _database = FirebaseDatabase.instance.ref();
  User? user2 = FirebaseAuth.instance.currentUser;

  final AppTextStyles textStyles = AppTextStyles();

  Future<void> _updateField(int quizResult) async {
    try {
      DataSnapshot snapshot = await _database.child('profile').child(user2!.uid).child('quizList').get();
      if (snapshot.value != null) {
        List<dynamic> quizzes = snapshot.value as List<dynamic>;
        quizzes[quizNumber - 1]['quizScore'] = quizResult;
        await _database.child('profile/${user2?.uid}').update({
          'quizzes': quizzes,
        });
      }
      final DatabaseHelper _dbHelper = DatabaseHelper();
      await _dbHelper.updateQuizScore(user2!.uid, quizNumber, quizResult);

      print('Quiz score updated successfully in Firebase and SQLite.');
    } catch (e) {
      print('Failed to update field: $e');
    }
  }

  Future<List<Map<String, Object>>> getSummaryData() async {
    final List<Map<String, Object>> summary = [];

    for (int i = 0; i < userAnswers.length; i++) {
      String specialAnswers = "";
      if (quizNumber == 4) {
        List<String> correctAnswers = quiz4[i].correctAnswers;
        correctAnswers.sort();
        specialAnswers = correctAnswers.join(", ");
      }

      summary.add({
        'index': i,
        'question': quizNumber == 0
            ? quiz0[i].context
            : quizNumber == 1
            ? quiz1[i].question
            : quizNumber == 2
            ? quiz2[i].question
            : quizNumber == 3
            ? quiz3[i].context
            : quizNumber == 4
            ? quiz4[i].context
            : quizNumber == 5
            ? quiz5[i].question
            : quiz6[i].question,
        'correct_answer': quizNumber == 1
            ? quiz1[i].correctAnswer
            : quizNumber == 2
            ? quiz2[i].answerOptions[0]
            : quizNumber == 3
            ? quiz3[i].correctAnswer
            : quizNumber == 4
            ? specialAnswers
            : quizNumber == 5
            ? quiz5[i].correctAnswer
            : quiz6[i].answerOptions[0],
        'user_answer': userAnswers[i],
      });
    }

    final int numCorrectAnswers = summary
        .where((element) => element['correct_answer'] == element['user_answer'])
        .length;

    await _updateField(numCorrectAnswers);

    return summary;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, Object>>>(
      future: getSummaryData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else if (snapshot.hasData) {
          final summary = snapshot.data!;
          final int numTotalAnswers = fakeProfilesPractice1.length;
          final int numCorrectAnswers = summary
              .where((element) =>
          element['correct_answer'] == element['user_answer'])
              .length;

          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                "RESULTS",
                style: textStyles.heading1,
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
                    const SizedBox(height: 30),
                    QuestionAnswers(summary),
                    const SizedBox(height: 60),
                  ],
                ),
              ),
            ),
          );
        } else {
          return const Center(
            child: Text("No data available."),
          );
        }
      },
    );
  }
}