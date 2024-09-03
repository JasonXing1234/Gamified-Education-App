import 'package:flutter/material.dart';
import 'package:quiz/components/reading/reading_page.dart';
import 'package:quiz/components/reading/readings/reading1.dart';
import 'package:quiz/components/progress_bar/progress_bar.dart';
import 'package:quiz/components/reading/readings/reading2.dart';

import '../../styles/app_colors.dart';
import '../../styles/text_styles.dart';
import '../buttons/menu_button.dart';
import '../buttons/next_button.dart';
import '../buttons/sound_button.dart';
import '../lesson/lesson_screen.dart';
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

  void nextReadingPage() {
    setState(() {
      readingPageIndex++;
      // _controller.dispose();
    });
  }

  void dispose() {
    // Dispose the controller when the widget is disposed
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<ReadingPage> readingPages;
    ReadingPage currentReadingPage;
    var lessonName = "LESSON";

    if(widget.readingNumber == 1) {
      readingPages = reading1;
      lessonName = "SOCIAL MEDIA NORMS";
    }
    else if(widget.readingNumber == 2) {
      readingPages = reading2;
      lessonName = "SETTINGS";
    }
    else if(widget.readingNumber == 3) {
      readingPages = reading1;
      lessonName = "FAKE PROFILES";
    }
    else if(widget.readingNumber == 4) {
      readingPages = reading1;
      lessonName = "SOCIAL TAGS";
    }
    else if(widget.readingNumber == 5) {
      readingPages = reading1;
      lessonName = "APPROPRIATE INTERACTIONS";
    }
    else if(widget.readingNumber == 6) {
      readingPages = reading1;
      lessonName = "SOCIAL MEDIA VS REALITY";
    }
    else {
      readingPages = [];
    }

    if (readingPages.isNotEmpty) {
      currentReadingPage = readingPages[readingPageIndex];
    }
    else {
      currentReadingPage = const ReadingPage("none", ["none"], "no");
    }


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
                  buttonText: readingPageIndex == readingPages.length -1 ? "FINISH" : "NEXT",
                  onTap: () {
                    setState(() {
                      if (readingPageIndex == readingPages.length -1) { // Zero indexing
                        // Already on last page
                        Navigator.of(context).pop();
                      }
                      else {
                        nextReadingPage();
                      }

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
                      height: 10,
                    ),
                    Text(
                      currentReadingPage.title,
                      style: textStyles.heading1,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    currentReadingPage.text.isNotEmpty ? Container(child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: currentReadingPage.text.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0), // Adjust the padding as needed
                          child: TextBox(currentText: currentReadingPage.text[index]),
                        );
                      },
                    )) : TextBox(currentText: "Click next"),
                    const SizedBox(
                      height: 30,
                    ),
                    currentReadingPage.photo == "no" ? const SizedBox.shrink() : Image.asset(currentReadingPage.photo),
                    const SizedBox(
                      height: 60,
                    ),
                  ],
                ),
              )
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            color: Colors.white,
            child: ProgressBar(pageIndex: readingPageIndex, pageList: readingPages),
          )
        ],
      ),

    );
  }
}



