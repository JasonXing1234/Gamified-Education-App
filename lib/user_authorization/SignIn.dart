import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quiz/user_authorization/password_field.dart';

import 'SignUp.dart';
import '../home_screen.dart';

import '../../styles/app_colors.dart';
import '../../styles/text_styles.dart';

class SignInPage extends StatefulWidget {

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final AppTextStyles textStyles = AppTextStyles();
  final AppColors appColors = const AppColors();

  bool isTextObscured = true; // Initially hide password

  Future<void> _signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => Home()),
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
      appBar: AppBar(
          centerTitle: true,
          toolbarHeight: 70, // Increases the height of the AppBar
          title: const Text("Learn Social Media Skills")
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(child:  Center(child: Column(
          children: [

            const SizedBox(height: 15),

            Image.asset(
              'assets/images/apple.png', // Path to your image
              width: 200, // Set the width of the image
              height: 200, // Set the height of the image
              fit: BoxFit.cover, // How the image should be inscribed into the space
            ),

            const SizedBox(height: 75),

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
            // Text(
            //   "PASSWORD",
            //   style: textStyles.heading1,
            // ),
            // const SizedBox(height: 10),

            PasswordField(controller: _passwordController),

            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: _signIn,
              style: ElevatedButton.styleFrom(
                  textStyle: textStyles.mediumBodyTextWhite,
                  minimumSize: const Size(350, 60), // Width: 150, Height: 50
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15), // Set the border radius
                  ),
                  backgroundColor: appColors.royalBlue,
              ),
              child: Text(
                "SIGN IN",
                style: textStyles.mediumBodyTextWhite,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => SignUpPage()),
                );
              },
              child: const Text("Don't have an account? Sign Up"),
            ),
          ],
        ),),
      ),)
    );
  }
}