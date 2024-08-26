import 'package:flutter/material.dart';

import '../../styles/app_colors.dart';
import '../../styles/text_styles.dart';
import '../buttons/menu_button.dart';
import '../buttons/next_button.dart';
import '../buttons/sound_button.dart';

class LessonScreen extends StatefulWidget {
  const LessonScreen({
    super.key,
    required this.lessonNumber,
  });

  final int lessonNumber;

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}


class _LessonScreenState extends State<LessonScreen> {
  int slideIndex = 0;
  TextEditingController _controller = TextEditingController();
  String tempAnswer = "";
  int selectedIndex = 10;

  final AppTextStyles textStyles = AppTextStyles();
  final AppColors appColors = const AppColors();

  void nextQuestion(String answer) {
    setState(() {
      slideIndex++;
      //_controller.dispose();
    });
  }

  void dispose() {
    // Dispose the controller when the widget is disposed
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var currentText = "Lesson material...";

    var lessonName = "LESSON";


    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          lessonName,
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
                const SizedBox(
                  height: 30,
                ),
                const SizedBox(
                  height: 60,
                ),
              ],
            ),
          )
      ),
    );
  }
}