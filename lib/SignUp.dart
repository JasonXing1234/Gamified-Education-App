import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'UserModel.dart';
import 'home_screen.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final DatabaseReference databaseRef = FirebaseDatabase.instance.ref();
  User? user2 = FirebaseAuth.instance.currentUser;

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
      appBar: AppBar(title: Text('Sign Up')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(child:Column(
          children: [
            Image.asset(
              'assets/images/img_1.png', // Path to your image
              width: 300, // Set the width of the image
              height: 300, // Set the height of the image
              fit: BoxFit.cover, // How the image should be inscribed into the space
            ),
            SizedBox(height: 20),
            Text('Email', style: TextStyle(fontSize: 30),),
            SizedBox(height: 20),
            SizedBox(
              width: 380,
              height: 100,
              child: TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  hintText: 'Enter Email here',
                  contentPadding: EdgeInsets.symmetric(vertical: 30.0, horizontal:110),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 3, color: Color(0xFF646161)), // Thick border
                    borderRadius: BorderRadius.all(Radius.circular(15.0)), // Rounded corners
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 3, color: Color(0xFF646161)), // Thick border when focused
                    borderRadius: BorderRadius.all(Radius.circular(15.0)), // Rounded corners when focused
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            const Text('Password', style: TextStyle(fontSize: 30)),
            SizedBox(height: 20),
            SizedBox(
              width: 380,
              height: 100,
              child: TextField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      hintText: 'Enter Password here',
                      contentPadding: EdgeInsets.symmetric(vertical: 30.0, horizontal:110),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 3, color: Color(0xFF646161)), // Thick border
                        borderRadius: BorderRadius.all(Radius.circular(15.0)), // Rounded corners
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 3, color: Color(0xFF646161)), // Thick border when focused
                        borderRadius: BorderRadius.all(Radius.circular(15.0)), // Rounded corners when focused
                      ),
                    ),
                    obscureText: true,
                  ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _signUp,
              child: Text('Sign Up', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                  textStyle: const TextStyle(
                    fontSize: 20, // Set the font size
                    color: Colors.white, // Set the text color
                  ),
                minimumSize: Size(380, 80), // Width: 150, Height: 50
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15), // Set the border radius
                ),
                backgroundColor: Color(0xFFA15981)
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Already have an account? Sign In'),
            ),
          ],
        ),
        ),
      ),
    );
  }
}