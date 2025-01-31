import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:quiz/components/buttons/answer_button.dart';
import 'package:quiz/components/progress_bar/progress_bar.dart';

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


  });
  final void Function() onDone;
  // final int quizNumber;
  final List<Question> practice;

  @override
  State<PracticeScreen> createState() => _PracticeScreenState();
}

class _PracticeScreenState extends State<PracticeScreen> {
  bool isCorrect = false;
  bool checkedAnswer = false;
  int questionIndex = 0;
  String tempAnswer = "";
  int selectedIndex = 4;
  int counter = 0;
  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final DatabaseReference _database = FirebaseDatabase.instance.ref();
  User? user2 = FirebaseAuth.instance.currentUser;

  final AppTextStyles textStyles = AppTextStyles();
  final AppColors appColors = const AppColors();

  final ScrollController _scrollController = ScrollController();

  List<Question> practiceQuestions = [];
  var practiceName = "PRACTICE";

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScrollEnd);

    practiceQuestions = widget.practice;

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

  // Future<void> recordTicket() async {
  //   if (questionIndex == practiceQuestions.length - 1) {
  //     DataSnapshot snapshot = await _database.child('profile').child(user2!.uid).child('numTickets').get();
  //     int numTickets = snapshot.value as int;
  //     await _database.child('profile/${user2?.uid}').update({
  //       'numTickets': numTickets+1,
  //     });
  //   }
  // }

  Future<void> nextQuestion() async {
    setState(() {
      checkedAnswer = false;
      isCorrect = false;
      selectedIndex = 10;
      tempAnswer = "";
      if (questionIndex < practiceQuestions.length - 1) {
        questionIndex++;
      }
    });
    if (questionIndex >= practiceQuestions.length - 1) {
      // If the Practice is done then call the onDone method
      widget.onDone();
    }
    
  }

  @override
  Widget build(BuildContext context) {
    dynamic currentQuestion;

    if (practiceQuestions.isNotEmpty) {
      currentQuestion = practiceQuestions[questionIndex];
    }
    else {
      currentQuestion = Question(context: "no", question: "none", photo: "no", answerOptions: ["none"], explanation: "none");
    }

    // Set up the correct button check, finish or next
    Widget button;
    if (tempAnswer == "") {
      // User hasn't answered the question
      button = MultiPurposeButton(
        onTap: () {},
        buttonType: ButtonType.check,
        disabled: true,
      );
    }
    else if (!checkedAnswer || !isCorrect) {
      // User can now check answer
      button = MultiPurposeButton(
        onTap: () {
          setState(() {
            if(currentQuestion.correctAnswer == tempAnswer){
              // Set correct and checked
              // TODO: Find a way to lock the correct answer, so user doesn't accidentally change answer
              isCorrect = true;
              checkedAnswer = true;
            }
            else{
              isCorrect = false;
              checkedAnswer = true;
            }
          });
        },
        buttonType: ButtonType.check,
        disabled: false,
      );
    }
    else if (isCorrect && questionIndex == practiceQuestions.length - 1) {
      // Answer is correct and on last question, can finish the practice
      button = MultiPurposeButton(
        onTap: () {
          setState(() {
            // recordTicket();
            nextQuestion();
          });
        },
        buttonType: ButtonType.submit,
        disabled: false,
      );
    }
    else if (isCorrect) {
      // Go to next question if correct
      button = MultiPurposeButton(
        onTap: () {
          setState(() {
            nextQuestion(); // Protect user from accidentally changing answers
            selectedIndex = 10;
          });
        },
        buttonType: ButtonType.next,
        disabled: false,
      );
    }
    else {
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
                Expanded(child: button,),
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
                    currentQuestion.context == "no" ? SizedBox.shrink() : Text(currentQuestion.context, style: textStyles.mediumBodyText,),
                    currentQuestion.context == "no" ? SizedBox.shrink() : const SizedBox(height: 30,),
                    currentQuestion.photo == 'no' ? SizedBox.shrink() : Image.asset(currentQuestion.photo),
                    currentQuestion.photo == 'no' ? SizedBox.shrink() : const SizedBox(height: 30,),

                    counter == 2 ? SizedBox.shrink() : TextBox(
                      currentText: currentQuestion,
                    ),
                    const SizedBox(
                      height: 30,
                    ),

                    ...currentQuestion.answerOptions.asMap().entries.map(
                          (answer) => Container(
                        width: double.infinity, // Makes each button take full width
                        padding: const EdgeInsets.symmetric(vertical: 5), // Add padding if needed
                        child: AnswerButton(
                          color: selectedIndex == answer.key ?  appColors.orange : appColors.royalBlue,
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

                    const SizedBox(
                      height: 15,
                    ),

                    isCorrect == false && checkedAnswer == true ? Text(
                      'The answer was incorrect. Please try again.',
                      textAlign: TextAlign.left,
                      style: textStyles.customBodyText(appColors.red, 24),
                    ) : SizedBox.shrink(),

                    isCorrect == true && checkedAnswer == true ? Text(
                      "Correct!\n${currentQuestion.explanation}",
                      textAlign: TextAlign.left,
                      style: textStyles.customBodyText(appColors.green, 24),
                    ) : SizedBox.shrink(),

                    const SizedBox(
                      height: 60,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              color: Colors.white,
              child: ProgressBar(pageIndex: questionIndex, pageList: practiceQuestions),
            )
          ],
        )
    );
  }
}
