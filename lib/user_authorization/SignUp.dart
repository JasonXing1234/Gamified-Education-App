import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quiz/styles/app_colors.dart';
import 'package:quiz/styles/text_styles.dart';
import 'package:quiz/user_authorization/password_field.dart';
import '../SQLITE/sqliteHelper.dart';
import '../models/UserModel.dart';
import '../home_screen.dart';
import '../models/quizModel.dart';
import '../models/quizQuestionModel.dart';
import '../models/readingModel.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final DatabaseReference databaseRef = FirebaseDatabase.instance.ref();
  User? user2 = FirebaseAuth.instance.currentUser;

  final AppTextStyles textStyles = AppTextStyles();
  final AppColors appColors = const AppColors();

  List<QuizModel> quizzes = List.generate(6, (index) {
    return QuizModel(
      quizId: 'quiz${index + 1}',
      quizScore: 0,
      questions: List.generate(3, (questionIndex) {
        return QuizQuestionModel(
          questionId: '${index + 1}_$questionIndex',
          isCorrect: false,
          beginTimeStamp: DateTime.now(),
          endTimeStamp: DateTime.now().add(Duration(minutes: 1)),
        );
      }),
    );
  });

  List<readingModel> readings = List.generate(6, (index) {
    return readingModel(
      readingID: 'reading${index + 1}',
      progress: 0,
    );
  });

  List<readingModel> initialReadings = List.generate(6, (index) => readingModel(
    readingID: 'reading_$index',
    progress: 0,
  ));

  List<QuizModel> initialQuizzes = List.generate(6, (index) => QuizModel(
    quizId: 'quiz$index',
    quizScore: 0,
    questions: List.generate(10, (questionIndex) => QuizQuestionModel(
      questionId: '$questionIndex',
      isCorrect: false,
      beginTimeStamp: DateTime.now(),
      endTimeStamp: DateTime.now().add(Duration(minutes: 1)),
    )),
  ));

  Future<void> _signUp() async {
    try {
      var result = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      UserModel user = UserModel(
        userId: result.user!.uid,
        email: _emailController.text.toLowerCase(),
        profilePic: null,
        deviceToken: await FirebaseMessaging.instance.getToken(),
        readingList: initialReadings,
        quizList: initialQuizzes,
        accessories: List<bool>.filled(20, false),
        numTickets: 0,
          ifEachModuleComplete: List<bool>.filled(6, false),
      );
      print('Failed to update field: prior');
      try{
        databaseRef.child('profile').child(user.userId!).set(user.toJson());
      } catch (e) {
        print('Error: $e');
        // Show error message
      }
      print('Failed to update field: after');
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      DatabaseHelper dbHelper = DatabaseHelper();
      await dbHelper.insertUser(user.toJson());
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const Home()),
      );
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                // Image.asset(
                //   'assets/images/img_1.png', // Path to your image
                //   width: 300, // Set the width of the image
                //   height: 300, // Set the height of the image
                //   fit: BoxFit.cover, // How the image should be inscribed into the space
                // ),
                const SizedBox(height: 30),
                // Text(
                //   "EMAIL",
                //   style: textStyles.heading1,
                // ),
                // const SizedBox(height: 10),

                const SizedBox(height: 30),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FaIcon(FontAwesomeIcons.solidUser, color: appColors.royalBlue, size: 35,),
                    const SizedBox(width: 20,),
                    SizedBox(
                      width: 280,
                      height: 75,
                      child: TextField(
                        textAlign: TextAlign.start,
                        controller: _emailController,
                        decoration: InputDecoration(
                          hintText: "Name",
                          hintStyle: TextStyle(color: appColors.grey),
                          contentPadding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 3, color: appColors.grey), // Thick border
                            borderRadius: const BorderRadius.all(Radius.circular(15.0)), // Rounded corners
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 3, color: appColors.grey), // Thick border when focused
                            borderRadius: const BorderRadius.all(Radius.circular(15.0)), // Rounded corners when focused
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FaIcon(FontAwesomeIcons.solidEnvelope, color: appColors.royalBlue, size: 35,),
                    const SizedBox(width: 20,),
                    SizedBox(
                      width: 280,
                      height: 75,
                      child: TextField(
                        textAlign: TextAlign.start,
                        controller: _emailController,
                        decoration: InputDecoration(
                          hintText: "Email",
                          hintStyle: TextStyle(color: appColors.grey),
                          contentPadding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 3, color: appColors.grey), // Thick border
                            borderRadius: const BorderRadius.all(Radius.circular(15.0)), // Rounded corners
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 3, color: appColors.grey), // Thick border when focused
                            borderRadius: const BorderRadius.all(Radius.circular(15.0)), // Rounded corners when focused
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                PasswordField(controller: _passwordController),

                const SizedBox(height: 30),

                const SizedBox(height: 50),
                ElevatedButton(
                  onPressed: _signUp,
                  style: ElevatedButton.styleFrom(
                      textStyle: const TextStyle(
                        fontSize: 20, // Set the font size
                        color: Colors.white, // Set the text color
                      ),
                    minimumSize: const Size(350, 60), // Width: 150, Height: 50
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15), // Set the border radius
                    ),
                    backgroundColor: appColors.royalBlue,
                  ),
                  child: Text(
                    "Sign Up",
                    style: textStyles.mediumBodyTextWhite,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Already have an account? Sign In'),
                ),
              ],
        ),
        ),
      ),
      ));
  }
}