import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quiz/components/quiz_results_screen.dart';
import 'package:quiz/components/lesson/lesson.dart';
import 'package:quiz/components/lesson/all_lessons.dart';
import 'package:quiz/components/reading/readings_screen.dart';
import 'package:quiz/components/reading_results_screen.dart';
import 'package:quiz/components/rewards/all_characters.dart';
import 'package:quiz/styles/app_colors.dart';
import 'package:quiz/styles/text_styles.dart';

import '../../accessory.dart';
import '../practice/practice_screen.dart';
import '../practice_results_screen.dart';
import '../rewards/character.dart';

class LessonScreen extends StatefulWidget {
  const LessonScreen({
    super.key,
    required this.lessonNumber,
  });

  final int lessonNumber;

  // Unlocked features
  @override
  State<LessonScreen> createState() { return _LessonScreenState(); }
}

class _LessonScreenState extends State<LessonScreen> {

  final AppTextStyles textStyles = AppTextStyles();
  final AppColors appColors = const AppColors();
  final DatabaseReference _database = FirebaseDatabase.instance.ref();
  User? user2;
  List<dynamic> readings = [];
  int startingPageIndex = 0;
  Future<int?>? numTickets;
  int? tempNumTickets;

  @override
  void initState() {
    super.initState();
    user2 = FirebaseAuth.instance.currentUser;

    _fetchReadingList();
    // Fetch readings once the widget is initialized
    numTickets = _fetchTickets();
  }

  void popScopeFuntion() {numTickets = _fetchTickets();}

  List purchased = List<dynamic>.filled(20, false);

  // The index of the selected image, or null if no image is selected
  int? selectedImageIndex;

  // Function to handle when "Yes" is pressed
  Future<void> handleYes() async {
    tempNumTickets = await _fetchTickets();
    setState(() {
      if (selectedImageIndex != null) {
        purchased[selectedImageIndex!] = true;
        selectedImageIndex = null; // Close the popup
      }
      tempNumTickets = tempNumTickets! - 1;
    });
    try {
      await _database.child('profile/${user2?.uid}').update({
        'accessories': purchased,
        'numTickets': tempNumTickets!
      });

    } catch (e) {
      // Handle potential errors, like network issues
      print('Error fetching reading list: $e');
    }
  }

  // Function to handle when "No" is pressed
  void handleNo() {
    setState(() {
      selectedImageIndex = null; // Close the popup without purchasing
    });
  }

  Future<int?> _fetchTickets() async {
    if (user2 != null) {
      try {
        DataSnapshot snapshot2 = await _database
            .child('profile')
            .child(user2!.uid)
            .child('numTickets')
            .get();

        if (snapshot2.value != null) {
          return snapshot2.value as int;
        }
      }
      catch (e) {
        // Handle potential errors, like network issues
        print('Error fetching reading list: $e');
      }
    }
  }

  Future<List<dynamic>?> _fetchAccessories() async {
    if (user2 != null) {
      try {
        DataSnapshot snapshot2 = await _database
            .child('profile')
            .child(user2!.uid)
            .child('accessories')
            .get();

        if (snapshot2.value != null) {
          return snapshot2.value as List<bool>;
        }
      }
      catch (e) {
        // Handle potential errors, like network issues
        print('Error fetching reading list: $e');
      }
    }
  }
  // Asynchronous function to fetch reading list data
  Future<void> _fetchReadingList() async {
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
          });
        }

        DataSnapshot snapshot2 = await _database
            .child('profile')
            .child(user2!.uid)
            .child('accessories')
            .get();

        if (snapshot2.value != null) {
          setState(() {
            purchased = snapshot2.value as List<dynamic>;
          });
        }

      } catch (e) {
        // Handle potential errors, like network issues
        print('Error fetching reading list: $e');
      }
    }
  }


  String getPhase(Lesson lesson, Phase phase) {

    return lesson.character.photos[phase] ?? "assets/images/lock.png";
  }

  @override
  Widget build(BuildContext context) {

    Lesson lesson;
    if (widget.lessonNumber == socialMediaNorms.lessonNumber) {
      lesson = socialMediaNorms;
    }
    else if (widget.lessonNumber == settings.lessonNumber) {
      lesson = settings;
    }
    else if (widget.lessonNumber == fakeProfiles.lessonNumber) {
      lesson = fakeProfiles;
    }
    else if (widget.lessonNumber == socialTags.lessonNumber) {
      lesson = socialTags;
    }
    else if (widget.lessonNumber == appropriateInteractions.lessonNumber) {
      lesson = appropriateInteractions;
    }
    else if (widget.lessonNumber == socialMediaVSReality.lessonNumber) {
      lesson = socialMediaVSReality;
    }
    else {
      lesson = Lesson("LESSON", lockedCharacter, 0);
    }


    return PopScope(
      //TODO: Make this work
        onPopInvoked: (popDisposition) async {
      // Perform the refresh logic
      setState(() {
        popScopeFuntion();
      }); // Allow the pop action
    },
    child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          toolbarHeight: 70,
          title: Padding(
            padding: const EdgeInsets.only(top: 20.0), // Adjust the top padding of title
            child: Text(
              lesson.title,
              style: textStyles.heading1,
            ),
          ),

          // Return Home Button
          leadingWidth: 60, // Gives space for the back button
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
                ],
              ),
            ),

          ),


        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
          child: Stack(
            children: [ Column(
            children: [
              const SizedBox(
                height: 15,
              ),

              // Row of image and stats
              StatsNotebook(lesson: lesson, textStyles: textStyles),

              const SizedBox(height: 5,),

              // row of buttons for Pre-quiz, readings, post-quiz
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [

                  ActivityButton(
                    text: "PRE-QUIZ",
                    onTap:
                        (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ReadingResultScreen(lessonNumber: widget.lessonNumber, activeScreen: "reading-screen",)),
                      );
                    },
                  ),

                  ActivityButton(
                    text: "READING",
                    onTap:
                        (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ReadingResultScreen(lessonNumber: widget.lessonNumber, activeScreen: "reading-screen",)),
                      );
                    },
                  ),

                  ActivityButton(
                    text: "POST-QUIZ",
                    onTap:
                        (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => QuizResultScreen(lessonNumber: widget.lessonNumber, activeScreen: "quiz-screen",))
                      );
                    },
                  ),
                ],
              ),

              const SizedBox(height: 15,),

              ActivityButton(
                text: "PRACTICE & EARN TICKETS", // Drill is practice
                onTap:
                    (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PracticeResultScreen(lessonNumber: widget.lessonNumber, activeScreen: "practice-screen",))

                    //MaterialPageRoute(builder: (context) => PracticeScreen(quizNumber: widget.lessonNumber, onSelectAnswer: (String answer) {  },))
                  );
                },
              ),

              const SizedBox(height: 5,),

              // Number of Tickets
              FutureBuilder<int?>(
                future: _fetchTickets(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    return
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          FaIcon(FontAwesomeIcons.ticket, color: appColors.yellow, size: textStyles.mediumBodyText.fontSize,),

                          // Icon( Icons.Tickets, color: appColors.yellow, size: textStyles.mediumBodyText.fontSize,),
                          Text("Tickets: ${snapshot.data}", style: textStyles.mediumBodyText,),
                          Text(snapshot.data.toString(), style: textStyles.mediumBodyText,),
                        ],
                      );
                  } else {
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        FaIcon(FontAwesomeIcons.ticket, color: appColors.yellow, size: textStyles.heading1.fontSize,),
                        // Icon( Icons.Tickets, color: appColors.yellow, size: textStyles.heading1.fontSize,),
                        Text(" Tickets 0", style: textStyles.bodyText,),
                      ],
                    );


                    //Text('No data available');
                  }
                },
              ),

              const SizedBox(
                height: 20,
              ),

              // Scrollable Accessory List
              SizedBox(
                height: 350, // Set a fixed height for the GridView
                width: 350,
                child: GridView.extent(
                  maxCrossAxisExtent: 100, // Max width of each tile
                  mainAxisSpacing: 20, // Space between rows
                  crossAxisSpacing: 20, // Space between columns
                  children: List.generate(20, (index) {
                    return buildGridItem(index);
                  }),
                ),
              ),
            ],
          ),
              if (selectedImageIndex != null)
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          "Do you want to buy this item?",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                              onPressed: () async {
                                int? tempInt = await _fetchTickets();
                                if (tempInt! > 0) {
                                  handleYes();
                                }
                                else{
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: const Text("You need 1 ticket to buy this item"),
                                      action: SnackBarAction(
                                        label: "UNDO",
                                        onPressed: () {
                                          // Do something to undo the change.
                                        },
                                      ),
                                    ),
                                  );
                                }
                                },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                padding: const EdgeInsets.symmetric(horizontal: 40),
                              ),
                              child: const Text("Yes"),
                            ),
                            ElevatedButton(
                              onPressed: handleNo,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                padding: const EdgeInsets.symmetric(horizontal: 40),
                              ),
                              child: const Text("No"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
    ));
  }

  Widget buildGridItem(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedImageIndex = index;
        });
      },
      child: Stack(
        children: [
          ImageBox(imageName: "assets/character_images/sunglasses.png", isLocked: !purchased[index], isSelected: false,),
          // if (purchased[index])
          //   Positioned.fill(
          //     child: Container(
          //       color: Colors.black.withOpacity(0.5),
          //       child: const Center(
          //         child: Icon(
          //           Icons.check_circle,
          //           color: Colors.green,
          //           size: 50,
          //         ),
          //       ),
          //     ),
          //   ),
        ],
      ),
    );
  }
}

class StatsNotebook extends StatelessWidget {
  const StatsNotebook({
    super.key,
    required this.lesson,
    required this.textStyles,
  });

  final Lesson lesson;
  final AppTextStyles textStyles;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 375,
      height: 200,
      child: GridView.extent(
        maxCrossAxisExtent: 300, // Max width of character and notebook
        mainAxisSpacing: 1, // Space between rows
        crossAxisSpacing: 1, // Space between columns
        children: [
          lesson.getCurrentPhoto() == "no" ? const SizedBox.shrink() : Image.asset(lesson.getCurrentPhoto()),
          Stack(
              children: [
                Image.asset("assets/images/notebook_v2.png"),
                Center(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 2),
                        child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10,),
                          Text(lesson.character.name, style: textStyles.caption,),
                          const SizedBox(height: 5,),
                          Text("Phase: ${lesson.character.currentPhase.name}", style: textStyles.caption,),
                          const SizedBox(height: 5,),
                          Text("Weight: ${lesson.character.stats[lesson.character.currentPhase]?["weight"]}", style: textStyles.caption,),
                          const SizedBox(height: 5,),
                          Text("Height: ${lesson.character.stats[lesson.character.currentPhase]?["height"]}", style: textStyles.caption,),
                        ],
                      ),
                    ),
                ),
              ]
          ),
        ],
      ),
    );
  }
}

class ImageBox extends StatelessWidget {
  ImageBox({
    super.key,
    required this.imageName,
    required this.isLocked,
    required this.isSelected,
  });

  final String imageName;
  bool isLocked;
  bool isSelected;

  final AppColors appColors = const AppColors();
  final AppTextStyles textStyles = AppTextStyles();

  @override
  Widget build(BuildContext context) {

    var locked = Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        border: Border.all(color: Colors.black, width: 3.0),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Center(
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  appColors.grey,
                  BlendMode.saturation,
                ),
                child: Image.asset(imageName, scale: 2,),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: FaIcon(FontAwesomeIcons.ticket, color: appColors.yellow, size: textStyles.mediumBodyText.fontSize,),

              //Icon( Icons.Tickets, color: appColors.yellow, size: textStyles.mediumBodyText.fontSize,),

            ),

          ],
        ),



      )
    );

    // Default: Owned by user but not being used
    var purchased = Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        border: Border.all(color: Colors.black, width: 3.0),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Center(
        child: Image.asset(
          imageName,
          scale: 2,
        ),
      ),
    );


    // If accessory is selected
    var selected = Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        border: Border.all(color: appColors.green, width: 8.0),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Center(
        child: Image.asset(
          imageName,
          scale: 2,
        ),
      ),
    );


    // if locked -> locked version
    // if purchased -> check if selected
    return isLocked ? locked : isSelected ? selected : purchased;
  }
}

class ActivityButton extends StatelessWidget {
  ActivityButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  final AppColors appColors = const AppColors();
  final AppTextStyles textStyles = AppTextStyles();

  final String text;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Padding for text and border
        //fixedSize: const Size(150, 50),
        backgroundColor: appColors.royalBlue,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text(
        text,
        style: textStyles.smallBodyTextWhite,
        textAlign: TextAlign.center,
      ),
    );
  }
}