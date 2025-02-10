import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:quiz/styles/app_colors.dart';
import 'package:quiz/styles/text_styles.dart';
import 'SQLITE/sqliteHelper.dart';
import 'models/UserModel.dart';
import 'home_screen.dart';
import 'models/quizModel.dart';
import 'models/quizQuestionModel.dart';
import 'models/readingModel.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();

  final DatabaseReference databaseRef = FirebaseDatabase.instance.ref();
  User? user2 = FirebaseAuth.instance.currentUser;

  final AppTextStyles textStyles = AppTextStyles();
  final AppColors appColors = const AppColors();

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

  List<readingModel> initialReadings = List.generate(6, (index) => readingModel(
    readingID: 'reading_$index',
    progress: 0,
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
        userName: _userNameController.text.trim(), // Store display name
        deviceToken: await FirebaseMessaging.instance.getToken(),
        readingList: initialReadings,
        quizList: initialQuizzes,
        accessories: List<bool>.filled(20, false),
        numTickets: 0,
        ifEachModuleComplete: List<bool>.filled(6, false),
      );

      // Save user details to Firebase Realtime Database
      try {
        databaseRef.child('profile').child(user.userId!).set(user.toJson());
      } catch (e) {
        print('Error saving user to Firebase: $e');
      }

      // Save user details to SQLite including password
      DatabaseHelper dbHelper = DatabaseHelper();
      await dbHelper.insertUser(user.toJson(), _passwordController.text);

      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const Home()),
      );
    } catch (e) {
      print('Error signing up: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),

              // User Name Input
              Row(
                children: [
                  Icon(Icons.person, color: appColors.royalBlue, size: 40),
                  const SizedBox(width: 20),
                  Expanded(
                    child: TextField(
                      controller: _userNameController,
                      decoration: InputDecoration(
                        hintText: "DisplayName",
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Email Input
              Row(
                children: [
                  Icon(Icons.email, color: appColors.royalBlue, size: 40),
                  const SizedBox(width: 20),
                  Expanded(
                    child: TextField(
                      controller: _emailController,
                      decoration: InputDecoration(hintText: "Email"),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Password Input
              Row(
                children: [
                  Icon(Icons.lock, color: appColors.royalBlue, size: 40),
                  const SizedBox(width: 20),
                  Expanded(
                    child: TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(hintText: "Password"),
                      obscureText: true,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Confirm Password Input
              Row(
                children: [
                  Icon(Icons.lock, color: appColors.royalBlue, size: 40),
                  const SizedBox(width: 20),
                  Expanded(
                    child: TextField(
                      controller: _confirmPasswordController,
                      decoration: InputDecoration(hintText: "Confirm Password"),
                      obscureText: true,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 40),

              ElevatedButton(
                onPressed: _signUp,
                child: Text("Sign Up"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}