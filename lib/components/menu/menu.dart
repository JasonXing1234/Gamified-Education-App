import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../user_authorization/SignIn.dart';
import '../../styles/app_colors.dart';
import '../../styles/text_styles.dart';

class MenuDrawer extends StatelessWidget {
  MenuDrawer({
    super.key,
  });

  final AppTextStyles textStyles = AppTextStyles();
  final AppColors appColors = const AppColors();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 40),

            // User Email
            Text(
              "${FirebaseAuth.instance.currentUser?.email}",
              style: textStyles.bodyText,
            ),
            const SizedBox(height: 40),


            // Customization features
            // TODO: Add customization features
            // Change font

            // Change color theme and dark mode

            // Change reading speed


            OutlinedButton.icon(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                // Navigate back to the Sign-In page after signing out
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => SignInPage()),
                );
              },
              style: OutlinedButton.styleFrom(
                backgroundColor: appColors.royalBlue,
                foregroundColor: Colors.white,
              ),
              icon: const Icon(Icons.logout),
              label: const Text("Logout"),
            ),

            const SizedBox(height: 40),

          ],
        ),
      ),
    );
  }
}