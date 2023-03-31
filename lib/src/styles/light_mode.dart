import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightMode = ThemeData(
    brightness: Brightness.light,
    // scaffoldBackgroundColor: const Color.fromARGB(233, 255, 255, 255),
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFF321A4E), // APP bar +
      onPrimary: Color(0xFF5B4B8A), // button 01
      primaryContainer: Color(0xFFF6AD10), // bag
      secondary: Color.fromARGB(255, 25, 14, 39), // search field
      onSecondary: Colors.white, // white text
      background: Color(0xFFD9D9D9),
      surface: Color(0xFF7858A6),
      onSurface: Color(0xFF040E32),
      outline: Color(0xFF040E32), // scond 01
      onBackground: Color(0xFF646464), // disabled
      error: Colors.red,
      onError: Colors.red,
    ),
    textTheme: TextTheme(
      //headline 1
      titleMedium: GoogleFonts.rubik(
        fontWeight: FontWeight.normal,
        fontSize: 35,
      ),
      //headline 1 bold
      titleLarge: GoogleFonts.rubik(
        fontWeight: FontWeight.bold,
        fontSize: 35,
      ),
      //headline 2
      headlineMedium: GoogleFonts.rubik(
        fontWeight: FontWeight.normal,
        fontSize: 24,
      ),
      //headline 2 bold
      headlineLarge: GoogleFonts.rubik(
        fontWeight: FontWeight.bold,
        fontSize: 24,
      ),
      // headline 3
      displayMedium: GoogleFonts.rubik(
        fontWeight: FontWeight.normal,
        fontSize: 20,
        letterSpacing: 0.15,
      ),
      // headline 3 bold
      displayLarge: GoogleFonts.rubik(
        fontWeight: FontWeight.bold,
        fontSize: 20,
        letterSpacing: 0.15,
      ),
      bodyMedium: GoogleFonts.rubik(
        fontWeight: FontWeight.normal,
        fontSize: 16,
        letterSpacing: 0.5,
      ),
      bodyLarge: GoogleFonts.rubik(
        fontWeight: FontWeight.bold,
        fontSize: 16,
        letterSpacing: 0.5,
      ),
      bodySmall: GoogleFonts.rubik(
        fontWeight: FontWeight.normal,
        fontSize: 14,
        letterSpacing: 0.25,
      ),
      labelLarge: GoogleFonts.rubik(
        fontWeight: FontWeight.bold,
        fontSize: 14,
        letterSpacing: 0.25,
      ),
      // button
      labelMedium: GoogleFonts.rubik(
        fontWeight: FontWeight.w500,
        fontSize: 15,
        letterSpacing: 1.25,
      ),
      labelSmall: GoogleFonts.rubik(
        fontWeight: FontWeight.normal,
        fontSize: 12,
        letterSpacing: 0.4,
      ),
      headlineSmall: GoogleFonts.rubik(
        fontWeight: FontWeight.w600,
        fontSize: 12,
        letterSpacing: 0.4,
      ),
      titleSmall: GoogleFonts.rubik(
        fontWeight: FontWeight.normal,
        fontSize: 10,
        letterSpacing: 1.5,
      ),
    ));
