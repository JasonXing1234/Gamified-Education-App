import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:quiz/components/answers_screen.dart';
import 'package:quiz/components/quiz/quiz_questions/quiz0.dart';
import 'package:quiz/components/quiz/quiz_questions/quiz1.dart';
import 'package:quiz/components/practice/practice_questions/fake_profile_practice/fake_profiles_practice_1.dart';
import 'package:quiz/styles/app_colors.dart';
import '../SQLITE/sqliteHelper.dart';
import '../models/UserModel.dart';
import 'buttons/listen_button.dart';
import 'quiz/quiz_questions/quiz2.dart';
import 'quiz/quiz_questions/quiz3.dart';
import 'quiz/quiz_questions/quiz4.dart';
import 'quiz/quiz_questions/quiz5.dart';
import 'quiz/quiz_questions/quiz6.dart';
import '../styles/text_styles.dart';
import 'buttons/next_button.dart';

class ResultScreen extends StatelessWidget {
  ResultScreen({super.key, required this.userAnswers, required this.endQuiz, required this.quizNumber, required this.user});
  final List<String> userAnswers;
  final void Function() endQuiz;
  final int quizNumber;
  final DatabaseReference _database = FirebaseDatabase.instance.ref();
  final UserModel user;
  User? user2 = FirebaseAuth.instance.currentUser;
  final DatabaseHelper _dbHelper = DatabaseHelper();

  final AppTextStyles textStyles = AppTextStyles();
  final AppColors appColors = const AppColors();

  Future<void> _updateField(int quizResult) async {
    try {
      final DatabaseReference quizAttemptsRef = _database
          .child('profile')
          .child(user2!.uid)
          .child('quizList')
          .child((quizNumber - 1).toString()) // Access the correct quiz
          .child('attempts');

      DataSnapshot snapshot = await quizAttemptsRef.get();
      if (snapshot.value != null) {
        int latestAttemptId;
        if (snapshot.value is Map<dynamic, dynamic>) {
          Map<dynamic, dynamic> attemptsMap = snapshot.value as Map<dynamic, dynamic>;
          List<int> attemptIds = attemptsMap.keys
              .map((e) => int.tryParse(e.toString()) ?? 0)
              .toList();
          latestAttemptId = attemptIds.isNotEmpty ? attemptIds.reduce((a, b) => a > b ? a : b) : 1;
        } else if (snapshot.value is List) {
          List<dynamic> attemptsList = snapshot.value as List<dynamic>;
          latestAttemptId = attemptsList.length;
        } else {
          latestAttemptId = 1;
        }

        await quizAttemptsRef.child(latestAttemptId.toString()).update({
          'quizScore': quizResult,
        });

        print('Quiz score updated successfully for attempt ID $latestAttemptId in Firebase.');
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

      String correctAnswer = quizNumber == 1
          ? quiz1[i].correctAnswer
          : quizNumber == 2
          ? quiz2[i].answerOptions[0]
          : quizNumber == 3
          ? quiz3[i].correctAnswer
          : quizNumber == 4
          ? specialAnswers
          : quizNumber == 5
          ? quiz5[i].correctAnswer
          : quiz6[i].answerOptions[0];

      bool isCorrect = userAnswers[i] == correctAnswer;

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
        'correct_answer': correctAnswer,
        'user_answer': userAnswers[i],
        'isCorrect': isCorrect,
      });

      await _updateIsCorrectField(i, isCorrect);
    }

    final int numCorrectAnswers = summary
        .where((element) => element['correct_answer'] == element['user_answer'])
        .length;

    double scorePercentage = (numCorrectAnswers / userAnswers.length) * 100;

    // Update quiz score
    await _updateField(numCorrectAnswers);

    // Only mark module complete if score is 80% or higher
    if (scorePercentage >= 80) {
      await updateIfEachModuleCompleteForQuiz();
    }

    return summary;
  }

  Future<void> updateIfEachModuleCompleteForQuiz() async {
    String userId = user.userId!;
    int moduleIndex = quizNumber; // Get correct module list index

    try {
      DataSnapshot snapshot = await _database
          .child('profile')
          .child(userId)
          .child('ifEachModuleComplete')
          .get();

      if (snapshot.value != null) {
        List<dynamic> moduleCompletion = snapshot.value as List<dynamic>;
        if (moduleIndex >= 0 && moduleIndex < moduleCompletion.length) {
          moduleCompletion[moduleIndex][1] = true;

          await _database.child('profile').child(userId).update({
            'ifEachModuleComplete': moduleCompletion,
          });

          print('Firebase: ifEachModuleComplete updated successfully for quiz.');
        } else {
          print('Firebase: Invalid module index.');
        }
      }
      await _dbHelper.updateIfEachModuleCompleteForQuiz(userId, quizNumber);

      print('SQLite: ifEachModuleComplete updated successfully for quiz.');
    } catch (e) {
      print('Error updating ifEachModuleComplete for quiz: $e');
    }
  }


  Future<void> _updateIsCorrectField(int questionIndex, bool isCorrect) async {
    if (user2 == null) return;

    final String userId = user2!.uid;
    try {
      String tempString = 'quiz' + quizNumber.toString() + '-' + 'question' + (questionIndex).toString();
      final DatabaseReference attemptsRef = _database
          .child('profile')
          .child(userId)
          .child('quizList')
          .child(quizNumber.toString())
          .child('attempts');

      // Fetch all attempts
      DataSnapshot snapshot = await attemptsRef.get();
      if (snapshot.value == null) {
        print('No attempts found for quiz.');
        return;
      }

      int latestAttemptId;
      if (snapshot.value is Map<dynamic, dynamic>) {
        Map<dynamic, dynamic> attemptsMap = snapshot.value as Map<dynamic, dynamic>;
        List<int> attemptIds = attemptsMap.keys.map((e) => int.tryParse(e.toString()) ?? 0).toList();
        attemptIds.sort();
        latestAttemptId = attemptIds.isNotEmpty ? attemptIds.last : 1;
      } else if (snapshot.value is List<dynamic>) {
        List<dynamic> attemptsList = snapshot.value as List<dynamic>;
        latestAttemptId = attemptsList.length - 1; // Last attempt index
      } else {
        latestAttemptId = 1;
      }

      await attemptsRef
          .child(latestAttemptId.toString())
          .child('questions')
          .child(tempString)
          .update({'isCorrect': isCorrect});

      final DatabaseHelper _dbHelper = DatabaseHelper();
      await _dbHelper.updateIsCorrect(userId, quizNumber, questionIndex, isCorrect);

      print('Updated isCorrect for questionIndex: $questionIndex in Firebase and SQLite.');
    } catch (e) {
      print('Error updating isCorrect: $e');
    }
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
              toolbarHeight: 70, // Increases the height of the AppBar
              title: Padding(
                padding: const EdgeInsets.only(top: 20.0), // Adjust the top padding of title
                child: Text(
                  "RESULTS",
                  style: textStyles.heading1,
                ),
              ),
              leadingWidth: 100, // Gives space for the back button
              leading: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 30, top: 20),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.arrow_back_ios,
                        color: appColors.royalBlue,
                        size: textStyles.heading1.fontSize,
                      ),
                      Text(
                        "Exit",
                        style: textStyles.customText(appColors.royalBlue, 20, FontWeight.normal),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
            floatingActionButton: Container(
              color: Colors.white,
              child: SizedBox(
                height: 60,
                child: Row(
                  children: [
                    const Expanded(
                      child: ListenButton(),
                    ),
                    Expanded(
                      child: MultiPurposeButton(
                        onTap: endQuiz,
                        disabled: false,
                        buttonType: ButtonType.reward,
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