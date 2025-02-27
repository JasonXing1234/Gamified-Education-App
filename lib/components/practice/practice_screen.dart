import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:quiz/components/buttons/answer_button.dart';
import 'package:quiz/components/progress_bar/progress_bar.dart';
import '../../SQLITE/sqliteHelper.dart';
import '../buttons/listen_button.dart';
import '../question.dart';
import '../../styles/app_colors.dart';
import '../../styles/text_styles.dart';
import '../buttons/next_button.dart';
import '../text_box/text_box.dart';

class PracticeScreen extends StatefulWidget {
  const PracticeScreen({
    super.key,
    required this.onDone,
    required this.practice,
    required this.practiceNumber
  });

  final void Function() onDone;
  final List<Question> practice;
  final int practiceNumber;

  @override
  State<PracticeScreen> createState() => _PracticeScreenState();
}

class _PracticeScreenState extends State<PracticeScreen> {
  bool isCorrect = false;
  bool checkedAnswer = false;
  int questionIndex = 0;
  String tempAnswer = "";
  int selectedIndex = 4;
  int attemptCount = 0;
  List<String> incorrectAnswers = [];
  late DateTime startTime;
  final DatabaseReference _database = FirebaseDatabase.instance.ref();
  User? user2 = FirebaseAuth.instance.currentUser;
  final AppTextStyles textStyles = AppTextStyles();
  final AppColors appColors = const AppColors();
  final ScrollController _scrollController = ScrollController();
  final DatabaseHelper _dbHelper = DatabaseHelper();
  List<Question> practiceQuestions = [];
  var practiceName = "PRACTICE";
  int _attemptId = -1;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScrollEnd);
    practiceQuestions = widget.practice;
    startTime = DateTime.now();
  }

  void _onScrollEnd() {
    if (!_scrollController.position.isScrollingNotifier.value) {
      double offset = _scrollController.offset;
      double screenHeight = MediaQuery.of(context).size.height;
      int targetPage = (offset / screenHeight).round();
      _scrollController.animateTo(
        targetPage * screenHeight,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> _initializePracticeAttempt() async {
    if (user2 == null) return;

    try {
      final DatabaseHelper _dbHelper = DatabaseHelper();
      _attemptId = await _dbHelper.insertPracticeAttempt(
          user2!.uid,
          widget.practiceNumber.toString(),
          0 // Initial score
      );

      print('New practice attempt initialized with ID: $_attemptId');
    } catch (e) {
      print('Error initializing practice attempt: $e');
    }
  }

  Future<void> recordPracticeAttempt() async {
    final userId = user2?.uid;
    if (userId != null) {
      final endTime = DateTime.now();
      final timeTaken = endTime.difference(startTime).inSeconds;

      await _dbHelper.insertPracticeQuestion(
        userId: userId,
        isCorrect: isCorrect,
        attemptCount: attemptCount,
        incorrectAnswers: incorrectAnswers,
        timeTaken: timeTaken,
      );

      attemptCount = 0;
      incorrectAnswers.clear();
    }
  }

  Future<void> updateTotalTimeSpent() async {
    final userId = user2?.uid;
    if (userId != null) {
      int totalPracticeTime = await _dbHelper.getTotalPracticeTime(userId);
      await _database.child('profile/$userId').update({
        'totalTimeSpent': totalPracticeTime,
      });
    }
  }

  Future<void> nextQuestion() async {
    if (_attemptId == -1 || user2 == null) return;

    final userId = user2?.uid;
    if (userId != null && questionIndex < practiceQuestions.length - 1) {
      try {
        final DatabaseHelper _dbHelper = DatabaseHelper();

        // Firebase: Update the end timestamp for the current question
        await _database
            .child('profile')
            .child(userId)
            .child('PracticeAttempts')  // Store per attempt
            .child(_attemptId.toString())
            .child('questions')
            .child(questionIndex.toString())
            .update({
          'endTimeStamp': DateTime.now().toIso8601String(),
          'attemptCount': attemptCount,
          'incorrectAnswers': incorrectAnswers,
          'timeTaken': DateTime.now().difference(startTime).inSeconds,
        });

        await _dbHelper.updateEndTimestampForPractice(
          user2!.uid,
          questionIndex.toString(),
          DateTime.now().toIso8601String(),
          _attemptId,
          attemptCount,
          incorrectAnswers,
          DateTime.now().difference(startTime).inSeconds,
        );

        if (questionIndex < practiceQuestions.length - 1) {
          // Firebase: Update the begin timestamp for the next question
          await _database
              .child('profile')
              .child(userId)
              .child('PracticeAttempts')
              .child(_attemptId.toString())
              .child('questions')
              .child((questionIndex + 1).toString())
              .update({
            'beginTimeStamp': DateTime.now().toIso8601String(),
          });

          // SQLite: Update the begin timestamp for the next question
          await _dbHelper.updateBeginTimestampForPractice(
            user2!.uid,
            (questionIndex + 1).toString(),
            DateTime.now().toIso8601String(),
            _attemptId, // Use global attempt ID
          );
        } else {
          //TODO:
        }

        // Reset tracking variables
        attemptCount = 0;
        incorrectAnswers.clear();
        startTime = DateTime.now();

        setState(() {
          if (questionIndex < practiceQuestions.length - 1) {
            questionIndex++;
          }
        });

        widget.onDone();
      } catch (e) {
        print('Error updating practice timestamps: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    dynamic currentQuestion;

    if (practiceQuestions.isNotEmpty) {
      currentQuestion = practiceQuestions[questionIndex];
    } else {
      currentQuestion = Question(
        context: "no",
        question: "none",
        photo: "no",
        answerOptions: ["none"],
        explanation: "none",
      );
    }

    Widget button;
    if (tempAnswer == "") {
      button = MultiPurposeButton(
        onTap: () {},
        buttonType: ButtonType.check,
        disabled: true,
      );
    } else if (!checkedAnswer || !isCorrect) {
      button = MultiPurposeButton(
        onTap: () {
          setState(() {
            if (currentQuestion.correctAnswer == tempAnswer) {
              isCorrect = true;
              checkedAnswer = true;
            } else {
              isCorrect = false;
              checkedAnswer = true;
              attemptCount++;
              incorrectAnswers.add(tempAnswer);
            }
          });
        },
        buttonType: ButtonType.check,
        disabled: false,
      );
    } else if (isCorrect && questionIndex == practiceQuestions.length - 1) {
      button = MultiPurposeButton(
        onTap: () {
          nextQuestion();
        },
        buttonType: ButtonType.submit,
        disabled: false,
      );
    } else if (isCorrect) {
      button = MultiPurposeButton(
        onTap: () {
          nextQuestion();
        },
        buttonType: ButtonType.next,
        disabled: false,
      );
    } else {
      button = MultiPurposeButton(
        onTap: () {},
        buttonType: ButtonType.next,
        disabled: true,
      );
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 70,
        title: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Text(
            practiceName,
            style: textStyles.heading1,
          ),
        ),
        leadingWidth: 100,
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        color: Colors.white,
        child: SizedBox(
          height: 60,
          child: Row(
            children: [
              const Expanded(
                child: ListenButton(),
              ),
              Expanded(child: button),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(40),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  currentQuestion.context == "no" ? SizedBox.shrink() : Text(currentQuestion.context, style: textStyles.mediumBodyText),
                  currentQuestion.context == "no" ? SizedBox.shrink() : const SizedBox(height: 30),
                  currentQuestion.photo == 'no' ? SizedBox.shrink() : Image.asset(currentQuestion.photo),
                  currentQuestion.photo == 'no' ? SizedBox.shrink() : const SizedBox(height: 30),
                  TextBox(currentText: currentQuestion),
                  const SizedBox(height: 30),
                  ...currentQuestion.answerOptions.asMap().entries.map(
                        (answer) => Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: AnswerButton(
                        color: selectedIndex == answer.key ? appColors.orange : appColors.royalBlue,
                        borderThickness: selectedIndex == answer.key ? 6.0 : 3.0,
                        answerText: answer.value,
                        onTap: () {
                          setState(() {
                            selectedIndex = answer.key;
                            tempAnswer = answer.value;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  isCorrect == false && checkedAnswer == true
                      ? Text(
                    'The answer was incorrect. Please try again.',
                    textAlign: TextAlign.left,
                    style: textStyles.customBodyText(appColors.red, 24),
                  )
                      : SizedBox.shrink(),
                  isCorrect == true && checkedAnswer == true
                      ? Text(
                    "Correct!\n${currentQuestion.explanation}",
                    textAlign: TextAlign.left,
                    style: textStyles.customBodyText(appColors.green, 24),
                  )
                      : SizedBox.shrink(),
                  const SizedBox(height: 60),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            color: Colors.white,
            child: ProgressBar(pageIndex: questionIndex, pageList: practiceQuestions),
          ),
        ],
      ),
    );
  }
}
