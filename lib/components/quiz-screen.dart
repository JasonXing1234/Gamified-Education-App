import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz/components/answer_button.dart';
import 'package:quiz/data/quiz1.dart';
import 'package:quiz/data/quiz_data.dart';

import '../data/quiz2.dart';

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
    var currentQuestion = quiz1[questionIndex];
    if(widget.quizNumber == 1) {
      currentQuestion = quiz1[questionIndex];
    }
    else if(widget.quizNumber == 2) {
      currentQuestion = quiz2[questionIndex];
    }
    return SingleChildScrollView(child:Container(
      padding: const EdgeInsets.all(40),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            currentQuestion.question,
            textAlign: TextAlign.center,
            style: GoogleFonts.lato(
              color: const Color.fromARGB(255, 255, 153, 245),
              fontSize: 24,
            ),
          ),
          currentQuestion.photo == 'no' ? SizedBox.shrink() : Image.asset(currentQuestion.photo),
          const SizedBox(
            height: 30,
          ),
          if(currentQuestion.answers[0] != 'textField') ...currentQuestion.getShuffledAnswers().map(
                (answer) => AnswerButton(
              answerText: answer,
              onTap: () {
                nextQuestion(answer);
              }, color: Colors.grey,
            ),
          ),
          if(currentQuestion.answers[0] == 'textField')
            TextFormField(controller: _controller,
            decoration: InputDecoration(
              labelText: 'Enter your text',
              border: OutlineInputBorder(),
            ),),
          if(currentQuestion.answers[0] == 'textField')
            AnswerButton(
              answerText: 'Next Question',
              onTap: () {
                nextQuestion(_controller.text);
              }, color: Colors.grey,
            ),
        ],
      ),
    ));
  }
}