import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:quiz/styles/app_colors.dart';
import 'package:quiz/styles/text_styles.dart';
import 'UserModel.dart';
import 'home_screen.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  final DatabaseReference databaseRef = FirebaseDatabase.instance.ref();
  User? user2 = FirebaseAuth.instance.currentUser;

  final AppTextStyles textStyles = AppTextStyles();
  final AppColors appColors = const AppColors();

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
        readingList: [0, 0, 0, 0, 0, 0],
        quizScoreList:  [0, 0, 0, 0, 0, 0],
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
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const Home()),
      );
      // Navigate to home screen or other page
    } catch (e) {
      print('Error: $e');
      // Show error message
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

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.email,
                      color: appColors.royalBlue,
                      size: 40,
                    ),
                    const SizedBox(width: 20,),
                    SizedBox(
                      width: 280,
                      height: 75,
                      child: TextField(
                        textAlign: TextAlign.center,
                        controller: _emailController,
                        decoration: InputDecoration(
                          hintText: "Email",
                          contentPadding: const EdgeInsets.symmetric(vertical: 20.0),
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
                    Icon(
                      Icons.lock,
                      color: appColors.royalBlue,
                      size: 40,
                    ),
                    const SizedBox(width: 20,),
                    SizedBox(
                      width: 280,
                      height: 75,
                      child: TextField(
                        textAlign: TextAlign.center,
                        controller: _passwordController,
                        decoration: InputDecoration(
                          hintText: "Password",
                          contentPadding: const EdgeInsets.symmetric(vertical: 20.0),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 3, color: appColors.grey), // Thick border
                            borderRadius: const BorderRadius.all(Radius.circular(15.0)), // Rounded corners
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 3, color: appColors.grey), // Thick border when focused
                            borderRadius: const BorderRadius.all(Radius.circular(15.0)), // Rounded corners when focused
                          ),
                        ),
                        obscureText: true,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.lock,
                      color: appColors.royalBlue,
                      size: 40,
                    ),
                    const SizedBox(width: 20,),

                    // TODO: Set up logic for confirm password for signing up
                    SizedBox(
                      width: 280,
                      height: 75,
                      child: TextField(
                        textAlign: TextAlign.center,
                        controller: _confirmPasswordController,
                        decoration: InputDecoration(
                          hintText: "Confirm Password here",
                          contentPadding: const EdgeInsets.symmetric(vertical: 20.0),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 3, color: appColors.grey), // Thick border
                            borderRadius: const BorderRadius.all(Radius.circular(15.0)), // Rounded corners
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 3, color: appColors.grey), // Thick border when focused
                            borderRadius: const BorderRadius.all(Radius.circular(15.0)), // Rounded corners when focused
                          ),
                        ),
                        obscureText: true,
                      ),
                    ),
                  ],
                ),

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