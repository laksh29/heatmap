import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TitleTextTheme {
  const TitleTextTheme();

  TextStyle fromString(String? s) {
    switch (s) {
      case "large":
        return large;
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

  TextStyle get mediumRegular => GoogleFonts.nunito(
        fontSize: 16,
        height: 1.3,
        color: Colors.black,
      );

  TextStyle get small => GoogleFonts.nunito(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        height: 1.5,
        color: Colors.black,
      );
  TextStyle get smallRegular => GoogleFonts.nunito(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        height: 1.5,
        color: Colors.black,
      );
}
