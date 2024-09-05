import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:quiz/components/reading/reading_page.dart';
import 'package:quiz/components/reading/readings/reading1.dart';
import 'package:quiz/components/progress_bar/progress_bar.dart';

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
    required this.readingNumber
  });

  final int readingNumber;

  @override
  State<ReadingsScreen> createState() => _ReadingsScreenState();
}


class _ReadingsScreenState extends State<ReadingsScreen> {
  TextEditingController _controller = TextEditingController();
  int readingPageIndex = 0;
  final AppTextStyles textStyles = AppTextStyles();
  final AppColors appColors = const AppColors();

  final DatabaseReference _database = FirebaseDatabase.instance.ref();
  User? user2;
  List<dynamic> readings = [1,1,1,1,1,1];
  Future<int?>? _readingListFuture;

  @override
  void initState() {
    super.initState();
    user2 = FirebaseAuth.instance.currentUser;
    // Fetch readings once the widget is initialized
    _readingListFuture = _fetchReadingList();
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

  Future<void> nextReadingPage() async {
    readingPageIndex++;
    DataSnapshot snapshot = await _database.child('profile').child(user2!.uid).child('readingList').get();
    List<dynamic> readings = snapshot.value as List<dynamic>;
    readings[widget.readingNumber - 1] = readingPageIndex;
    await _database.child('profile/${user2?.uid}').update({
      'readingList': readings,
    });
    await Future.delayed(const Duration(seconds: 2));
      //_controller.dispose();
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
      readingPages = reading1;
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
                  onTap: () {
                    setState(() {
                      if (readingPageIndex == readingPages.length -1) { // Zero indexing
                        // Already on last page
                        // TODO: Return home?
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => LessonScreen(lessonNumber: widget.readingNumber)),
                              (route) => false, // This removes all previous routes
                        );
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

      body: FutureBuilder<int?>(
        future: _readingListFuture,
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError) {
    return Center(child: Text('Error: ${snapshot.error}'));
    } else { return Stack(
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
                      height: 20,
                    ),
                    TextBox(
                      currentText: currentReadingPage.text[0], // TODO: Show each text box for lesson
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    // const SizedBox(
                    //   height: 60,
                    // ),
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



