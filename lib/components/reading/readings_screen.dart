import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:quiz/components/buttons/listen_button.dart';
import 'package:quiz/components/buttons/answer_button.dart';
import 'package:quiz/components/reading/reading_page.dart';
import 'package:quiz/components/progress_bar/progress_bar.dart';


import '../../SQLITE/sqliteHelper.dart';
import '../../models/UserModel.dart';
import '../../models/readingModel.dart';
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
  UserModel? user;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScrollEnd);
    _initializeUserAndFetchReadings();
  }

  void _onScrollEnd() {
    if (!_scrollController.position.isScrollingNotifier.value) {
      double offset = _scrollController.offset;
      double screenHeight = MediaQuery.of(context).size.height;
      double totalHeight = offset + screenHeight - 40;
      int targetPage = (totalHeight / screenHeight).round();
      double targetOffset = targetPage * screenHeight;
      _scrollController.jumpTo(targetOffset);
    }
  }

  Future<void> _initializeUserAndFetchReadings() async {
    user = await _dbHelper.getLoggedInUser();
    if (user != null) {
      _readingListFuture = _fetchReadingList();
      setState(() {});
    }
  }

  Future<int?> _fetchReadingList() async {
    if (user != null) {
      try {
        List<readingModel> readingListData = await _dbHelper.getReadingList(user!.userId!);

        print("Fetched reading list: $readingListData"); // Debug print

        if (readingListData.isNotEmpty) {
          setState(() {
            if (widget.lesson.lessonNumber - 1 < readingListData.length) {
              readingPageIndex = readingListData[widget.lesson.lessonNumber].progress;
            } else {
              readingPageIndex = 0;
            }
          });
        }

        print("ReadingPageIndex set to: $readingPageIndex"); // Debug print

        return readingPageIndex;
      } catch (e) {
        print('Error fetching reading list from SQLite: $e');
      }
    }
    return null;
  }

  Future<void> updateCurrentTask() async {
    if (user == null) return;
    String newTask = "reading${widget.lesson.lessonNumber}";

    try {
      await _database.child('profile').child(user!.userId!).update({
        'currentTask': newTask,
      });
      await _dbHelper.updateCurrentTask(user!.userId!, newTask);
      print('Current task updated to: $newTask');
    } catch (e) {
      print('Error updating current task: $e');
    }
  }

  Future<void> updateReadingProgress(int lessonNumber, int progress) async {
    if (user == null) return;
    await _dbHelper.updateReadingProgress(user!.userId!, lessonNumber, progress);
  }

  Future<void> updateIfEachModuleComplete() async {
    if (user == null) return;
    String userId = user!.userId!;
    int moduleIndex = widget.lesson.lessonNumber;

    try {
      DataSnapshot snapshot = await _database
          .child('profile')
          .child(userId)
          .child('ifEachModuleComplete')
          .get();

      if (snapshot.value != null) {
        List<dynamic> moduleCompletion = snapshot.value as List<dynamic>;
        if (moduleIndex >= 0 && moduleIndex < moduleCompletion.length) {
          moduleCompletion[moduleIndex][0] = true;
          await _database.child('profile').child(userId).update({
            'ifEachModuleComplete': moduleCompletion,
          });
          print('Firebase: ifEachModuleComplete updated.');
        } else {
          print('Firebase: Invalid module index.');
        }
      }
      await _dbHelper.updateIfEachModuleComplete(userId, widget.lesson.lessonNumber);
      print('SQLite: ifEachModuleComplete updated.');
    } catch (e) {
      print('Error updating ifEachModuleComplete: $e');
    }
  }

  Future<void> nextReadingPage({String userAnswer = ""}) async {
    if (user == null) return;

    int newReadingPageIndex = readingPageIndex + 1;

    try {
      List<readingModel> readings = await _dbHelper.getReadingList(user!.userId!);

      if (readings.isNotEmpty) {
        for (int i = 0; i < readings.length; i++) {
          if (readings[i].readingID == 'reading_${widget.lesson.lessonNumber}') {
            readings[i].progress = newReadingPageIndex;
            break;
          }
        }

        await _dbHelper.updateReadingProgress(
          user!.userId!,
          widget.lesson.lessonNumber,
          newReadingPageIndex,
        );

        print('Reading progress updated successfully in SQLite.');
      } else {
        print('Error: Reading list is empty.');
        return;
      }

      final DatabaseReference readingListRef = _database
          .child('profile')
          .child(user!.userId!)
          .child('readingList');

      DataSnapshot snapshot = await readingListRef.get();

      if (snapshot.value != null) {
        List<Map<String, dynamic>> firebaseReadings = (snapshot.value as List<dynamic>)
            .map((e) => Map<String, dynamic>.from(e))
            .toList();

        for (int i = 0; i < firebaseReadings.length; i++) {
          if (firebaseReadings[i]['bookId'] == 'reading_${widget.lesson.lessonNumber}') {
            firebaseReadings[i]['progress'] = newReadingPageIndex;
            break;
          }
        }

        await readingListRef.set(firebaseReadings);
        print('Reading progress updated successfully in Firebase.');
      } else {
        print('Error: Reading list not found in Firebase.');
      }

      setState(() {
        readingPageIndex = newReadingPageIndex;
        _readingListFuture = _fetchReadingList(); // Fetch updated list
      });

    } catch (e) {
      print('Error updating reading progress: $e');
    }
  }


  Future<void> completeLesson() async {
    await updateCurrentTask();
    await updateIfEachModuleComplete();
    widget.openRewardPage();
  }

  Future<void> prevReadingPage({String userAnswer = ""}) async {
    if (readingPageIndex > 0 && user != null) {
      int newReadingPageIndex = readingPageIndex - 1;

      try {
        List<readingModel> readingListData =
        await _dbHelper.getReadingList(user!.userId!);

        if (readingListData.isNotEmpty) {
          List<readingModel> readings = readingListData
              .map((e) => readingModel.fromJson(e as Map<String, dynamic>))
              .toList();

          readings[widget.lesson.lessonNumber - 1].progress = newReadingPageIndex;

          await _database
              .child('profile')
              .child(user!.userId!)
              .child('readingList')
              .set(readings.map((r) => r.toJson()).toList());

          await _dbHelper.updateReadingProgress(
            user!.userId!,
            widget.lesson.lessonNumber,
            newReadingPageIndex,
          );

          setState(() {
            readingPageIndex = newReadingPageIndex;
            _readingListFuture = _fetchReadingList();
          });
        }
      } catch (e) {
        print("Error updating reading progress: $e");
      }
    } else {
      print("Already at the first page. Can't go back further.");
    }
  }

  Future<void> backToFirstPage() async {
    DataSnapshot snapshot = await _database.child('profile').child(user!.userId!).child('readingList').get();
    List<dynamic> readings = snapshot.value as List<dynamic>;
    readings[widget.lesson.lessonNumber]['progress'] = 0;
    await _database.child('profile/${user!.userId}').update({
      'readingList': readings,
    });
    await _dbHelper.updateReadingProgress(
      user!.userId!,
      widget.lesson.lessonNumber,
      0,
    );

    // Update UI state
    setState(() {
      readingPageIndex = 0;
      _readingListFuture = _fetchReadingList();
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
                    onTap: () async {
                      if (readingPageIndex == readingPages.length - 1) { // Zero indexing
                        // Already on last page, reset to first page
                        await backToFirstPage();
                        await updateCurrentTask();
                        await updateIfEachModuleComplete();
                        widget.openRewardPage();
                      } else {
                        if (currentReadingPage is ReadingQuestion) {
                          if (currentReadingPage.correctAnswer == selectedAnswerValue) {
                            // Correct answer
                            isCorrect = true;
                            await nextReadingPage(userAnswer: selectedAnswerValue);
                          } else {
                            isCorrect = false;
                          }
                          selectedAnswerIndex = 10;
                          selectedAnswerValue = "";
                        } else if (currentReadingPage is ReadingMultipleAnswersQuestion) {
                          if (currentReadingPage.answerOptions[0] == "textField") {
                            await nextReadingPage(userAnswer: _controller.text);
                          }
                        } else {
                          await nextReadingPage();
                        }
                      }
                      setState(() {
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
                int pageIndex = snapshot.data ?? 0;
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
                      child: ProgressBar(pageIndex: pageIndex, pageList: readingPages),
                    )
                  ],
                );}})

    );
  }
}