import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:quiz/components/buttons/answer_button.dart';
import 'package:quiz/components/buttons/menu_button.dart';
import 'package:quiz/components/buttons/speed_button.dart';
import 'package:quiz/components/quiz/quiz_questions/quiz0.dart';
import 'package:quiz/components/quiz/quiz_questions/quiz1.dart';
import 'package:quiz/components/question.dart';
import 'package:quiz/styles/app_colors.dart';
import '../../SQLITE/sqliteHelper.dart';
import '../../models/UserModel.dart';
import '../buttons/listen_button.dart';
import '../progress_bar/progress_bar.dart';
import '../buttons/next_button.dart';
import '../text_box/text_box.dart';

import 'package:quiz/styles/text_styles.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({
    super.key,
    required this.onSelectAnswer,
    required this.quizNumber,
    required this.quiz,
  });

  final void Function(String answer) onSelectAnswer;
  final int quizNumber;
  final List<Question> quiz;


  @override
  State<QuizScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuizScreen> {
  int questionIndex = 0;
  TextEditingController _controller = TextEditingController();
  String tempAnswer = "";
  int selectedIndex = 10;
  final int resetAnswerValue = 10;

  User? user2 = FirebaseAuth.instance.currentUser;
  final DatabaseReference _database = FirebaseDatabase.instance.ref();
  final DatabaseHelper _dbHelper = DatabaseHelper();

  //For multiple answer options
  List<String> selectedAnswers = [];

  final AppTextStyles textStyles = AppTextStyles();
  final AppColors appColors = const AppColors();

  final ScrollController _scrollController = ScrollController();

  List<Question> quizQuestions = [];
  String quizName = "QUIZ";
  int _attemptId = -1;
  DateTime firstQuestionBeginTime = DateTime.now();
  UserModel? user;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScrollEnd);
    quizQuestions = widget.quiz;
    _initializeQuiz();
  }

  Future<void> _initializeQuiz() async {
    await _initializeUser(); // Ensure user is set before initializing the attempt
    await _initializeAttempt(); // Now user will not be null
  }

  Future<void> _initializeUser() async {
    user = await _dbHelper.getLoggedInUser();
  }

  // Insert a new quiz attempt in SQLite and store the attempt ID
  Future<void> _initializeAttempt() async {
    if (user == null) return;

    try {
      final DatabaseHelper _dbHelper = DatabaseHelper();
      _attemptId = await _dbHelper.insertQuizAttempt(
          user!.userId!,
          "quiz" + widget.quizNumber.toString(),
          0 // Initial score
      );
      insertQuizAttemptFirebase(user!.userId!, widget.quizNumber);

      print('New attempt initialized with ID: $_attemptId');
    } catch (e) {
      print('Error initializing attempt: $e');
    }
  }

  void _onScrollEnd() {
    if (!_scrollController.position.isScrollingNotifier.value) {
      // Get the current scroll offset
      double offset = _scrollController.offset;

      // Define the height of each "screen"
      double screenHeight = MediaQuery.of(context).size.height;

      // Find the nearest "screen" to snap to
      int targetPage = (offset / screenHeight).round();

      // Scroll to that "screen"
      _scrollController.animateTo(
        targetPage * screenHeight,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }


  void dispose() {
    // Dispose the controller when the widget is disposed
    _controller.dispose();
    _scrollController.removeListener(_onScrollEnd);
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> insertQuizAttemptFirebase(String userId, int quizIndex) async {
    try {
      final DatabaseReference attemptsRef = _database
          .child('profile')
          .child(userId)
          .child('quizList')
          .child(quizIndex.toString())
          .child('attempts');
      DataSnapshot snapshot = await attemptsRef.get();
      int newAttemptId = 1;
      if (snapshot.value != null) {
        if (snapshot.value is List) {
          List<dynamic> attemptsList = snapshot.value as List<dynamic>;
          newAttemptId = attemptsList.length;
        }
      }
      final DatabaseReference newAttemptRef = attemptsRef.child(newAttemptId.toString());
      await newAttemptRef.set({
        'attemptId': newAttemptId,
        'attemptTimestamp': DateTime.now().toIso8601String(),
        'questions': {},
        'quizScore': 0
      });
      //_attemptId = newAttemptId;
      print('New quiz attempt inserted successfully: Attempt ID = $newAttemptId');
    } catch (e) {
      print('Error inserting quiz attempt in Firebase: $e');
    }
  }

  Future<void> recordingTimeStamp() async {
    if (_attemptId == -1 || user == null) return;

    try {
      // Firebase: Update the end timestamp for the specific attempt
      await _database
          .child('profile')
          .child(user!.userId!)
          .child('quizList')
          .child((widget.quizNumber).toString())
          .child('attempts')  // Store attempts separately
          .child(_attemptId.toString())  // Use attemptId instead of quizList
          .child('questions')
          .child(questionIndex.toString())
          .update({
        'endTimeStamp': DateTime.now().toIso8601String(),
      });

      // SQLite: Update the end timestamp
      final DatabaseHelper _dbHelper = DatabaseHelper();
      await _dbHelper.updateEndTimestamp(
        user!.userId!,
        questionIndex.toString(),
        DateTime.now().toIso8601String(),
      );

      print('End timestamp updated successfully.');
    } catch (e) {
      print('Error recording timestamp: $e');
    }
  }

  Future<void> updateIfEachModuleCompleteForQuiz() async {
    String userId = user!.userId!;
    int moduleIndex = widget.quizNumber - 1; // Get correct module list index

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
      await _dbHelper.updateIfEachModuleCompleteForQuiz(userId, widget.quizNumber);

      print('SQLite: ifEachModuleComplete updated successfully for quiz.');
    } catch (e) {
      print('Error updating ifEachModuleComplete for quiz: $e');
    }
  }

  Future<void> nextQuestion(String answer) async {
    if (_attemptId == -1 || user == null) return;

    final userId = user!.userId!;
    if (userId != null && questionIndex < quizQuestions.length - 1) {
      try {
        final DatabaseHelper _dbHelper = DatabaseHelper();

        String tempString0 = 'quiz' + widget.quizNumber.toString() + '-' + 'question' + (questionIndex).toString();
        if (questionIndex == 0) {
          await _database
              .child('profile')
              .child(userId)
              .child('quizList')
              .child((widget.quizNumber).toString())
              .child('attempts')
              .child(_attemptId.toString())
              .child('questions')
              .child(tempString0)
              .update({
            'questionId': tempString0,
            'beginTimeStamp': firstQuestionBeginTime.toIso8601String(),
          });
        }

        // Firebase: Update the end timestamp for the current question
        String tempString1 = 'quiz' + widget.quizNumber.toString() + '-' + 'question' + (questionIndex).toString();
        await _database
            .child('profile')
            .child(userId)
            .child('quizList')
            .child((widget.quizNumber).toString())
            .child('attempts')
            .child(_attemptId.toString())
            .child('questions')
            .child(tempString1)
            .update({
          'endTimeStamp': DateTime.now().toIso8601String(),
        });

        await _dbHelper.updateEndTimestamp(
          user!.userId!,
          tempString1,
          DateTime.now().toIso8601String(),
        );

        if (questionIndex != 0 || questionIndex < quizQuestions.length - 1) {
          // **Insert a new question into SQLite before updating timestamps**
          await _dbHelper.insertQuizQuestion(
            user!.userId!,
            _attemptId,
            widget.quizNumber,
            questionIndex + 1, // Next question index
          );

          // Firebase: Update the begin timestamp for the next question
          String tempString2 = 'quiz' + widget.quizNumber.toString() + '-' + 'question' + (questionIndex + 1).toString();
          await _database
              .child('profile')
              .child(userId)
              .child('quizList')
              .child((widget.quizNumber).toString())
              .child('attempts')
              .child(_attemptId.toString())
              .child('questions')
              .child(tempString2)
              .update({
            'beginTimeStamp': DateTime.now().toIso8601String(),
            'questionId': tempString2,
          });

          await _dbHelper.updateBeginTimestamp(
            user!.userId!,
            'quiz' + widget.quizNumber.toString() + '-' + 'question' + (questionIndex + 1).toString(),
            DateTime.now().toIso8601String(),
          );
        }
      } catch (e) {
        print('Error updating timestamps: $e');
      }
    }

    setState(() {
      if (questionIndex < quizQuestions.length - 1) {
        questionIndex++;
      }
    });

    widget.onSelectAnswer(answer);
  }

  Future<void> updateUserAnswerFirebase(
      String userId, int quizNumber, String questionId, String userAnswer) async {
    try {
      final DatabaseReference quizListRef = _database
          .child('profile')
          .child(userId)
          .child('quizList')
          .child(quizNumber.toString())
          .child('attempts');

      // Fetch all attempts for this quiz
      DataSnapshot snapshot = await quizListRef.get();
      if (snapshot.value == null) {
        print('No attempts found for quiz.');
        return;
      }

      int latestAttemptId;
      if (snapshot.value is Map<dynamic, dynamic>) {
        // When Firebase stores attempts as a Map
        Map<dynamic, dynamic> attemptsMap = snapshot.value as Map<dynamic, dynamic>;
        List<int> attemptIds = attemptsMap.keys.map((e) => int.tryParse(e.toString()) ?? 0).toList();
        attemptIds.sort();
        latestAttemptId = attemptIds.isNotEmpty ? attemptIds.last : 1;
      } else if (snapshot.value is List<dynamic>) {
        // When Firebase stores attempts as a List
        List<dynamic> attemptsList = snapshot.value as List<dynamic>;
        latestAttemptId = attemptsList.length - 1; // Last attempt index
      } else {
        latestAttemptId = 1;
      }

      DatabaseReference questionRef = quizListRef
          .child(latestAttemptId.toString())
          .child('questions')
          .child(questionId);

      // Update `userAnswer`
      await questionRef.update({'userAnswer': userAnswer});

      print('User answer updated successfully in Firebase.');
    } catch (e) {
      print('Error updating user answer in Firebase: $e');
    }
  }



  @override
  Widget build(BuildContext context) {

    Question currentQuestion;


    if (quizQuestions.isNotEmpty) {
      currentQuestion = quizQuestions[questionIndex];
    }
    else {
      currentQuestion = Question(context: "no", question: "none", photo: "no", answerOptions: ["none"], explanation: "none");
    }

    Widget nextButton;

    if (selectedIndex == resetAnswerValue) {
      // No answer has been selected by user
      if (widget.quizNumber == 0) {
        // No answer has been selected by user

        nextButton = MultiPurposeButton(
          onTap: () {
            nextQuestion('True');
          },
          buttonType: ButtonType.next,
          disabled: false,
        );
      }
      else {
        nextButton = MultiPurposeButton(
          onTap: () {},
          buttonType: ButtonType.next,
          disabled: true,
        );
      }
    }
    else {
      nextButton = MultiPurposeButton(
        onTap: () async {
          String userAnswer = "";

          if (currentQuestion.answerOptions[0] == 'textField') {
            userAnswer = _controller.text;
          } else if (currentQuestion is MultipleAnswersQuestion) {
            String sep = "";
            selectedAnswers.sort();
            for (var selectionOption in selectedAnswers) {
              userAnswer += sep + selectionOption;
              sep = ", ";
            }
          } else {
            userAnswer = tempAnswer;
          }

          if (user != null) {
            final userId = user!.userId!;
            String questionId = 'quiz${widget.quizNumber}-question$questionIndex';

            // **First update the user answer asynchronously**
            await updateUserAnswerFirebase(userId, widget.quizNumber, questionId, userAnswer);
            await _dbHelper.updateUserAnswerSQLite(userId, widget.quizNumber, questionId, userAnswer);
          }

          // **Then update UI inside setState**
          setState(() {
            nextQuestion(userAnswer);
            selectedIndex = 10;
            selectedAnswers = [];
          });
        },
        disabled: false,
        buttonType: questionIndex == quizQuestions.length - 1 ? ButtonType.submit : ButtonType.next,
      );
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 70, // Increases the height of the AppBar
        title: Padding(
            padding: const EdgeInsets.only(top: 20),
          child: Text(
            quizName,
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
              //crossAxisAlignment: CrossAxisAlignment.center, // Aligns with the title vertically
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
              Expanded(
                child: nextButton,
              ),
            ],
          ),
        ),
      ),

      body: Stack (
        children: [
          SingleChildScrollView(
              controller: _scrollController,
              child: Container(
                padding: const EdgeInsets.all(40),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    currentQuestion.context == "no" ? SizedBox.shrink() : Text(currentQuestion.context, style: textStyles.mediumBodyText,),//TextBox(currentText: currentQuestion.context),
                    currentQuestion.context == "no" ? SizedBox.shrink() : const SizedBox(height: 20), // Add an extra space between context & question box
                    TextBox(currentText: currentQuestion),
                    currentQuestion.photo == 'no' ? SizedBox.shrink() : Image.asset(currentQuestion.photo),
                    const SizedBox(
                      height: 30,
                    ),

                    // Answer option Questions
                    if (currentQuestion is SingleAnswerQuestion)
                      ...currentQuestion.answerOptions.asMap().entries.map(
                            (answer) => Container(
                          width: double.infinity, // Makes each button take full width
                          padding: const EdgeInsets.symmetric(vertical: 10), // Add padding if needed
                          child: AnswerButton(
                            color: selectedIndex == answer.key ? appColors.orange : appColors.royalBlue,
                            borderThickness: selectedIndex == answer.key ? 7.0 : 3.0,
                            answerText: answer.value,
                            onTap: () {
                              setState(() {
                                selectedIndex = answer.key;
                                tempAnswer = answer.value;

                              });
                            },
                            // textAlign: TextAlign.center, // Centers the text within the button
                          ),
                        ),
                      ),

                    // Multiple Answer Question
                    if (currentQuestion is MultipleAnswersQuestion)
                      if(currentQuestion.answerOptions[0] != 'textField') ...currentQuestion.answerOptions.asMap().entries.map(
                            (answer) => Container(
                              width: double.infinity, // Makes each button take full width
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: AnswerButton(
                                color: selectedAnswers.contains(answer.value) ? appColors.orange : appColors.royalBlue,
                                borderThickness: selectedAnswers.contains(answer.value) ? 7.0 : 3.0,
                                answerText: answer.value,
                                onTap: () {
                                  setState(() {
                                    selectedIndex = answer.key;
                                    tempAnswer = answer.value;

                                    if (selectedAnswers.contains(answer.value)) {
                                      selectedAnswers.remove(answer.value); // Deselect if already selected
                                    } else {
                                      selectedAnswers.add(answer.value); // Select if not already selected
                                    }

                                  });
                                },
                              ),
                            ),
                      ),

                    if(currentQuestion.answerOptions[0] == 'textField')
                      TextFormField(controller: _controller,
                        decoration: const InputDecoration(
                          labelText: 'Enter your text',
                          border: OutlineInputBorder(),
                        ),),
                    const SizedBox(
                      height: 60,
                    ),
                  ],
                ),
              )
          ),
          // Put progress bar here so that it doesn't move and is on top of the scrollable content
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            color: Colors.white,
            child: ProgressBar(pageIndex: questionIndex, pageList: quizQuestions),
          )
        ],
      )


    );
  }
}

