import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'SignUp.dart';
import 'components/quiz.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => Quiz()),
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
      appBar: AppBar(title: Text('Sign In')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(child: Column(
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
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
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
            SizedBox(height: 20),
            Text('Password', style: TextStyle(fontSize: 30)),
            SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
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
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _signIn,
              child: Text('Sign In'),
              style: ElevatedButton.styleFrom(
                  textStyle: TextStyle(
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
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => SignUpPage()),
                );
              },
              child: Text('Don\'t have an account? Sign Up'),
            ),
          ],
        ),),
      ),
    );
  }
}