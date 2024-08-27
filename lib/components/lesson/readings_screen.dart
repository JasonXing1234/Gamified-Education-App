import 'package:flutter/material.dart';
import 'package:quiz/components/lesson/reading_page.dart';
import 'package:quiz/components/lesson/readings/reading1.dart';

import '../../styles/app_colors.dart';
import '../../styles/text_styles.dart';
import '../buttons/menu_button.dart';
import '../buttons/next_button.dart';
import '../buttons/sound_button.dart';
import '../text_box/text_box.dart';


class ReadingsScreen extends StatefulWidget {
  const ReadingsScreen({
    super.key,
    required this.readingNumber,
  });

  final int readingNumber;

  @override
  State<ReadingsScreen> createState() => _ReadingsScreenState();
}


class _ReadingsScreenState extends State<ReadingsScreen> {
  int readingPageIndex = 0;
  TextEditingController _controller = TextEditingController();

  final AppTextStyles textStyles = AppTextStyles();
  final AppColors appColors = const AppColors();

  void nextReadingPage(String answer) {
    setState(() {
      readingPageIndex++;
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
    ReadingPage currentReadingPage;
    var lessonName = "LESSON";

    if(widget.readingNumber == 1) {
      currentReadingPage = reading1[readingPageIndex];
      lessonName = "SOCIAL MEDIA NORMS";
    }
    else if(widget.readingNumber == 2) {
      currentReadingPage = reading1[readingPageIndex];
      lessonName = "SETTINGS";
    }
    else if(widget.readingNumber == 3) {
      currentReadingPage = reading1[readingPageIndex];
      lessonName = "FAKE PROFILES";
    }
    else if(widget.readingNumber == 4) {
      currentReadingPage = reading1[readingPageIndex];
      lessonName = "SOCIAL TAGS";
    }
    else if(widget.readingNumber == 5) {
      currentReadingPage = reading1[readingPageIndex];
      lessonName = "APPROPRIATE INTERACTIONS";
    }
    else if(widget.readingNumber == 6) {
      currentReadingPage = reading1[readingPageIndex];
      lessonName = "SOCIAL MEDIA VS REALITY";
    }
    else {
      currentReadingPage = const ReadingPage("none", [], "no");
    }

    //print('Current readingPageIndex: $readingPageIndex');


    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.only(top: 30.0), // Adjust the top padding of title
          child: Text(
            lessonName,
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
                Text(
                  currentReadingPage.title,
                ),
                TextBox(
                  currentText: currentReadingPage.text[0], // TODO: Show each text box for lesson
                ),
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