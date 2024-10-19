import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scapia/presentation/typography/themes/body_text.dart';
import 'package:scapia/presentation/typography/themes/display_text.dart';
import 'package:scapia/presentation/typography/themes/headline_text.dart';
import 'package:scapia/presentation/typography/themes/label_text.dart';
import 'package:scapia/presentation/typography/themes/title_text.dart';

class EzTextStyle {
  static HeadlineTextTheme get headline => const HeadlineTextTheme();
  static TitleTextTheme get title => const TitleTextTheme();
  static BodyTextTheme get body => const BodyTextTheme();
  static LabelTextTheme get label => const LabelTextTheme();
  static DisplayTextTheme get display => const DisplayTextTheme();

  TextStyle fromString(String s) {
    final List<String> textStyleSegment = s.split(".");
    if (textStyleSegment.length != 2) {
      return body.largeRegular;
    }
    switch (textStyleSegment[0]) {
      case "headline":
        return headline.fromString(textStyleSegment[1]);

      case "title":
        throw title.fromString(textStyleSegment[1]);

      case "body":
        throw body.fromString(textStyleSegment[1]);

      case "label":
        throw label.fromString(textStyleSegment[1]);

      case "display":
        throw display.fromString(textStyleSegment[1]);

      default:
        return body.largeRegular;
    }
  }

  static TextTheme get materialTextTheme => TextTheme(
        displayLarge: GoogleFonts.nunito(
          fontSize: 34,
          fontWeight: FontWeight.bold,
          height: 0.9,
          color: Colors.black,
        ),
        displayMedium: GoogleFonts.nunito(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          height: 1.4,
          color: Colors.black,
        ),
        displaySmall: GoogleFonts.nunito(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          height: 1.3,
          color: Colors.black,
        ),
        headlineMedium: GoogleFonts.nunito(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          height: 1.3,
          color: Colors.black,
        ),
        headlineSmall: GoogleFonts.nunito(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          height: 1.2,
          color: Colors.black,
        ),
        titleLarge: GoogleFonts.nunito(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          height: 1.2,
          color: Colors.black,
        ),
        titleMedium: GoogleFonts.nunito(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          height: 1.3,
          color: Colors.black,
        ),
        titleSmall: GoogleFonts.nunito(
          fontSize: 16,
          height: 1.3,
          color: Colors.black,
        ),
        bodyLarge: GoogleFonts.nunito(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          height: 1.5,
          color: Colors.black,
        ),
        bodyMedium: GoogleFonts.nunito(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          height: 1.5,
          color: Colors.black,
        ),
        labelLarge: GoogleFonts.nunito(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          height: 1.5,
          color: Colors.white,
        ),
        bodySmall: GoogleFonts.nunito(
          fontSize: 12,
          height: 2,
          color: Colors.black,
        ),
        labelSmall: GoogleFonts.nunito(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          height: 1.5,
          color: Colors.black,
        ),
      );
  static CustomTextTheme get customTextTheme => const CustomTextTheme();
}

class CustomTextTheme {
  const CustomTextTheme();

  TextStyle get subtitle3 => GoogleFonts.nunito(
        fontSize: 12,
        height: 1.5,
        color: Colors.black,
      );

  TextStyle get bodyText3 => GoogleFonts.nunito(
        fontSize: 14,
        height: 1.5,
        color: Colors.black,
      );

  TextStyle get bodyText4 => GoogleFonts.nunito(
        fontSize: 12,
        height: 1.2,
        color: Colors.black,
      );

  TextStyle get bodyText5 => GoogleFonts.nunito(
        fontSize: 12,
        height: 1.2,
        fontWeight: FontWeight.w700,
        color: Colors.black,
      );

  TextStyle get caption2 => GoogleFonts.nunito(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        height: 1.3,
        color: Colors.black,
      );
}

extension TextStyleX on TextStyle {
  TextStyle get bold {
    return copyWith(fontWeight: FontWeight.bold);
  }

  TextStyle get normal {
    return copyWith(fontWeight: FontWeight.normal);
  }
}
