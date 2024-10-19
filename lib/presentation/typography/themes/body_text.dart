import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BodyTextTheme {
  const BodyTextTheme();
  TextStyle fromString(String? s) {
    switch (s) {
      case "large":
        return large;
      case "largeRegular":
        return largeRegular;
      case "mediumBold":
        return mediumBold;
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
        fontSize: 14,
        fontWeight: FontWeight.bold,
        height: 1.5,
        color: Colors.black,
      );

  TextStyle get largeRegular => GoogleFonts.nunito(
        fontSize: 14,
        height: 1.5,
        color: Colors.black,
      );

  TextStyle get medium => GoogleFonts.nunito(
        fontSize: 12,
        height: 1.2,
        color: Colors.black,
      );
  TextStyle get mediumBold => GoogleFonts.nunito(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        height: 1.2,
        color: Colors.black,
      );

  TextStyle get small => GoogleFonts.nunito(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        height: 1.3,
        color: Colors.black,
      );

  TextStyle get smallRegular => GoogleFonts.nunito(
        fontSize: 11,
        height: 1.3,
        color: Colors.black,
      );
}
