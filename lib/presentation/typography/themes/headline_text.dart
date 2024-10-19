import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeadlineTextTheme {
  const HeadlineTextTheme();
  TextStyle fromString(String? s) {
    switch (s) {
      case "large":
        return large;
      case "largeRegular":
        return largeRegular;
      case "mediumRegular":
        return mediumRegular;
      case "small":
        return small;
      case "smallRegular":
        return smallRegular;
      case "medium":
      default:
        return medium;
    }
  }

  TextStyle get large => GoogleFonts.nunito(
        fontSize: 34,
        fontWeight: FontWeight.bold,
        height: 1.18,
        color: Colors.black,
      );

  TextStyle get largeRegular => GoogleFonts.nunito(
        fontSize: 34,
        height: 1.18,
        color: Colors.black,
      );

  TextStyle get medium => GoogleFonts.nunito(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        height: 1.4,
        color: Colors.black,
      );

  TextStyle get mediumRegular => GoogleFonts.nunito(
        fontSize: 24,
        height: 1.4,
        color: Colors.black,
      );

  TextStyle get small => GoogleFonts.nunito(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        height: 1.3,
        color: Colors.black,
      );

  TextStyle get smallRegular => GoogleFonts.nunito(
        fontSize: 20,
        height: 1.3,
        color: Colors.black,
      );
}
