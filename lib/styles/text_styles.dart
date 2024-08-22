import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Google Fonts can't be const, so AppTextStyles can't have const constructor
class AppTextStyles {

  final TextStyle heading1 = GoogleFonts.openSans(
    color: Colors.black,
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  final TextStyle bodyText = GoogleFonts.openSans(
    color: Colors.black,
    fontSize: 24,
    fontWeight: FontWeight.normal,
  );

  final TextStyle bodyTextWhite = GoogleFonts.openSans(
    color: Colors.white,
    fontSize: 24,
    fontWeight: FontWeight.normal,
  );

  final TextStyle caption = GoogleFonts.openSans(
    color: Color(0xff939393),
    fontSize: 12,
    fontWeight: FontWeight.bold,
  );
}
