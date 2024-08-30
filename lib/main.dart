import 'package:flutter/material.dart';
import 'package:quiz/home_screen.dart';
import 'package:quiz/SignIn.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MaterialApp(
    home: Home(),
  ));

  // TODO: Switch back to this later, setting home has screen to run for faster UI building
  // runApp(MaterialApp(
  //   home: SignInPage(),
  // ));
}
