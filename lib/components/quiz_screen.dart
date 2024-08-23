import 'package:flutter/material.dart';
import 'package:quiz/components/buttons/answer_button.dart';
import 'package:quiz/components/buttons/menu_button.dart';
import 'package:quiz/components/buttons/sound_button.dart';
import 'package:quiz/data/quiz1.dart';
import 'package:quiz/data/quiz_data.dart';
import 'package:quiz/styles/app_colors.dart';

import '../data/quiz2.dart';
import '../models/quiz_quiz.dart';
import 'buttons/next_button.dart';
import 'text_box/text_box.dart';

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

  void nextQuestion(String answer) {
    setState(() {
      questionIndex++;
      //_controller.dispose();
    });
    widget.onSelectAnswer(answer);
  }

  void dispose() {
    // Dispose the controller when the widget is disposed
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var currentQuestion;

    var quizName = "QUIZ";

    if(widget.quizNumber == 1) {
      currentQuestion = quiz1[questionIndex];
      quizName = "QUIZ: SOCIAL MEDIA NORMS";
    }
    else if(widget.quizNumber == 2) {
      currentQuestion = quiz2[questionIndex];
      quizName = "QUIZ: SETTINGS";
    }


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
                child: MenuButton(),
              ),
              const Expanded(
                child: SoundButton(),
              ),
              Expanded(
                child: NextButton(
                  onTap: () {
                    setState(() {
                      if(currentQuestion.answers[0] == 'textField'){
                        nextQuestion(_controller.text);
                      }
                      else{
                        nextQuestion(tempAnswer);
                      }
                      selectedIndex = 10;
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
              TextBox(currentQuestion: currentQuestion),
              currentQuestion.photo == 'no' ? SizedBox.shrink() : Image.asset(currentQuestion.photo),
              const SizedBox(
                height: 30,
              ),
              if(currentQuestion.answers[0] != 'textField') ...currentQuestion.answers.asMap().entries.map(
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
              if(currentQuestion.answers[0] == 'textField')
                TextFormField(controller: _controller,
                  decoration: const InputDecoration(
                    labelText: 'Enter your text',
                    border: OutlineInputBorder(),
                  ),),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        )
      ),
    );
  }
}

