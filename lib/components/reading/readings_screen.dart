import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:quiz/components/buttons/answer_button.dart';
import 'package:quiz/components/reading/reading_page.dart';
import 'package:quiz/components/reading/readings/reading1.dart';
import 'package:quiz/components/progress_bar/progress_bar.dart';
import 'package:quiz/components/reading/readings/reading2.dart';
import 'package:quiz/components/reading/readings/reading3.dart';
import 'package:quiz/components/reading/readings/reading4.dart';
import 'package:quiz/components/reading/readings/reading5.dart';
import 'package:quiz/components/reading/readings/reading6.dart';

import '../../styles/app_colors.dart';
import '../../styles/text_styles.dart';
import '../buttons/menu_button.dart';
import '../buttons/next_button.dart';
import '../buttons/speed_button.dart';
import '../lesson/lesson_screen.dart';
import '../text_box/text_box.dart';


class ReadingsScreen extends StatefulWidget {
  const ReadingsScreen({
    super.key,
    required this.readingNumber
  });

  final int readingNumber;

  @override
  State<ReadingsScreen> createState() => _ReadingsScreenState();
}


class _ReadingsScreenState extends State<ReadingsScreen> {
  int readingPageIndex = 0;

  final TextEditingController _controller = TextEditingController();

  int selectedAnswerIndex = 10; // For answer options for single correct answer
  String selectedAnswerValue = "";

  // For answer options for multiple correct answers
  List<String> selectedAnswers = [];


  final AppTextStyles textStyles = AppTextStyles();
  final AppColors appColors = const AppColors();

  final ScrollController _scrollController = ScrollController();
  
  final DatabaseReference _database = FirebaseDatabase.instance.ref();
  User? user2 = FirebaseAuth.instance.currentUser;
  List<dynamic> readings = [1,1,1,1,1,1];
  Future<int?>? _readingListFuture;
  
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScrollEnd);
    _readingListFuture = _fetchReadingList();
  }

  void _onScrollEnd() {
    // TODO: this is not scrolling all the way to the top.
    // Maybe because of the set up the height constant, but then the real height changes with more text boxes something?
    // the Quiz screen reset scroll is working fine?


    if (!_scrollController.position.isScrollingNotifier.value) {
      // Get the current scroll offset
      double offset = _scrollController.offset;

      // Define the height of each "screen"
      double screenHeight = MediaQuery.of(context).size.height;

      double totalHeight = offset + screenHeight - 40;  // Subtract padding


      // Find the nearest "screen" to snap to
      int targetPage = (totalHeight / screenHeight).round();

      // Snap to the exact position of the nearest page
      double targetOffset = targetPage * screenHeight;

      // Scroll to that "screen"
      _scrollController.jumpTo(targetOffset);

      // _scrollController.animateTo(
      //   0,
      //   duration: const Duration(milliseconds: 300),
      //   curve: Curves.easeInOut,
      // );
    }
  }


  // Asynchronous function to fetch reading list data
  Future<int?> _fetchReadingList() async {
    if (user2 != null) {
      try {
        DataSnapshot snapshot = await _database
            .child('profile')
            .child(user2!.uid)
            .child('readingList')
            .get();

        if (snapshot.value != null) {
          setState(() {
            readings = snapshot.value as List<dynamic>;
            readingPageIndex = readings[widget.readingNumber - 1];
          });
        }
        return readingPageIndex;
      } catch (e) {
        // Handle potential errors, like network issues
        print('Error fetching reading list: $e');
      }
    }
  }

  Future<void> nextReadingPage({String userAnswer = ""}) async {
    setState(() {
      readingPageIndex++;
    });
    DataSnapshot snapshot = await _database.child('profile').child(user2!.uid).child('readingList').get();
    List<dynamic> readings = snapshot.value as List<dynamic>;
    readings[widget.readingNumber - 1] = readingPageIndex;
    await _database.child('profile/${user2?.uid}').update({
      'readingList': readings,
    });
      //_controller.dispose();
    setState(() {
      _readingListFuture = _fetchReadingList();  // Refresh FutureBuilder
    });
  }

  void dispose() {
    // Dispose the controller when the widget is disposed
    _scrollController.removeListener(_onScrollEnd);
    _scrollController.dispose();
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
      readingPages = reading3;
      lessonName = "FAKE PROFILES";
    }
    else if(widget.readingNumber == 4) {
      readingPages = reading4;
      lessonName = "SOCIAL TAGS";
    }
    else if(widget.readingNumber == 5) {
      readingPages = reading5;
      lessonName = "INTERACTION ETIQUETTE";
    }
    else if(widget.readingNumber == 6) {
      readingPages = reading6;
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
        toolbarHeight: 70,
        title: Padding(
          padding: const EdgeInsets.only(top: 20.0), // Adjust the top padding of title
          child: Text(
            lessonName,
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
                  buttonText: readingPageIndex == readingPages.length -1 ? "FINISH" : "NEXT",
                  onTap: () {
                    setState(() {
                      if (readingPageIndex == readingPages.length -1) { // Zero indexing
                        // TODO: Reset user readingList for current lesson


                        // Already on last page
                        Navigator.of(context).pop();

                      }
                      else {
                        if (currentReadingPage is ReadingMultipleAnswersQuestion) {
                          if (currentReadingPage.answerOptions[0] == "textField") {
                            // Add a controller text to get access to the answer
                            nextReadingPage(userAnswer: _controller.text);
                          }
                        }
                        else {
                          nextReadingPage();
                        }
                      }

                      // Clear Answers for next question
                      selectedAnswerIndex = 10;
                      selectedAnswers = [];

                    });
                  },
                  disabled: false,
                ),
              ),
            ],
          ),
        ),
      ),

      body: FutureBuilder<int?>(
        future: _readingListFuture,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          else {
            return Stack(
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
                            height: 20,
                          ),

                          // Text field question
                          if (currentReadingPage is ReadingMultipleAnswersQuestion)
                            if (currentReadingPage.answerOptions[0] == 'textField')
                              TextFormField(controller: _controller,
                                decoration: const InputDecoration(
                                  labelText: 'Enter your text',
                                  border: OutlineInputBorder(),
                                ),),

                          // Select multiple answer options
                          if (currentReadingPage is ReadingMultipleAnswersQuestion)
                            if(currentReadingPage.answerOptions[0] != 'textField') ...currentReadingPage.answerOptions.asMap().entries.map(
                                  (answer) => AnswerButton(
                                answerText: answer.value,
                                onTap: () {
                                  setState(() {
                                    if (selectedAnswers.contains(answer.value)) {
                                      selectedAnswers.remove(answer.value); // Deselect if already selected
                                    } else {
                                      selectedAnswers.add(answer.value); // Select if not already selected
                                    }
                                  });
                                }, color: selectedAnswers.contains(answer.value) ? appColors.royalBlue : appColors.grey,
                              ),
                            ),

                          const SizedBox(
                            height: 20,
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
                  child: ProgressBar(pageIndex: snapshot.data!, pageList: readingPages),
                )
              ],
          );}})

    );
  }
}



