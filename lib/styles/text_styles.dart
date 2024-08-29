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

  final TextStyle mediumBodyText = GoogleFonts.openSans(
    color: Colors.black,
    fontSize: 20,
    fontWeight: FontWeight.normal,
  );

  final TextStyle smallBodyText = GoogleFonts.openSans(
    color: Colors.black,
    fontSize: 16,
    fontWeight: FontWeight.normal,
  );

  final TextStyle bodyTextWhite = GoogleFonts.openSans(
    color: Colors.white,
    fontSize: 24,
    fontWeight: FontWeight.normal,
  );

  final TextStyle mediumBodyTextWhite = GoogleFonts.openSans(
    color: Colors.white,
    fontSize: 20,
    fontWeight: FontWeight.normal,
  );

  final TextStyle smallBodyTextWhite = GoogleFonts.openSans(
    color: Colors.white,
    fontSize: 16,
    fontWeight: FontWeight.normal,
  );

  final TextStyle caption = GoogleFonts.openSans(
    color: Color(0xff939393),
    fontSize: 12,
    fontWeight: FontWeight.bold,
  );


  TextStyle customBodyText(Color color, double size) {
    return GoogleFonts.openSans(
      color: color,
      fontSize: size,
      fontWeight: FontWeight.normal,
    );
  }

  TextStyle customText(Color color, double size, FontWeight weight) {
    return GoogleFonts.openSans(
      color: color,
      fontSize: size,
      fontWeight: weight,
    );
  }

}
