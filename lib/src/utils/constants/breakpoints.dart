import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

/// Layout breakpoints used in the app.
class Breakpoint {
  static const double desktop = 1000;
  static const double tablet = 600;
}

Color backgroundColor = const Color(0xffDAE1E7);
Color primaryFontColor = const Color(0xff162E50);

Color primaryColor = const Color(0xff183661);
Color secondaryColor = const Color(0xff1C4B82);

Color buttonColor = const Color(0xffDD6B4D);

// TextStyle headline1Bold(Color color) => GoogleFonts.robotoFlex(
//     color: color,
//     fontSize: 35,
//     fontWeight: FontWeight.w700,
//     letterSpacing: 0.25);
TextStyle headline1(Color color) => GoogleFonts.robotoFlex(
    color: color,
    fontSize: 35,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25);
TextStyle headline2(Color color) => GoogleFonts.robotoFlex(
      color: color,
      fontSize: 25,
      fontWeight: FontWeight.w400,
    );
TextStyle headline2Bold(Color color) => GoogleFonts.robotoFlex(
      color: color,
      fontSize: 25,
      fontWeight: FontWeight.w700,
    );

TextStyle headline3(Color color) => GoogleFonts.robotoFlex(
    color: color,
    fontSize: 21,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.15);
TextStyle headline3Bold(Color color) => GoogleFonts.robotoFlex(
      color: color,
      fontSize: 21,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.15,
    );

TextStyle bodyLarge(Color color) => GoogleFonts.robotoFlex(
    color: color,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25);
TextStyle bodyLargeBold(Color color) => GoogleFonts.robotoFlex(
      color: color,
      fontSize: 16,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.25,
    );

TextStyle bodySmall(Color color) => GoogleFonts.robotoFlex(
    color: color,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25);
TextStyle bodySmallBold(Color color) => GoogleFonts.robotoFlex(
      color: color,
      fontSize: 14,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.25,
    );

TextStyle buttonStyle(Color color) => GoogleFonts.robotoFlex(
      color: color,
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 1.25,
    );

TextStyle captionStyle(Color color) => GoogleFonts.robotoFlex(
      color: color,
      fontSize: 12,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.4,
    );
