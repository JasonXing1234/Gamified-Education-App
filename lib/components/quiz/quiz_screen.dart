import 'package:flutter/material.dart';
import 'package:quiz/components/buttons/answer_button.dart';
import 'package:quiz/components/buttons/menu_button.dart';
import 'package:quiz/components/buttons/sound_button.dart';
import 'package:quiz/components/quiz/quiz_questions/quiz1.dart';
import 'package:quiz/components/question.dart';
import 'package:quiz/styles/app_colors.dart';

import '../progress_bar/progress_bar.dart';
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

  //For multiple answer options
  List<String> selectedAnswers = [];

  final AppTextStyles textStyles = AppTextStyles();
  final AppColors appColors = const AppColors();

  final ScrollController _scrollController = ScrollController();

  List<Question> quizQuestions = [];
  String quizName = "QUIZ";


  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScrollEnd);

    if(widget.quizNumber == 1) {
      quizQuestions = quiz1;
      // quizName = "QUIZ: SOCIAL MEDIA NORMS";
    }
    else if(widget.quizNumber == 2) {
      quizQuestions = quiz2;
      // quizName = "QUIZ: SETTINGS";
    }
    else if(widget.quizNumber == 3) {
      quizQuestions = quiz3;
      // quizName = "QUIZ: FAKE PROFILES";
    }
    else if(widget.quizNumber == 4) {
      quizQuestions = quiz4;
      // quizName = "QUIZ: SOCIAL TAGS";
    }
    else if(widget.quizNumber == 5) {
      quizQuestions = quiz5;
      // quizName = "QUIZ: APPROPRIATE INTERACTIONS";
    }
    else if(widget.quizNumber == 6) {
      quizQuestions = quiz6;
      // quizName = "QUIZ: SOCIAL MEDIA VS REALITY";
    }
    else {
      quizQuestions = [];
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


  void nextQuestion(String answer) {
    setState(() {
      if (questionIndex < quizQuestions.length - 1) {
        questionIndex++;
      }
      //_controller.dispose();
    });
    widget.onSelectAnswer(answer);
  }


  @override
  Widget build(BuildContext context) {

    Question currentQuestion;

    if (quizQuestions.isNotEmpty) {
      currentQuestion = quizQuestions[questionIndex];
    }
    else {
      currentQuestion = const Question("no", "none", "no", ["none"]);
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
                child: SpeedButton(),
              ),
              Expanded(
                child: NextButton(
                  buttonText: questionIndex == quizQuestions.length -1 ? "SUBMIT" : "NEXT",
                  onTap: () {
                    setState(() {
                        if(currentQuestion.answerOptions[0] == 'textField'){
                          nextQuestion(_controller.text);
                        }
                        else{
                          if (currentQuestion is MultipleAnswersQuestion) {
                            String sep = "";
                            tempAnswer = "";

                            // Sort the answers selected and make a string to compare with the correct answers
                            // Also set up in the same way
                            selectedAnswers.sort();
                            for (var selectionOption in selectedAnswers) {
                              tempAnswer = tempAnswer + sep + selectionOption;
                              sep = ", ";
                            }
                          }

                          nextQuestion(tempAnswer);
                        }
                        // Clear answers for next question
                        selectedIndex = 10;
                        selectedAnswers = [];

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
                    currentQuestion.context == "no" ? SizedBox.shrink() : TextBox(currentText: currentQuestion.context),
                    currentQuestion.context == "no" ? SizedBox.shrink() : const SizedBox(height: 20), // Add an extra space between context & question box
                    TextBox(currentText: currentQuestion),
                    currentQuestion.photo == 'no' ? SizedBox.shrink() : Image.asset(currentQuestion.photo),
                    const SizedBox(
                      height: 30,
                    ),

                    // Answer option Questions
                    if (currentQuestion is SingleAnswerQuestion) ...currentQuestion.answerOptions.asMap().entries.map(
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

                    // Multiple Answer Question
                    if (currentQuestion is MultipleAnswersQuestion)
                      if(currentQuestion.answerOptions[0] != 'textField') ...currentQuestion.answerOptions.asMap().entries.map(
                          (answer) => AnswerButton(
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
                        }, color: selectedAnswers.contains(answer.value) ? appColors.royalBlue : appColors.grey,
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

