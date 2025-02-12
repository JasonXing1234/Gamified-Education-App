import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:quiz/components/buttons/listen_button.dart';
import 'package:quiz/components/buttons/answer_button.dart';
import 'package:quiz/components/reading/reading_page.dart';
import 'package:quiz/components/progress_bar/progress_bar.dart';


import '../../SQLITE/sqliteHelper.dart';
import '../../styles/app_colors.dart';
import '../../styles/text_styles.dart';
import '../buttons/next_button.dart';
import '../lesson/lesson.dart';
import '../text_box/text_box.dart';


class ReadingsScreen extends StatefulWidget {
  const ReadingsScreen({
    super.key,
    required this.lesson,
    required this.openRewardPage,
  });

  final Lesson lesson;
  final void Function() openRewardPage;

  @override
  State<ReadingsScreen> createState() => _ReadingsScreenState();
}


class _ReadingsScreenState extends State<ReadingsScreen> {
  int readingPageIndex = 0;

  final TextEditingController _controller = TextEditingController();

  int selectedAnswerIndex = 10; // For answer options for single correct answer
  String selectedAnswerValue = "";
  bool isCorrect = true;

  // For answer options for multiple correct answers
  List<String> selectedAnswers = [];


  final AppTextStyles textStyles = AppTextStyles();
  final AppColors appColors = const AppColors();
  final DatabaseHelper _dbHelper = DatabaseHelper();
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
            // Assuming snapshot.value is a List of reading objects
            List<dynamic> readingList = snapshot.value as List<dynamic>;
            readings = readingList;

            // Assuming you want to access a specific reading object based on widget.readingNumber
            if (widget.lesson.lessonNumber - 1 < readings.length) {
              // Update the readingPageIndex based on the fetched reading object
              readingPageIndex = readings[widget.lesson.lessonNumber - 1]['progress']; // Access progress
            } else {
              readingPageIndex = 0; // Default or reset if index is out of bounds
            }
          });
          // setState(() {
          //   readings = snapshot.value as List<dynamic>;
          //   readingPageIndex = readings[widget.lesson.lessonNumber - 1];
          // });
        }
        return readingPageIndex;
      } catch (e) {
        // Handle potential errors, like network issues
        print('Error fetching reading list: $e');
      }
    }
  }

  Future<void> updateReadingProgress(String userId, int lessonNumber, int progress) async {
    await _dbHelper.updateReadingProgress(userId, lessonNumber, progress);
  }

  Future<List<Map<String, dynamic>>> fetchReadingList(String userId) async {
    return await _dbHelper.getReadingList(userId);
  }

  // Asynchronous function to update reading list data
  Future<int?> _updateReadingList() async {
    if (user2 != null) {
      try {
        DataSnapshot snapshot = await _database
            .child('profile')
            .child(user2!.uid)
            .child('readingList')
            .get();

        if (snapshot.value != null) {
          List<dynamic> readingList = snapshot.value as List<dynamic>;

          setState(() {
            readings = readingList;
          });
        }
        return readingPageIndex;
      } catch (e) {
        print('Error updating reading list: $e');
      }
    }
    return null;
  }

  Future<void> nextReadingPage({String userAnswer = ""}) async {
    // Increment reading page index locally
    int newReadingPageIndex = readingPageIndex + 1;
    print("DEBUG: Reading Page Index  ${newReadingPageIndex}");

    try {
      // Retrieve the user's reading list from the database
      DataSnapshot snapshot = await _database
          .child('profile')
          .child(user2!.uid)
          .child('readingList')
          .get();

      if (snapshot.value != null) {
        List<dynamic> readings = snapshot.value as List<dynamic>;
        print("DEBUG: Sanpshot is not null readings = ${readings}");

        // Update progress for the current lesson
        readings[widget.lesson.lessonNumber - 1]['progress'] = newReadingPageIndex;


        // Save updated reading list back to the database
        await _database.child('profile/${user2!.uid}/readingList').set(readings);
        final DatabaseHelper _dbHelper = DatabaseHelper();
        // Update progress for the current lesson in SQLite
        await _dbHelper.updateReadingProgress(
          user2!.uid,
          widget.lesson.lessonNumber,
          newReadingPageIndex,
        );
        // Update state after async updates are done
        setState(() {
          readingPageIndex = newReadingPageIndex;
          _readingListFuture = _updateReadingList();
        });
      }

      // Update state after async updates are done
      // TODO: Fixed reading so it advances, doesn't save the reading spot though
      setState(() {
        readingPageIndex = newReadingPageIndex;
        _readingListFuture = _updateReadingList();
      });

    } catch (e) {
      print('Error updating reading progress: $e');
    }

  }

  Future<void> prevReadingPage({String userAnswer = ""}) async {
    // Only decrement if readingPageIndex is greater than 0
    if (readingPageIndex > 0) {
      int newReadingPageIndex = readingPageIndex - 1;

      try {
        // Retrieve the user's reading list from the database
        DataSnapshot snapshot = await _database
            .child('profile')
            .child(user2!.uid)
            .child('readingList')
            .get();

        if (snapshot.value != null) {
          List<dynamic> readings = snapshot.value as List<dynamic>;
          readings[widget.lesson.lessonNumber - 1]['progress'] = newReadingPageIndex;
          await _database.child('profile/${user2!.uid}/readingList').set(readings);
          setState(() {
            readingPageIndex = newReadingPageIndex;
            _readingListFuture = _updateReadingList();
          });
          final DatabaseHelper _dbHelper = DatabaseHelper();
          // Update progress for the current lesson in SQLite
          await _dbHelper.updateReadingProgress(
            user2!.uid,
            widget.lesson.lessonNumber,
            newReadingPageIndex,
          );

        }

        // Update state after async updates are done
        setState(() {
          readingPageIndex = newReadingPageIndex;
          _readingListFuture = _updateReadingList();
        });


      } catch (e) {
        print("Error updating reading progress: $e");
      }
    } else {
      print("Already at the first page. Can't go back further.");
    }
  }

  Future<void> backToFirstPage() async {
    DataSnapshot snapshot = await _database.child('profile').child(user2!.uid).child('readingList').get();
    List<dynamic> readings = snapshot.value as List<dynamic>;
    readings[widget.lesson.lessonNumber - 1]['progress'] = 0;
    await _database.child('profile/${user2?.uid}').update({
      'readingList': readings,
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

    var lessonName = widget.lesson.title;
    readingPages = widget.lesson.reading;

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
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
          color: Colors.white,
          child: SizedBox(
            height: 60,
            child: Row(
              children: [
                Expanded(
                  child: MultiPurposeButton(
                    onTap: () {
                      setState(() {
                        if (readingPageIndex > 0) {
                          prevReadingPage();
                        }

                        // Clear Answers for next question
                        selectedAnswerIndex = 10;
                        selectedAnswers = [];

                      });
                    },
                    disabled: readingPageIndex == 0,
                    buttonType: ButtonType.back,
                  ),
                ),
                const Expanded(
                    child: ListenButton()
                ),
                Expanded(
                  child: MultiPurposeButton(
                    onTap: () {
                      setState(() {
                        if (readingPageIndex == readingPages.length -1) { // Zero indexing
                          // Already on last page, reset to first page
                          backToFirstPage();

                          // Open the rewards page
                          widget.openRewardPage();

                        }
                        else {
                          if (currentReadingPage is ReadingQuestion) {

                            if (currentReadingPage.correctAnswer == selectedAnswerValue) {
                              // Correct :)
                              isCorrect = true;
                              nextReadingPage(userAnswer: selectedAnswerValue);

                            }
                            else {
                              isCorrect = false;
                            }

                            // Reset
                            selectedAnswerIndex = 10;
                            selectedAnswerValue = "";

                          }
                          else if (currentReadingPage is ReadingMultipleAnswersQuestion) {
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
                    buttonType: readingPageIndex == readingPages.length -1 ? ButtonType.reward : ButtonType.next,
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
                                    child: Text(currentReadingPage.text[index], style: textStyles.mediumBodyText),   //TextBox(currentText: currentReadingPage.text[index]),
                                  );
                                },
                              )) : TextBox(currentText: "Click next"),
                              const SizedBox(
                                height: 20,
                              ),

                              // Reading Question
                              if (currentReadingPage is ReadingQuestion)
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: currentReadingPage.answerOptions.asMap().entries.map(
                                        (answer) => Container(
                                      width: double.infinity, // Makes each button take full width
                                      padding: const EdgeInsets.symmetric(vertical: 5), // Add padding if needed
                                      child: AnswerButton(
                                        color: selectedAnswerIndex == answer.key ? appColors.yellow : appColors.royalBlue,
                                        borderThickness: selectedAnswerIndex == answer.key ? 6.0 : 3.0,
                                        answerText: answer.value,
                                        onTap: () {
                                          setState(() {
                                            selectedAnswerIndex = answer.key;
                                            selectedAnswerValue = answer.value;
                                          });
                                        },
                                        // textAlign: TextAlign.center, // Centers the text within the button
                                      ),
                                    ),
                                  ).toList(),
                                ),

                              const SizedBox(
                                height: 10,
                              ),

                              if (currentReadingPage is ReadingQuestion && isCorrect == false)
                                Text(
                                  "Your answer was incorrect. ${currentReadingPage.explanation}. Try again.",
                                  textAlign: TextAlign.left,
                                  style: textStyles.customBodyText(appColors.red, 24),
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
                                    color: selectedAnswers.contains(answer.value) ?  appColors.orange : appColors.royalBlue,
                                    borderThickness: selectedAnswers.contains(answer.value) ? 6.0 : 3.0,
                                    answerText: answer.value,
                                    onTap: () {
                                      setState(() {
                                        if (selectedAnswers.contains(answer.value)) {
                                          selectedAnswers.remove(answer.value); // Deselect if already selected
                                        } else {
                                          selectedAnswers.add(answer.value); // Select if not already selected
                                        }
                                      });
                                    },
                                  ),
                                ),

                              const SizedBox(
                                height: 10,
                              ),

                              currentReadingPage.photo == "no" ? const SizedBox.shrink() : Image.asset(currentReadingPage.photo),
                              const SizedBox(
                                height: 70,
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