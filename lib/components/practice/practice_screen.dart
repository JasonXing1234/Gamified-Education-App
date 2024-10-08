import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:quiz/components/buttons/answer_button.dart';
import 'package:quiz/components/practice/practice_questions/appropriate_interaction_practice/appropriate_interaction_practice_1.dart';
import 'package:quiz/components/progress_bar/progress_bar.dart';

import '../buttons/ListenButton.dart';
import '../question.dart';
import 'practice_questions/fake_profile_practice/fake_profiles_practice_1.dart';
import 'practice_questions/fake_profile_practice/fake_profiles_practice_2.dart';
import 'practice_questions/fake_profile_practice/fake_profiles_practice_3.dart';
import 'practice_questions/fake_profile_practice/fake_profiles_practice_4.dart';
import 'practice_questions/fake_profile_practice/fake_profiles_practice_5.dart';
import 'practice_questions/fake_profile_practice/fake_profiles_practice_6.dart';
import 'practice_questions/fake_profile_practice/fake_profiles_practice_7.dart';
import 'practice_questions/fake_profile_practice/fake_profiles_practice_8.dart';
import 'practice_questions/fake_profile_practice/fake_profiles_practice_all.dart';

import '../../styles/app_colors.dart';
import '../../styles/text_styles.dart';

import '../buttons/menu_button.dart';
import '../buttons/next_button.dart';
import '../buttons/speed_button.dart';
import '../text_box/text_box.dart';


class PracticeScreen extends StatefulWidget {
  const PracticeScreen({
    super.key,
    required this.onSelectAnswer, required this.quizNumber,

  });
  final void Function(String answer) onSelectAnswer;
  final int quizNumber;

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


    // TODO: Update these practices to match lesson and pick random practice
    if(widget.quizNumber == 1) {
      practiceQuestions = fakeProfilesPractice1;
      //practiceName = "PRACTICE: SOCIAL MEDIA NORMS";
    }
    else if(widget.quizNumber == 2) {
      practiceQuestions = fakeProfilesPractice2;
      //practiceName = "PRACTICE: SETTINGS";
    }
    else if(widget.quizNumber == 3) {
      practiceQuestions = fakeProfilesPractice3;
    }
    else if(widget.quizNumber == 4) {
      practiceQuestions = fakeProfilesPractice4;
    }
    else if(widget.quizNumber == 5) {
      practiceQuestions = appropriateInteractionsPractice1;
    }
    else if(widget.quizNumber == 6) {
      practiceQuestions = fakeProfilesPractice6;
    }
    else if(widget.quizNumber == 7) {
      practiceQuestions = fakeProfilesPractice7;
    }
    else if(widget.quizNumber == 8) {
      practiceQuestions = fakeProfilesPractice8;
    }
    else if(widget.quizNumber == 9) {
      practiceQuestions = fakeProfilesPracticeAll;
    }
    else {
      practiceQuestions = [];
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

  Future<void> recordTicket() async {
    if (questionIndex == practiceQuestions.length - 1) {
      DataSnapshot snapshot = await _database.child('profile').child(user2!.uid).child('numTickets').get();
      int numTickets = snapshot.value as int;
      await _database.child('profile/${user2?.uid}').update({
        'numTickets': numTickets+1,
      });
    }
  }

  Future<void> nextQuestion(String answer) async {
    setState(() {
      checkedAnswer = false;
      isCorrect = false;
      selectedIndex = 10;
      tempAnswer = "";
      if (questionIndex < practiceQuestions.length - 1) {
        questionIndex++;
      }
    });
    widget.onSelectAnswer(answer);
  }

  @override
  Widget build(BuildContext context) {
    dynamic currentQuestion;

    if (practiceQuestions.isNotEmpty) {
      currentQuestion = practiceQuestions[questionIndex];
    }
    else {
      currentQuestion = const Question("no", "none", "no", ["none"], "none",);
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
                // const Expanded(
                //   child: SpeedButton(),
                // ),
                Expanded(
                  child: NextButton(
                    buttonText: questionIndex == practiceQuestions.length -1 && isCorrect == true ? "FINISH" : isCorrect == false ? "CHECK" : "NEXT" ,
                    onTap: () {
                      setState(() {
                        if (isCorrect && checkedAnswer && questionIndex == practiceQuestions.length - 1) {
                          // End practice
                          recordTicket();
                          nextQuestion(tempAnswer);
                        }
                        else if (isCorrect && checkedAnswer) {
                          // TODO: This may have unexpected behavior is user gets the right answer then changes answer to incorrect response
                          // Move onto next question after correct and checked have been set
                          nextQuestion(tempAnswer);
                          selectedIndex = 10;
                        }
                        else if(currentQuestion.correctAnswer == tempAnswer){
                          // Set correct and checked
                          isCorrect = true;
                          checkedAnswer = true;
                        }
                        else{
                          isCorrect = false;
                          checkedAnswer = true;
                        }
                      });
                    },
                    disabled: tempAnswer == "",
                  ),
                ),
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
                    currentQuestion.context == "no" ? SizedBox.shrink() : TextBox(currentText: currentQuestion.context,),
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
                          // textAlign: TextAlign.center, // Centers the text within the button
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
                      'Correct!',
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
