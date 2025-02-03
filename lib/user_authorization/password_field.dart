import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quiz/styles/app_colors.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({
    required this.controller
  });

  final TextEditingController controller;

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool isTextObscured = true; // Track password visibility

  AppColors appColors = const AppColors();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Key Icon
        SizedBox(
          height: 75,
          child: Center(
            child: FaIcon(
              FontAwesomeIcons.key,
              color: appColors.royalBlue,
              size: 35,
            ),
          ),
        ),
        const SizedBox(width: 20),

        // Password TextField
        SizedBox(
          width: 280,
          height: 75,
          child: TextField(
            controller: widget.controller,
            textAlign: TextAlign.start, // Left-align text
            obscureText: isTextObscured, // Toggle visibility
            decoration: InputDecoration(
              hintText: "Password",
              hintStyle: TextStyle(color: appColors.grey),
              contentPadding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0), // Left padding
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 3, color: appColors.grey),
                borderRadius: const BorderRadius.all(Radius.circular(15.0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 3, color: appColors.grey),
                borderRadius: const BorderRadius.all(Radius.circular(15.0)),
              ),

              // Eye icon for toggling password visibility
              suffixIcon: Padding(
                padding: const EdgeInsets.only(right: 10.0), // Add right padding
                child: IconButton(
                  iconSize: 24,
                  icon: Icon(
                    isTextObscured ? Icons.visibility_off : Icons.visibility,
                    color: appColors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      isTextObscured = !isTextObscured;
                    });
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
