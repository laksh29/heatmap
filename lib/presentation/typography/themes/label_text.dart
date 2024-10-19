import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LabelTextTheme {
  const LabelTextTheme();
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

  TextStyle get large => GoogleFonts.nunito(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        height: 1.2,
        color: Colors.black,
      );

  TextStyle get medium => GoogleFonts.nunito(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        height: 1.3,
        color: Colors.black,
      );

  TextStyle get small => GoogleFonts.nunito(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        height: 1.5,
        color: Colors.black,
      );

  TextStyle get extraSmall => GoogleFonts.nunito(
        fontSize: 10,
        fontWeight: FontWeight.bold,
        height: 1.3,
        color: Colors.black,
      );
}
