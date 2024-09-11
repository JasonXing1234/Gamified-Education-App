import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:quiz/components/buttons/answer_button.dart';
import 'package:quiz/components/progress_bar/progress_bar.dart';

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
import '../buttons/sound_button.dart';
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
  bool isCorrect = true;
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

    if(widget.quizNumber == 1) {
      practiceQuestions = fakeProfilesPractice1;
      practiceName = "PRACTICE: SOCIAL MEDIA NORMS";
    }
    else if(widget.quizNumber == 2) {
      practiceQuestions = fakeProfilesPractice2;
      practiceName = "PRACTICE: SETTINGS";
    }
    else if(widget.quizNumber == 3) {
      practiceQuestions = fakeProfilesPractice3;
    }
    else if(widget.quizNumber == 4) {
      practiceQuestions = fakeProfilesPractice4;
    }
    else if(widget.quizNumber == 5) {
      practiceQuestions = fakeProfilesPractice5;
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
      practiceName = "PRACTICE: FAKE PROFILES";
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

  Future<void> recordStar() async {
    Navigator.of(context).pop();
    if (questionIndex == practiceQuestions.length - 1) {
      DataSnapshot snapshot = await _database.child('profile').child(user2!.uid).child('numStars').get();
      int numStars = snapshot.value as int;
      await _database.child('profile/${user2?.uid}').update({
        'numStars': numStars+1,
      });
    }
  }

  Future<void> nextQuestion(String answer) async {
    setState(() {
      if (questionIndex < practiceQuestions.length - 1) {
        questionIndex++;
      }
    });
    widget.onSelectAnswer(answer);
  }

  @override
  Widget build(BuildContext context) {
    Question currentQuestion;

    if (practiceQuestions.isNotEmpty) {
      currentQuestion = practiceQuestions[questionIndex];
    }
    else {
      currentQuestion = const Question("no", "none", "no", ["none"]);
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
                    buttonText: questionIndex == practiceQuestions.length -1 ? "FINISH" : "NEXT",
                    onTap: () {
                      setState(() {
                        if (questionIndex == practiceQuestions.length - 1) {
                          recordStar();
                          Navigator.of(context).pop();
                        }
                        else if(currentQuestion.answerOptions[0] == tempAnswer){
                          isCorrect = true;
                          nextQuestion(tempAnswer);
                        }
                        else{
                          isCorrect = false;
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
                    const SizedBox(
                      height: 30,
                    ),
                    currentQuestion.photo == 'no' ? SizedBox.shrink() : Image.asset(currentQuestion.photo),
                    const SizedBox(
                      height: 30,
                    ),
                    isCorrect == false ? Text(
                      'The answer was incorrect. Please try again.',
                      textAlign: TextAlign.left,
                      style: textStyles.customBodyText(appColors.red, 24),
                    ) : SizedBox.shrink(),
                    const SizedBox(
                      height: 15,
                    ),

                    counter == 2 ? SizedBox.shrink() : TextBox(
                      currentText: currentQuestion,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ...currentQuestion.answerOptions.asMap().entries.map(
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
