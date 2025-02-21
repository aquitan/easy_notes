import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// light theme
ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  fontFamily: GoogleFonts.jost().fontFamily,
  cardColor: Colors.white,
  colorScheme: ColorScheme.light(
    surface: Colors.grey.shade300,
		primary: Color.fromRGBO(234, 100, 43, 1),
		secondary: Colors.grey.shade400,
		tertiary: Colors.grey.shade800
  ),
);


// dark theme

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  fontFamily: GoogleFonts.jost().fontFamily,
  cardColor: Colors.black,
  colorScheme: ColorScheme.dark(
		surface: Colors.grey.shade900,
		primary: Color.fromRGBO(234, 100, 43, 1),
		secondary: Colors.grey.shade700,
		tertiary: Colors.grey.shade300
	),
);
