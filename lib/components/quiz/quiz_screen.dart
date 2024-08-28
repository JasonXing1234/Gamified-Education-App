import 'package:flutter/material.dart';
import 'package:quiz/components/buttons/answer_button.dart';
import 'package:quiz/components/buttons/menu_button.dart';
import 'package:quiz/components/buttons/sound_button.dart';
import 'package:quiz/components/lesson/lesson_screen.dart';
import 'package:quiz/components/quiz/quiz_questions/quiz1.dart';
import 'package:quiz/components/question.dart';
import 'package:quiz/styles/app_colors.dart';

import '../progress_bar.dart';
import 'quiz_questions/quiz2.dart';
import 'quiz_questions/quiz3.dart';
import 'quiz_questions/quiz4.dart';
import 'quiz_questions/quiz5.dart';
import 'quiz_questions/quiz6.dart';

import '../buttons/next_button.dart';
import '../text_box/text_box.dart';

import 'package:quiz/styles/text_styles.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({
    super.key,
    required this.onSelectAnswer,
    required this.quizNumber,
  });

  final void Function(String answer) onSelectAnswer;
  final int quizNumber;

  @override
  State<QuizScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuizScreen> {
  int questionIndex = 0;
  TextEditingController _controller = TextEditingController();
  String tempAnswer = "";
  int selectedIndex = 10;

  final AppTextStyles textStyles = AppTextStyles();
  final AppColors appColors = const AppColors();

  void dispose() {
    // Dispose the controller when the widget is disposed
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Question> quizQuestions;

    Question currentQuestion;



    var quizName = "QUIZ";

    if(widget.quizNumber == 1) {
      quizQuestions = quiz1;
      quizName = "QUIZ: SOCIAL MEDIA NORMS";
    }
    else if(widget.quizNumber == 2) {
      quizQuestions = quiz2;
      quizName = "QUIZ: SETTINGS";
    }
    else if(widget.quizNumber == 3) {
      quizQuestions = quiz3;
      quizName = "QUIZ: FAKE PROFILES";
    }
    else if(widget.quizNumber == 4) {
      quizQuestions = quiz4;
      quizName = "QUIZ: SOCIAL TAGS";
    }
    else if(widget.quizNumber == 5) {
      quizQuestions = quiz5;
      quizName = "QUIZ: APPROPRIATE INTERACTIONS";
    }
    else if(widget.quizNumber == 6) {
      quizQuestions = quiz6;
      quizName = "QUIZ: SOCIAL MEDIA VS REALITY";
    }
    else {
      quizQuestions = [];
    }

    if (quizQuestions.isNotEmpty) {
      currentQuestion = quizQuestions[questionIndex];
    }
    else {
      currentQuestion = const Question("no", "none", "no", ["none"]);
    }

    void nextQuestion(String answer) {
      setState(() {
        if (questionIndex < quizQuestions.length - 1) {
          questionIndex++;
        }
        //_controller.dispose();
      });
      widget.onSelectAnswer(answer);
    }

    Widget screen;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.only(top: 30.0), // Adjust the top padding of title
          child: Text(
            quizName,
            style: textStyles.heading1,
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
                child: MenuButton(),
              ),
              const Expanded(
                child: SoundButton(),
              ),
              Expanded(
                child: NextButton(
                  onTap: () {
                    setState(() {
                      
                      // if (questionIndex == quizQuestions.length -1) { // Zero indexing
                      //   // Already on last page
                      //   Navigator.of(context).pop();
                      //   // Navigator.of(context).pushAndRemoveUntil(
                      //   //   MaterialPageRoute(builder: (context) => LessonScreen(lessonNumber: widget.quizNumber)),
                      //   //       (route) => false, // This removes all previous routes
                      //   // );
                      // }
                      // else {
                        if(currentQuestion.answerOptions[0] == 'textField'){
                          nextQuestion(_controller.text);
                        }
                        else{
                          nextQuestion(tempAnswer);
                        }
                        selectedIndex = 10;
                      // }
                    });
                  },
                  disabled: false,
                ),
              ),
            ],
          ),
        ),
      ),

      body: Stack (
        children: [
          SingleChildScrollView(
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
                    currentQuestion.context == "no" ? SizedBox.shrink() : TextBox(currentText: currentQuestion.context),
                    currentQuestion.context == "no" ? SizedBox.shrink() : const SizedBox(height: 20), // Add an extra space between context & question box
                    TextBox(currentText: currentQuestion),
                    currentQuestion.photo == 'no' ? SizedBox.shrink() : Image.asset(currentQuestion.photo),
                    const SizedBox(
                      height: 30,
                    ),
                    if(currentQuestion.answerOptions[0] != 'textField') ...currentQuestion.answerOptions.asMap().entries.map(
                          (answer) => AnswerButton(
                        answerText: answer.value,
                        onTap: () {
                          setState(() {
                            selectedIndex = answer.key;
                            tempAnswer = answer.value;
                          });
                        }, color: selectedIndex == answer.key ? appColors.royalBlue : appColors.grey,
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

