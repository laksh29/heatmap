import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DisplayTextTheme {
  const DisplayTextTheme();
  TextStyle fromString(String? s) {
    switch (s) {
      case "large":
        return large;
      case "small":
        return small;
      case "extraSmall":
        return extraSmall;
      case "medium":
      default:
        return medium;
    }
  }

  TextStyle get large => GoogleFonts.nunitoSans(
        fontSize: 57,
        fontWeight: FontWeight.bold,
        height: 1.2,
        color: Colors.black,
        letterSpacing: -0.25,
      );

  TextStyle get medium => GoogleFonts.nunitoSans(
        fontSize: 45,
        fontWeight: FontWeight.bold,
        height: 1.15,
        color: Colors.black,
        letterSpacing: -0.25,
      );

  TextStyle get small => GoogleFonts.nunitoSans(
        fontSize: 36,
        fontWeight: FontWeight.bold,
        height: 1.22,
        color: Colors.black,
        letterSpacing: -0.25,
      );
  TextStyle get extraSmall => GoogleFonts.nunitoSans(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        height: 1.14,
        color: Colors.black,
        letterSpacing: -0.25,
      );
}
