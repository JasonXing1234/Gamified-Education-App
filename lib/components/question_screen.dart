import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz/components/buttons/answer_button.dart';
import 'package:quiz/data/quiz_data.dart';

import '../data/quiz_data2.dart';
import '../data/quiz_data3.dart';
import '../data/quiz_data4.dart';
import '../data/quiz_data5.dart';
import '../data/quiz_data6.dart';
import '../data/quiz_data7.dart';
import '../data/quiz_data8.dart';
import '../data/quiz_sum.dart';
import '../styles/app_colors.dart';
import '../styles/text_styles.dart';
import 'buttons/menu_button.dart';
import 'buttons/next_button.dart';
import 'buttons/sound_button.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({
    super.key,
    required this.onSelectAnswer, required this.quizNumber,

  });
  final void Function(String answer) onSelectAnswer;
  final int quizNumber;

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  bool isCorrect = true;
  int questionIndex = 0;
  String tempAnswer = "";
  int selectedIndex = 4;
  int counter = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final AppTextStyles textStyles = AppTextStyles();
  final AppColors appColors = const AppColors();


  void nextQuestion(String answer) {
    setState(() {
      questionIndex++;
    });
    widget.onSelectAnswer(answer);
  }

  @override
  Widget build(BuildContext context) {

    var currentQuestion = questionSum[questionIndex];
    var practiceName = "PRACTICE";

    if(widget.quizNumber == 1) {
      currentQuestion = questions[questionIndex];
      practiceName = "PRACTICE: SOCIAL MEDIA NORMS";
    }
    else if(widget.quizNumber == 2) {
      currentQuestion = questions2[questionIndex];
      practiceName = "PRACTICE: SETTINGS";
    }
    else if(widget.quizNumber == 3) {
      currentQuestion = questions3[questionIndex];
    }
    else if(widget.quizNumber == 4) {
      currentQuestion = questions4[questionIndex];
    }
    else if(widget.quizNumber == 5) {
      currentQuestion = questions5[questionIndex];
    }
    else if(widget.quizNumber == 6) {
      currentQuestion = questions6[questionIndex];
    }
    else if(widget.quizNumber == 7) {
      currentQuestion = questions7[questionIndex];
    }
    else if(widget.quizNumber == 8) {
      currentQuestion = questions8[questionIndex];
    }
    else if(widget.quizNumber == 9) {
      currentQuestion = questionSum[questionIndex];
    }


    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            practiceName,
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
                    onTap: () {
                      setState(() {
                        if(currentQuestion.answers[0] == tempAnswer || counter == 2){
                          isCorrect = true;
                          counter = 0;
                          nextQuestion(tempAnswer);
                        }
                        else{
                          isCorrect = false;
                          if(counter < 2){
                            counter++;
                          }
                        }
                        selectedIndex = 4;
                      });
                    },
                    disabled: false,
                  ),
                ),
              ],
            ),
          ),
        ),

        body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(40),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  counter == 2 ? Text(
                    'You answered incorrectly twice in a row. Please review slide 9 of the course materials to better understand this concept.',
                    textAlign: TextAlign.left,
                    style: textStyles.bodyText,
                  ) : Text(
                    currentQuestion.text,
                    textAlign: TextAlign.left,
                    style: textStyles.bodyText,
                  ),
                  currentQuestion.photo == 'no' ? SizedBox.shrink() : Image.asset(currentQuestion.photo),
                  const SizedBox(
                    height: 30,
                  ),
                  counter == 2 ? SizedBox.shrink() : isCorrect == false ? Text(
                    'The answer was incorrect. Please try again.',
                    textAlign: TextAlign.left,
                    style: textStyles.bodyTextCustom(appColors.red, 24),
                  ) : SizedBox.shrink(),
                  counter == 2 ? SizedBox.shrink() : Text(
                    currentQuestion.question,
                    textAlign: TextAlign.left,
                    style: textStyles.bodyText,
                  ),
                  ...currentQuestion.answers.asMap().entries.map(
                        (answer) => counter == 2 ? SizedBox.shrink() : AnswerButton(
                          color: selectedIndex == answer.key ? appColors.royalBlue : appColors.grey,
                          answerText: answer.value,
                          onTap: () {
                            setState(() {
                              selectedIndex = answer.key;
                              tempAnswer = answer.value;
                            });
                          },
                        ),
                      ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
        ),
    );
  }
}
