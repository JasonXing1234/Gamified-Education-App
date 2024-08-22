import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz/components/buttons/answer_button.dart';
import 'package:quiz/components/buttons/menu_button.dart';
import 'package:quiz/components/buttons/sound_button.dart';
import 'package:quiz/data/quiz1.dart';
import 'package:quiz/data/quiz_data.dart';

import '../data/quiz2.dart';
import '../models/quiz_quiz.dart';
import 'buttons/next_button.dart';
import 'text_box/text_box.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({
    super.key,
    required this.onSelectAnswer, required this.quizNumber,
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

  final Color royalBlue = const Color(0xff2E83E8);
  final Color grey = const Color(0xff939393);

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
    if(widget.quizNumber == 1) {
      currentQuestion = quiz1[questionIndex];
    }
    else if(widget.quizNumber == 2) {
      currentQuestion = quiz2[questionIndex];
    }


    return Scaffold(
      appBar: AppBar(
        title: Text(''),
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
                  }, color: selectedIndex == answer.key ? royalBlue : grey,
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

