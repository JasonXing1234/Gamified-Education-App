import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'SignUp.dart';
import 'home_screen.dart';
import '../SQLITE/sqliteHelper.dart';
import '../models/UserModel.dart';
import '../styles/app_colors.dart';
import '../styles/text_styles.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final DatabaseHelper _dbHelper = DatabaseHelper();

  final AppTextStyles textStyles = AppTextStyles();
  final AppColors appColors = const AppColors();

  Future<void> _signIn() async {
    bool isOnline = await _checkInternetConnection();

    if (isOnline) {
      await _signInWithFirebase();
    } else {
      await _signInWithSQLite();
    }
  }

  /// Check Internet Connection
  Future<bool> _checkInternetConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();

    // If there's no connection type detected, return false immediately
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    }

    // Try making a real internet request
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result.first.rawAddress.isNotEmpty;
    } catch (e) {
      return false; // No actual internet access
    }
  }

  /// Firebase Sign-In (When Online)
  Future<void> _signInWithFirebase() async {
    try {
      UserCredential result = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      String userId = result.user!.uid;

      var userSnapshot = await _dbHelper.fetchUserFromFirebase(userId);
      if (userSnapshot != null) {
        // Store/update user data in SQLite
        await _dbHelper.insertUser(userSnapshot, _passwordController.text);
        print("SQLite updated with Firebase data.");
      }

      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => Home()),
      );
    } catch (e) {
      print('Firebase Sign-In Error: $e');
      _showErrorDialog("Invalid email or password.");
    }
  }

  /// SQLite Sign-In (When Offline)
  Future<void> _signInWithSQLite() async {
    try {
      Map<String, dynamic>? userData = await _dbHelper.getUserByEmailAndPassword(
        _emailController.text,
        _passwordController.text,
      );

      if (userData != null) {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => Home()),
        );
      } else {
        _showErrorDialog("Invalid email or password.");
      }
    } catch (e) {
      print('SQLite Sign-In Error: $e');
      _showErrorDialog("An error occurred while signing in.");
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Sign-In Failed"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Learn Social Media Skills"), centerTitle: true, toolbarHeight: 70),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 15),
                Image.asset('assets/images/apple.png', width: 200, height: 200, fit: BoxFit.cover),
                const SizedBox(height: 75),

                _buildTextField(Icons.email, "Email", _emailController),
                const SizedBox(height: 30),
                _buildTextField(Icons.lock, "Password", _passwordController, obscureText: true),

                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: _signIn,
                  style: ElevatedButton.styleFrom(
                    textStyle: textStyles.mediumBodyTextWhite,
                    minimumSize: const Size(350, 60),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    backgroundColor: appColors.royalBlue,
                  ),
                  child: Text("SIGN IN", style: textStyles.mediumBodyTextWhite),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignUpPage()));
                  },
                  child: const Text("Don't have an account? Sign Up"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(IconData icon, String hintText, TextEditingController controller, {bool obscureText = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: appColors.royalBlue, size: 40),
        const SizedBox(width: 20),
        SizedBox(
          width: 280,
          height: 75,
          child: TextField(
            textAlign: TextAlign.center,
            controller: controller,
            obscureText: obscureText,
            decoration: InputDecoration(
              hintText: hintText,
              contentPadding: const EdgeInsets.symmetric(vertical: 20.0),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 3, color: appColors.grey),
                borderRadius: const BorderRadius.all(Radius.circular(15.0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 3, color: appColors.grey),
                borderRadius: const BorderRadius.all(Radius.circular(15.0)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}